//
//  User.swift
//  TwitSplit
//
//  Created by Thanh Tam Le on 10/5/17.
//  Copyright © 2017 Thanh Tam Le. All rights reserved.
//

import UIKit

class User: NSObject {
    
    var name: String
    var email: String
    var phoneNumber: String
    
    // Mark: - Init
    init(_ name: String, _ email: String, _ phoneNumber: String) {
        self.name = name
        self.email = email
        self.phoneNumber = phoneNumber
    }
}
