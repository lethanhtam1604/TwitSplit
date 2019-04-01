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
    @IBOutlet fileprivate weak var avatarImgView: UIImageView!
    @IBOutlet fileprivate weak var nameLabel: UILabel!
    @IBOutlet fileprivate weak var messageLabel: UILabel!
    
    // Mark: - Variables
    static let kCellId = "MessageTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        avatarImgView.layer.cornerRadius = 20
        
        layer.cornerRadius = 5
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowOffset = CGSize(width: 0.2, height: 0.2)
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 1
        layer.masksToBounds = false
    }
    
    // Mark: - Binding data for cell
    func bindingData(_ twitter: Twitter) {
        nameLabel.text = twitter.user.name
        messageLabel.text = twitter.message.text
        avatarImgView.loadImagesUsingUrlString(urlString: twitter.user.avatar)
        
        DispatchQueue.main.async {
            self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        }
    }
}
