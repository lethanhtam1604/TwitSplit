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
    
    func bindingData() {
        
    }
}

// Mark: - Setup Height Cell
extension MessageTableViewCell {
    
    func bindingDataHeightForCell() {
       
    }
    
    func heightForCell() -> CGFloat {
        
        let titleHeight: CGFloat = 80
        
        return titleHeight
    }
}

