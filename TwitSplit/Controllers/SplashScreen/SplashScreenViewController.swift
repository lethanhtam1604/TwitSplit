//
//  SplashScreenViewController.swift
//  TwitSplit
//
//  Created by Thanh Tam Le on 10/4/17.
//  Copyright © 2017 Thanh Tam Le. All rights reserved.
//

import UIKit

class SplashScreenViewController: BaseViewController {
    
    // MARK: - Outlet
    @IBOutlet fileprivate weak var titleLabel: UILabel!
    
    // Mark: - View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initCommon()
    }
    
    // Mark: - Memory Warning
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Mark: - View Cycle
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        titleLabel.layer.removeAllAnimations()
    }
    
    // Mark: - Pop ViewController
    func navigateToMainPage() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.navigationController?.popViewController(animated: false)
        }
    }
}
// Mark: Setup ViewController
extension SplashScreenViewController {
    
    fileprivate func initCommon() {
        view.backgroundColor = UIColor.white
        titleLabel.increaseSize()
        Global.currentWorkFlow = WorkFlow.mainScreen.hashValue
        navigateToMainPage()
    }
}
