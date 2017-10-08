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
    func splitMessageCompleted(_ twitterResult: TwitterResult)
}

// Mark: - MessagesPresenter is a mediator between the MessagesViewControler and the Model
class MessagesPresenter: NSObject {
    
    // Mark: - Variables
    weak fileprivate var messagesView: MessagesView?
    fileprivate let twitterAlgorithm = TwitterAlgorithm()

    func attachView(view: MessagesView) {
        messagesView = view
    }
    
    func detachView() {
        messagesView = nil
    }
    
    func splitMessage(_ message: String) {
        messagesView?.startLoading()
        // Split the message on background thread
        DispatchQueue.global().async {
            let twitterResult = self.twitterAlgorithm.twitterSplit(message)
            
            // Update result of the message on main thread
            DispatchQueue.main.async {
                self.messagesView?.splitMessageCompleted(twitterResult)
                self.messagesView?.finishLoading()
            }
        }
    }
}
