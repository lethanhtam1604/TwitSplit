//
//  MessageInputBarView.swift
//  TwitSplit
//
//  Created by Thanh Tam Le on 10/5/17.
//  Copyright © 2017 Thanh Tam Le. All rights reserved.
//

import UIKit

protocol MessageInputBarDelegate: class {
    func actionTapToSendButton()
}

class MessageInputBarView: UIView {

    // Mark: - Outlet
    @IBOutlet fileprivate var contentView: MessageInputBarView!
    @IBOutlet fileprivate weak var inputTextView: GrowingTextView!
    @IBOutlet fileprivate weak var sendButton: UIButton!
    
    // Mark: - Variables
    weak var delegate: MessageInputBarDelegate?

    // Mark: - View Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commoninit()
        
    }
    
    // Mark: - View Cycle
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commoninit()
    }
    
    @IBAction func actionTapToSendButton(_ sender: Any) {
        delegate?.actionTapToSendButton()
    }
}

// Mark: - Setup MessageInputBarView
extension MessageInputBarView {
    
    fileprivate func commoninit() {
        Bundle.main.loadNibNamed("MessageInputBarView", owner: self, options: nil)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        addSubview(contentView)
    
        inputTextView.layer.cornerRadius = 5
        inputTextView.placeHolder = "Enter your message here..."
        inputTextView.maxHeight = 150
    }
}

// Mark: - Get values
extension MessageInputBarView {
    
    func getMessage() -> String {
        return inputTextView.text
    }
    
    func setEmptyMessage() {
        inputTextView.text = ""
    }
}
