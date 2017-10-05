//
//  UIView.swift
//  TwitSplit
//
//  Created by Thanh Tam Le on 10/4/17.
//  Copyright © 2017 Thanh Tam Le. All rights reserved.
//

import UIKit

extension UIView {
    
    // Mark: - Animate size of View
    func increaseSize() {
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.toValue = 1
        animation.fromValue = 0
        animation.duration = 0.3
        animation.autoreverses = false
        self.layer.add(animation, forKey: nil)
    }
    
    // Mark: - Shadow View
    func shawdow(_ color: UIColor) {
        layer.cornerRadius = 5
        layer.shadowColor = color.cgColor
        layer.shadowOffset = CGSize(width: 0.2, height: 0.2)
        layer.shadowOpacity = 0.5
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
    }
    
    // Mark: - Keyboard
    func addTapToDismiss() {
        let tapViewGesture = UITapGestureRecognizer(target: self, action: #selector(dismiss))
        tapViewGesture.cancelsTouchesInView = false
        addGestureRecognizer(tapViewGesture)
    }
    
    @objc func dismiss() {
        endEditing(true)
    }
}
