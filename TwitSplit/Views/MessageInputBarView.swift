//
//  MessageInputBarView.swift
//  TwitSplit
//
//  Created by Thanh Tam Le on 10/5/17.
//  Copyright © 2017 Thanh Tam Le. All rights reserved.
//

import UIKit

@IBDesignable
class MessageInputBarView: UIView {

    // Mark: - Outlet

    @IBOutlet fileprivate var contentView: MessageInputBarView!
    @IBOutlet fileprivate weak var inputTextView: UITextView!
    @IBOutlet fileprivate weak var sendButton: UIButton!
    
    // Mark: - Variables
    
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
    
    }
}

// Mark: - Private
extension MessageInputBarView {
    
    fileprivate func commoninit() {
        Bundle.main.loadNibNamed("MessageInputBarView", owner: self, options: nil)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        addSubview(contentView)
    
        inputTextView.layer.cornerRadius = 5
    }
}


