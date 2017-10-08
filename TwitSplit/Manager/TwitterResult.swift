//
//  TwitterResult.swift
//  TwitSplit
//
//  Created by Thanh Tam Le on 10/5/17.
//  Copyright © 2017 Thanh Tam Le. All rights reserved.
//

import UIKit

// Mark: error cases of splitting the message
enum Error {
    
    case empty()
    case nonWhitespace()
    
    var result: String {
        switch self {
        case .empty:
            return "Invalid message"
        case .nonWhitespace:
            return "The message contains a span of non-whitespace characters longer than 50 characters"
        }
    }
}

// Mark: Result of splitting the message
enum TwitterResult {
    
    typealias T = [Message]

    case success(T)
    case error(String)

    func isSuccess() -> T? {
        switch self {
        case .success(let messages):
            return messages
        default:
            return nil
        }
    }
    
    func isError() -> String {
        switch self {
        case .error(let error):
            return error
        default:
            return ""
        }
    }
}
