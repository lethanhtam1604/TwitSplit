//
//  SettingsViewController.swift
//  TwitSplit
//
//  Created by Thanh Tam Le on 10/4/17.
//  Copyright © 2017 Thanh Tam Le. All rights reserved.
//

import UIKit

class SettingsViewController: BaseViewController {
    
    // MARK: - Outlet
    @IBOutlet fileprivate weak var profileView: UIView!
    @IBOutlet fileprivate weak var logoutView: UIView!
    
    // Mark: - View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initCommon()
    }
    
    // Mark: - Memory Warning
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @objc func actionTapToProfileView() {
        let storyboard = UIStoryboard(name: "Settings", bundle: nil)
        if let viewController = storyboard.instantiateViewController(withIdentifier: "ProfileViewController") as? ProfileViewController {
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    @objc func actionTapToLogoutView() {
        let alertController = UIAlertController(title: "Logout", message: "Are you sure want to logout?", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        let okAction = UIAlertAction(title: "Ok", style: .default) { _ in
            //write func for logout here...
            let storyboard = UIStoryboard(name: "Authentication", bundle: nil)
            if let viewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController {
                self.navigationController?.pushViewController(viewController, animated: false)
            }
        }
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}

// Mark: - Setup ViewController
extension SettingsViewController {
    
    fileprivate func initCommon() {
        profileView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(actionTapToProfileView)))
        logoutView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(actionTapToLogoutView)))
        
        title = "settings".uppercased()
    }
}
