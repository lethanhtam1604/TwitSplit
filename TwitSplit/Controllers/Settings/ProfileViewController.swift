//
//  ProfileViewController.swift
//  TwitSplit
//
//  Created by Thanh Tam Le on 10/4/17.
//  Copyright © 2017 Thanh Tam Le. All rights reserved.
//

import UIKit

class ProfileViewController: BaseViewController {
    
    // Mark: - View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initCommon()
        setupBarButtonItems()
    }
    
    // Mark: Memory Warning
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @objc func actionTapToBackBtn() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func actionTapToSaveBtn() {
        navigationController?.popViewController(animated: true)
    }
}

// Mark: - Setup ViewController
extension ProfileViewController {
    
    fileprivate func initCommon() {
        title = "profile".uppercased()
        
        //enable swipe back when it changed leftBarButtonItem
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
    
    fileprivate func setupBarButtonItems() {
        let backBarButton = UIBarButtonItem(image: UIImage(named: "ic_nav_back"), style: .done, target: self, action: #selector(actionTapToBackBtn))
        backBarButton.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItem = backBarButton
        
        let saveBarButton = UIBarButtonItem(title: "save".uppercased(), style: .done, target: self, action: #selector(actionTapToSaveBtn))
        saveBarButton.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: Global.colorMain, NSAttributedStringKey.font: UIFont(name: "OpenSans-semibold", size: 15) ?? UIFont.systemFontSize], for: UIControlState.normal)
        self.navigationItem.rightBarButtonItem = saveBarButton
    }
}

