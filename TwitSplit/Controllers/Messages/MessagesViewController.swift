//
//  MessagesViewController.swift
//  TwitSplit
//
//  Created by Thanh Tam Le on 10/4/17.
//  Copyright © 2017 Thanh Tam Le. All rights reserved.
//

import UIKit

class MessagesViewController: BaseViewController {
    
    // MARK: - Outlet
    
    // MARK: - Variable
    
    // MARK: - View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initCommon()
    }
    
    // Mark: - Memory Warning
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// Mark: Setup ViewController
extension MessagesViewController {
    
    fileprivate func initCommon() {
        title = "messages".uppercased()
    }
}

