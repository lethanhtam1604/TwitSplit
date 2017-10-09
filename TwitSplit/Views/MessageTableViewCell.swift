//
//  MessageTableViewCell.swift
//  TwitSplit
//
//  Created by Thanh Tam Le on 10/5/17.
//  Copyright © 2017 Thanh Tam Le. All rights reserved.
//

import UIKit

class MessageTableViewCell: UITableViewCell {
    
    // Mark: - Outlet
    @IBOutlet fileprivate weak var nameLabel: UILabel!
    @IBOutlet fileprivate weak var messageLabel: UILabel!
    
    // Mark: - Variables
    static let kCellId = "MessageTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // Mark: - Binding data for cell
    func bindingData(_ twitter: Twitter) {
        nameLabel.text = twitter.user.name
        messageLabel.text = twitter.message.text
    }
}
