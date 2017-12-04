//
//  MainViewController.swift
//  TwitSplit
//
//  Created by Thanh Tam Le on 10/4/17.
//  Copyright © 2017 Thanh Tam Le. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {
    
    // Mark: - Variable
    fileprivate var messagesViewController: MessagesViewController!
    fileprivate var settingsViewController: SettingsViewController!
    fileprivate var testViewController: TestViewController!
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
                navigationController?.pushViewController(viewController, animated: false)
            }
            break
        case WorkFlow.mainScreen.hashValue:
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
        title = "messages".uppercased()
        view.tintColor = Global.colorMain
        tabBar.shadowImage = UIImage()
        tabBar.barTintColor = UIColor.white
        tabBar.backgroundImage = UIImage()
        tabBar.isTranslucent = false
        delegate = self
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
        
        storyboard = UIStoryboard(name: "Test", bundle: nil)
        if let viewController = storyboard.instantiateViewController(withIdentifier: "TestViewController") as? TestViewController {
            testViewController = viewController
        }
        
        let channelsBarItem = UITabBarItem(title: "messages".uppercased(), image: UIImage(named: "ic_channel"), tag: 1)
        messagesViewController.tabBarItem = channelsBarItem
        
        let settingsBarItem = UITabBarItem(title: "settings".uppercased(), image: UIImage(named: "ic_setting"), tag: 2)
        settingsViewController.tabBarItem = settingsBarItem
        
        let testBarItem = UITabBarItem(title: "Test".uppercased(), image: UIImage(named: "ic_setting"), tag: 2)
        testViewController.tabBarItem = testBarItem
        
        viewControllers = [messagesViewController, settingsViewController, testViewController]
    }
}

// Mark: - TabBarControllerDelegate
extension MainViewController: UITabBarControllerDelegate {
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        // Move tableview to top when tapping tab bar messages item
        if item.tag == 1 && previousTag == 1 {
            if let tableView = messagesViewController.getTableView() {
                let indexPath = NSIndexPath(row: 0, section: 0)
                tableView.scrollToRow(at: indexPath as IndexPath, at: .top, animated: true)
            }
        }
        
        // Set title for tab bar item
        if item.tag == 1 {
            title = "messages".uppercased()
        } else if item.tag == 2 {
            title = "settings".uppercased()
        }
        
        previousTag = item.tag
    }
    
    func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return ScrollingTransitionAnimator(tabBarController: tabBarController, lastIndex: tabBarController.selectedIndex)
    }
    
}

class ScrollingTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    weak var transitionContext: UIViewControllerContextTransitioning?
    var tabBarController: UITabBarController!
    var lastIndex = 0
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.8
    }
    
    init(tabBarController: UITabBarController, lastIndex: Int) {
        self.tabBarController = tabBarController
        self.lastIndex = lastIndex
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        self.transitionContext = transitionContext
        
        let containerView = transitionContext.containerView
        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        
        containerView.addSubview(toViewController!.view)
        
        var viewWidth = toViewController!.view.bounds.width
        
        if tabBarController.selectedIndex < lastIndex {
            viewWidth = -viewWidth
        }
        
        toViewController!.view.transform = CGAffineTransform(translationX: viewWidth, y: 0)
        
        UIView.animate(withDuration: self.transitionDuration(using: (self.transitionContext)), delay: 0.0, usingSpringWithDamping: 1.2, initialSpringVelocity: 2.5, options: .overrideInheritedOptions, animations: {
            toViewController!.view.transform = CGAffineTransform.identity
            fromViewController!.view.transform = CGAffineTransform(translationX: -viewWidth, y: 0)
        }, completion: { _ in
            self.transitionContext?.completeTransition(!self.transitionContext!.transitionWasCancelled)
            fromViewController!.view.transform = CGAffineTransform.identity
        })
    }
}
