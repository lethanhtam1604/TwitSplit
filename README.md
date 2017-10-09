# TwitSplit Assignment
This application Tweeter allows users to post short messages limited to 50 characters each. Sometimes, users get excited and write messages longer than 50 characters. Instead of rejecting these messages, we would like to add a new feature that will split the message into parts and send multiple messages on the user's behalf, all of them meeting the 50 character requirement.

# Application Development Environment

+ IDE: Xcode 9
+ Language: Swift 4

# Installation

Navigate to workspace directory.
```
pod install
```

# 3rd-parties 
+ IQKeyboardManagerSwift

# Architecture Pattern

I used MVP design pattern to resolve massive view controller instead of MVC traditional pattern in iOS.

# Swiftlint

I used this library to refactor code, setup some rules in coding such as naming variables, function names, maximum number of lines in a class, enforce Swift style and conventions.

# Auto Layout

Used Auto Layout to design User of Interface for supporting multiple device.

# App Module
+ Managers: To manage local database
+ Models: Model objects encapsulate the data specific to an application and define the logic and computation that manipulate and process that data
+ Presenter: It contains business logic for each controller.
+ Storyboards: It is divided into multiple storyboard to help other developer maintain UI in the future
+ ViewControllers: It contains controllers of UI View: It contains custom view cell
+ Views: It contains custom cell view
+ Resources: Fonts, Assets, Localizable.strings, etc

# Message Splitter Algorithm
+ Time complexity: O(N) with N is number of characters of the message
  ## My approach:
  + The First: Try split the message with number of digits K that is Number of digits of (Length of message / max Twitter Character Count (50))
  + The Second: If we can't split, we increase K value by 1 (K = K + 1) and try split the message again. If we can't get split return nil, otherwise return list of message parts that is splitted
  
  
  ```js
  
    fileprivate func processMessage(_ message: String) -> TwitterResult {
        
        // Estimate number of digits of indicator
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
    
  ```
# ScreenShots
<img src="https://github.com/lethanhtam1604/TwitSplit/blob/master/Screenshots/Messages.png" width="400" height="400"> <img src="https://github.com/lethanhtam1604/TwitSplit/blob/master/Screenshots/Settings.png" width="400" height="400">
