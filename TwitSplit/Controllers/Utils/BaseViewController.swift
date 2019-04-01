//
//  BaseViewController.swift
//  TwitSplit
//
//  Created by Thanh Tam Le on 10/4/17.
//  Copyright © 2017 Thanh Tam Le. All rights reserved.
//

import UIKit

// BaseViewController is responsible for initialling navigation bar and setting main properties for controller
class BaseViewController: UIViewController {

    // Mark: - View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        initCommon()
        setupNavigationBar()
    }

    // Mark: - Memory Warning
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
}

// Mark: - Setup ViewController
extension BaseViewController {

    fileprivate func initCommon() {
        view.backgroundColor = Global.colorBg
        view.tintColor = Global.colorMain
        view.clipsToBounds = true
        view.addTapToDismiss()
    }
    
    fileprivate func setupNavigationBar() {
        navigationController?.navigationBar.barTintColor = UIColor.white
        navigationController?.navigationBar.tintColor = UIColor.black
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.black, NSAttributedStringKey.font: UIFont(name: "OpenSans-semibold", size: 15) ?? UIFont.systemFontSize]
        
//        self.navigationController?.navigationBar.layer.shadowColor = UIColor.black.withAlphaComponent(0.3).cgColor
//        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0.0, height: 0.3)
//        self.navigationController?.navigationBar.layer.shadowRadius = 1
//        self.navigationController?.navigationBar.layer.shadowOpacity = 0.6
//        self.navigationController?.navigationBar.layer.masksToBounds = false
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = false
    }
}
