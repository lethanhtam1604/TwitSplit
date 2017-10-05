//
//  MessagesPresenter.swift
//  TwitSplit
//
//  Created by Thanh Tam Le on 10/5/17.
//  Copyright © 2017 Thanh Tam Le. All rights reserved.
//

import UIKit

// Mark: - Protocol for RegisterViewController
protocol MessagesView: class {
    func startLoading()
    func finishLoading()
    func splitMessage()
}

// Mark: - MessagesPresenter is a mediator between the MessagesViewControler and the Model
class MessagesPresenter: NSObject {
    
    weak fileprivate var messagesView: MessagesView?
    
    func attachView(view: MessagesView) {
        messagesView = view
    }
    
    func detachView() {
        messagesView = nil
    }
    
    func splitMessage() {
        messagesView?.splitMessage()
    }
}
