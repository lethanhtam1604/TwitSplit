//
//  TwitterManager.swift
//  TwitSplit
//
//  Created by Thanh Tam Le on 10/5/17.
//  Copyright © 2017 Thanh Tam Le. All rights reserved.
//

import UIKit

// Mark: - TwitterManager is responsible for returning the message into parts
class TwitterManager: NSObject {

    // Mark: - Init
    override init() {
        
    }
    
    // Mark: - Return parts from the message
    func splitMesssage(_ message: String) -> TwitterResult {
        let twitterAlgorithm = TwitterAlgorithm()
        return twitterAlgorithm.twitterSplit(message)
    }
}
