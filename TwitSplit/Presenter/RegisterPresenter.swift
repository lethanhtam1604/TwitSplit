//
//  RegisterPresenter.swift
//  TwitSplit
//
//  Created by Thanh Tam Le on 10/5/17.
//  Copyright © 2017 Thanh Tam Le. All rights reserved.
//

import UIKit

// Mark: - Protocol for RegisterViewController
protocol RegisterView: class {
    func startLoading()
    func finishLoading()
    func register()
}

// Mark: - LoginPresenter is a mediator between the LoginViewControler and the Model
class RegisterPresenter: NSObject {
    
    weak fileprivate var registerView: RegisterView?
    
    func attachView(view: RegisterView) {
        registerView = view
    }
    
    func detachView() {
        registerView = nil
    }
    
    func register() {
        registerView?.register()
    }
}
