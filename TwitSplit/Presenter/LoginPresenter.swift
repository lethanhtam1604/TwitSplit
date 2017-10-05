//
//  LoginPresenter.swift
//  TwitSplit
//
//  Created by Thanh Tam Le on 10/5/17.
//  Copyright © 2017 Thanh Tam Le. All rights reserved.
//

import UIKit

// Mark: - Protocol for LoginViewController
protocol LoginView: class {
    func startLoading()
    func finishLoading()
    func login()
}

// Mark: - LoginPresenter is a mediator between the LoginViewControler and the Model
class LoginPresenter: NSObject {

    weak fileprivate var loginView: LoginView?
    
    func attachView(view: LoginView) {
        loginView = view
    }
    
    func detachView() {
        loginView = nil
    }
    
    func login() {
        loginView?.login()
    }
}
