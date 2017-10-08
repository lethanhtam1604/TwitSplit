//
//  TwitterPart.swift
//  TwitSplit
//
//  Created by Thanh Tam Le on 10/7/17.
//  Copyright © 2017 Thanh Tam Le. All rights reserved.
//

import UIKit

class TwitterPart: NSObject {
    
    // Part index
    fileprivate var index: Int
    
    // Part index
    fileprivate var total: Int
    
    // Part message
    fileprivate var text: String

    // Mark: - Init
    init(_ index: Int, total: Int = 0,_ text: String) {
        self.index = index
        self.text = text
        self.total = total
    }
    
    // Mark: Update total part
    func updateTotalPart(_ total: Int) {
        self.total = total
    }
    
    // Return message with indicator
    func build() -> Message {
        let message = Message("\(index)/\(total) " + text)
        return message
    }
}
