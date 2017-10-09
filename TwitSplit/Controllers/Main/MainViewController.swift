//
//  MainViewController.swift
//  TwitSplit
//
//  Created by Thanh Tam Le on 10/4/17.
//  Copyright © 2017 Thanh Tam Le. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController, UINavigationControllerDelegate {
    
    // Mark: - Variable
    fileprivate var messagesViewController: MessagesViewController!
    fileprivate var settingsViewController: SettingsViewController!
    fileprivate var previousTag = 1
    
    // Mark: - View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initCommon()
        setupTabBarController()
    }
    
    // Mark: - View Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Mark: - Setup application workflow
        switch Global.currentWorkFlow {
        case WorkFlow.splashScreen.hashValue:
            let storyboard = UIStoryboard(name: "SplashScreen", bundle: nil)
            if let viewController = storyboard.instantiateViewController(withIdentifier: "SplashScreenViewController") as? SplashScreenViewController {
                navigationController?.pushViewController(viewController, animated: false)
            }
            break
        case WorkFlow.login.hashValue:
            let storyboard = UIStoryboard(name: "Authentication", bundle: nil)
            if let viewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController {
                parent?.present(viewController, animated: true, completion: nil)
            }
            break
        case WorkFlow.mainScreen.hashValue:
            view.isHidden = false
            selectedIndex = 0
            break
        default:
            break
        }
        
        Global.currentWorkFlow = WorkFlow.nothing.hashValue
    }
    
    // Mark: - Memory Warning
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// Mark: - Setup ViewController
extension MainViewController {
    
    fileprivate func initCommon() {
        view.isHidden = true
        navigationController?.isNavigationBarHidden = true
        view.tintColor = Global.colorMain
        tabBar.shadowImage = UIImage()
        tabBar.barTintColor = UIColor.white
        tabBar.backgroundImage = UIImage()
        tabBar.isTranslucent = false
    }
    
    fileprivate func setupTabBarController() {
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor: Global.colorGray, NSAttributedStringKey.font: UIFont(name: "OpenSans-semibold", size: 10) ?? UIFont.systemFontSize], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor: Global.colorMain, NSAttributedStringKey.font: UIFont(name: "OpenSans-semibold", size: 10) ?? UIFont.systemFontSize], for: .selected)
        
        var storyboard = UIStoryboard(name: "Messages", bundle: nil)
        if let viewController = storyboard.instantiateViewController(withIdentifier: "MessagesViewController") as? MessagesViewController {
            messagesViewController = viewController
        }
        
        storyboard = UIStoryboard(name: "Settings", bundle: nil)
        if let viewController = storyboard.instantiateViewController(withIdentifier: "SettingsViewController") as? SettingsViewController {
            settingsViewController = viewController
        }
        
        let channelsBarItem = UITabBarItem(title: NSLocalizedString("channels", comment: "").uppercased(), image: UIImage(named: "ic_channel"), tag: 1)
        messagesViewController.tabBarItem = channelsBarItem
        let nc1 = UINavigationController(rootViewController: messagesViewController)
        
        let settingsBarItem = UITabBarItem(title: NSLocalizedString("settings", comment: "").uppercased(), image: UIImage(named: "ic_setting"), tag: 2)
        settingsViewController.tabBarItem = settingsBarItem
        let nc2 = UINavigationController(rootViewController: settingsViewController)
        
        viewControllers = [nc1, nc2]
    }
}

// Mark: - TabBarControllerDelegate
extension MainViewController: UITabBarControllerDelegate {
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        if item.tag == 1 && previousTag == 1 {
            if let tableView = messagesViewController.getTableView() {
                let indexPath = NSIndexPath(row: 0, section: 0)
                tableView.scrollToRow(at: indexPath as IndexPath, at: .top, animated: true)
            }
        }
        
        previousTag = item.tag
    }
}

