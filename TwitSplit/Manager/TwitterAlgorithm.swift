//
//  TwitterAlgorithm.swift
//  TwitSplit
//
//  Createle by Thanh Tam Le on 10/5/17.
//  Copyright © 2017 Thanh Tam Le. All rights reserved.
//

import UIKit

// Mark: - Result Split
// success: split message success
// excess: message is excess (greater than 50 characters without white space)
// error: split message error with K
private enum ResultSplit {
    case success
    case excess
    case error
}

// Mark: - TwitterManager is responsible for splitting the message into parts
class TwitterAlgorithm: NSObject {
    
    // Mark: - Variables
    fileprivate var indexPart = 1
    fileprivate var twitterParts: [TwitterPart] = []
    
    // Mark: - Init
    override init() {
        
    }
    
    // Mark: - Split the message
    func twitterSplit(_ message: String) -> TwitterResult {
        
        // Remove all the whitespace from the beginning and end of a String
        let newMesssage = message.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        // Message is emplty
        if newMesssage.isEmpty {
            return TwitterResult.error(Error.empty().result)
        }
        
        // If lengh of message is less than or equal the maximum count (50 characters) -> Just return
        if newMesssage.count <= TwitterValue.maxTwitterCharacterCount {
            return TwitterResult.success([Message(newMesssage)])
        }
        
        // Split the message
        return processMessage(newMesssage)
    }
    
    // Mark: - Split the message into parts
    // Time complexity: O(N) with N is number of characters of the message
    fileprivate func processMessage(_ message: String) -> TwitterResult {
        
        // Estimate number of digits of total part
        var K = numberOfDigits(message.count / TwitterValue.maxTwitterCharacterCount)

        // Try to split the message first with K
        switch trySplitTheMessageWith(message, K) {
        case .error:
            // Try to split the message second with K is increased by 1
            K += 1
            _ = trySplitTheMessageWith(message, K)
        case .excess:
            return TwitterResult.error(Error.nonWhitespace().result)
        case .success:
            break
        }
        
        // Return result
        let messages = twitterParts.map { $0.build() }
        return TwitterResult.success(messages)
    }
    
    // Length of a message part = Length of indicator and whitespace + Length of text <= 50 (EX: "IndexPart/TotalPart" + " " +  text). But we actually don't know total part. So, I determined total part the following:
    // + The first: Estimate number of digits of total page: K = numberOfDigits(message.count / 50). And then we can calculate length of indicator: indicatorCharacterCount = numberOfDigits(indexPart) + 1 + K + 1 // 1 first is "/" character and 1 second is white space
    // + The Second: Try to split the message with K.
    // + The Third: If we can't split the message (Length of total part is greater than K), we increase K value by 1 (K = K + 1) and try split the message again. If we can't get split return nil, otherwise return list of message parts that is splitted
    fileprivate func trySplitTheMessageWith(_ message: String, _ K: Int) -> ResultSplit {
        
        // Init variables
        indexPart = 1
        twitterParts = []
        
        // Number of characters of indicator and whitespace (EX: "1/1 ")
        var indicatorCharacterCount = numberOfDigits(indexPart) + 1 + K + 1 // 1 first is "/" character and 1 second is white space

        // Init indexBegin and indexEnd
        var indexBegin = 0
        var indexEnd = indexBegin + TwitterValue.maxTwitterCharacterCount - indicatorCharacterCount
        
        // indexBegin is first index of message that we need to split
        // indexEnd is end index of message that we need to split
        // For example the following message: "I can't believe Tweeter now supports chunking my messages, so I don't have to do it myself."
        // The First: indexBegin = 0, indexEnd = indexBegin + 50 - Number of characters of indicator and whitespace ("1/K " = 4) = 46. And then we run from indexEnd to indexBegin to find white space index (indexWhiteSpace) and split the message between indexBegin and indexWhiteSpace
        // The Second: indexBegin = indexWhiteSpace + 1, indexEnd = indexBegin + 50 - Number of characters of indicator and whitespace ("2/K "). The we slit the message like the first step.
        // The Third: indexBegin = indexWhiteSpace + 1, indexEnd = indexBegin + 50 - Number of characters of indicator and whitespace ("3/K "). The we slit the message like the first step.
        // And so on...
        
        while indexEnd < message.count {
            
            var indexWhiteSpace = 0
            var isExcess = true
            
            // we run from indexEnd to indexBegin to find index of the whitespace
            for index in stride(from: indexEnd, to: indexBegin, by: -1) {
                if message[index] == " " {
                    isExcess = false
                    indexWhiteSpace = index
                    break
                }
            }
            
            // Check the message is not excessed yet (less than or equal 50 characters) and split that message
            if !isExcess {
                // Split the message at between indexBegin and indexWhiteSpace
                let messagePart = message[indexBegin..<indexWhiteSpace]

                // Add message part is splitted to array
                let twitterPart = TwitterPart(indexPart, messagePart)
                twitterParts.append(twitterPart)
                
                // Increase indexPart by 1
                indexPart += 1
                
                // Update indexBegin value
                indexBegin = indexWhiteSpace + 1
                
                // Update indicatorCharacterCount value
                indicatorCharacterCount = numberOfDigits(indexPart) + 1 + K + 1

                // Update indexEnd value
                indexEnd = indexBegin + TwitterValue.maxTwitterCharacterCount - indicatorCharacterCount
            } else {
                return ResultSplit.excess
            }
            
            // Split the message error at the first time and we will split the message at the second time by increasing K by 1
            if numberOfDigits(indexPart) > K {
                return ResultSplit.error
            }
        }
        
        // Add last one
        if indexBegin < message.count {
            let messagePart = message[indexBegin..<message.count]
            let twitterPart = TwitterPart(indexPart, messagePart)
            twitterParts.append(twitterPart)
        }
        
        // It's time to update total part
        twitterParts.forEach { $0.updateTotalPart(indexPart) }
        
        return ResultSplit.success
    }
    
    // Mark: - Get number of digits
    fileprivate func numberOfDigits(_ n: Int) -> Int {
        if(n == 0) {
            return 0
        } else {
            return 1 + numberOfDigits(n / 10)
        }
    }
}
