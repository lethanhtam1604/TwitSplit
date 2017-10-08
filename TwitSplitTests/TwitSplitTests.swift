//
//  TwitSplitTests.swift
//  TwitSplitTests
//
//  Created by Thanh Tam Le on 10/8/17.
//  Copyright © 2017 Thanh Tam Le. All rights reserved.
//

import XCTest
@testable import TwitSplit

extension Array where Element == Message {
    
    func mapToString() -> [String] {
        return self.map{ (i) -> String in
            return i.text
        }
    }
}

class TwitSplitTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // This is test case for the message is greater than 50 characters
    func testCase1() {
        let twitterAlgorithm = TwitterAlgorithm()
        let twitterResult = twitterAlgorithm.twitterSplit("I can't believe Tweeter now supports chunking my messages, so I don't have to do it myself.")
        let expected = ["1/2 I can't believe Tweeter now supports chunking", "2/2 my messages, so I don't have to do it myself."]
        
        XCTAssertEqual(twitterResult.isSuccess()!.mapToString(), expected, "successfully")
    }
    
    // This is test case for the message is less than 50 characters
    func testCase2() {
        let twitterAlgorithm = TwitterAlgorithm()
        let twitterResult = twitterAlgorithm.twitterSplit("Le Thanh Tam")
        
        let expected = ["Le Thanh Tam"]
        
        XCTAssertEqual(twitterResult.isSuccess()!.mapToString(), expected, "successfully")
    }
    
    // This is test case for the message contains a span of non-whitespace characters longer than 50 characters
    func testCase3() {
        let twitterAlgorithm = TwitterAlgorithm()
        let twitterResult = twitterAlgorithm.twitterSplit("aaaaa bbbbb qwertyuiopasdfghjklzxcvbnmqwertyuiopqwertyuiopa")
        
        let expected = "The message contains a span of non-whitespace characters longer than 50 characters"
        
        XCTAssertEqual(twitterResult.isError(), expected, "successfully")
    }
    
    // This is test case for empty message
    func testCase4() {
        let twitterAlgorithm = TwitterAlgorithm()
        let twitterResult = twitterAlgorithm.twitterSplit("")
        
        let expected = "Invalid message"
        
        XCTAssertEqual(twitterResult.isError(), expected, "successfully")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {

            // Put the code you want to measure the time of here.
        }
    }
}
