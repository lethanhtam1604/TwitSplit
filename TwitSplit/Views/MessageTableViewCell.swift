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
        bindingDataHeightForCell(twitter)
    }
}

// Mark: - Setup Height Cell
extension MessageTableViewCell {
    
    func bindingDataHeightForCell(_ twitter: Twitter) {
        nameLabel.text = twitter.user.name
        messageLabel.text = twitter.message.text
    }
    
    func heightForCell() -> CGFloat {
        
        // Get name height
        let nameHeight = NSString(string: nameLabel.text ?? "").boundingRect(with: CGSize(width: frame.width - 20, height: 1000), options: NSStringDrawingOptions.usesFontLeading.union(NSStringDrawingOptions.usesLineFragmentOrigin), attributes: [NSAttributedStringKey.font: nameLabel.font], context: nil)
        
        // Get message height
        let messageHeight = NSString(string: messageLabel.text ?? "").boundingRect(with: CGSize(width: frame.width - 20, height: 1000), options: NSStringDrawingOptions.usesFontLeading.union(NSStringDrawingOptions.usesLineFragmentOrigin), attributes: [NSAttributedStringKey.font: messageLabel.font], context: nil)
        
        return nameHeight.height + 5 + messageHeight.height + 20
    }
}
