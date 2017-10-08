//
//  Twitter.swift
//  TwitSplit
//
//  Created by Thanh Tam Le on 10/5/17.
//  Copyright © 2017 Thanh Tam Le. All rights reserved.
//

import UIKit

class Twitter: NSObject {

    var user: User
    var message: Message

    // Mark: - Init
    init(_ user: User, _ message: Message) {
        self.user = user
        self.message = message
    }
}
