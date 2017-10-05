//
//  String.swift
//  TwitSplit
//
//  Created by Thanh Tam Le on 10/5/17.
//  Copyright © 2017 Thanh Tam Le. All rights reserved.
//

import UIKit

extension String {

    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    func isValidPhone() -> Bool {
        let components = self.components(separatedBy: NSCharacterSet.decimalDigits.inverted)
        let decimalString = components.joined(separator: "")
        
        let PHONE_REGEX = "^((\\+)|())[0-9]{3,20}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: decimalString)
        return result
    }
    
    func isValidAccount() -> Bool {
        let RegEx = "\\A\\w{1,18}\\z"
        let accountTest = NSPredicate(format:"SELF MATCHES %@", RegEx)
        return accountTest.evaluate(with: self)
    }
    
    func isValidPassword() -> Bool {
        let RegEx = ".{6,18}"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", RegEx)
        let result =  passwordTest.evaluate(with: self)
        return result
    }
    
    func isValidName() -> Bool {
        let RegEx = ".{1,50}"
        let nameTest = NSPredicate(format: "SELF MATCHES %@", RegEx)
        let result =  nameTest.evaluate(with: self)
        return result
    }
}
