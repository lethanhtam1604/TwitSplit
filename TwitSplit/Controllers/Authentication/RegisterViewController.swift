//
//  RegisterViewController.swift
//  TwitSplit
//
//  Created by Thanh Tam Le on 10/4/17.
//  Copyright © 2017 Thanh Tam Le. All rights reserved.
//

import UIKit

class RegisterViewController: BaseViewController {

    // Mark: - Outlet
    @IBOutlet fileprivate weak var errorLabel: UILabel!
    @IBOutlet fileprivate weak var nameField: UITextField!
    @IBOutlet fileprivate weak var nameBorder: UIView!
    @IBOutlet fileprivate weak var emailField: UITextField!
    @IBOutlet fileprivate weak var emailBorder: UIView!
    @IBOutlet fileprivate weak var phoneField: UITextField!
    @IBOutlet fileprivate weak var phoneBorder: UIView!
    @IBOutlet fileprivate weak var passwordField: UITextField!
    @IBOutlet fileprivate weak var passwordBorder: UIView!
    @IBOutlet fileprivate weak var registerButton: UIButton!
    
    // Mark: - Variables
    fileprivate let registerPresenter = RegisterPresenter()

    // Mark: - View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initCommon()
        registerPresenter.attachView(view: self)
    }
    
    // Mảrk: - Memory Warning
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func actionTapToRegsiterButton(_ sender: Any) {
        registerPresenter.register()
    }
    
    @IBAction func actionTapToLoginButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

// Mark: - Register Cycle
extension RegisterViewController: RegisterView {
    
    func startLoading() {
        
    }
    
    func finishLoading() {
        
    }
    
    func register() {
        Global.currentWorkFlow = WorkFlow.mainScreen.hashValue
        presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
}

// Mark: - Setup ViewController
extension RegisterViewController {
    
    fileprivate func initCommon() {
        view.backgroundColor = UIColor.white
        registerButton.layer.cornerRadius = 5
        
        nameField.delegate = self
        emailField.delegate = self
        phoneField.delegate = self
        passwordField.delegate = self
    }
    
    fileprivate func checkInput(textField: UITextField, value: String?) -> Bool {
        switch textField {
        case nameField:
            if let newValue = value, newValue.isValidName() {
                errorLabel.text = nil
                nameBorder.backgroundColor = Global.colorSeparator
                return true
            }
            errorLabel.text = "Invalid Name"
            nameBorder.backgroundColor = UIColor.red.withAlphaComponent(0.8)
            
        case emailField:
            if let newValue = value, newValue.isValidEmail() {
                errorLabel.text = nil
                emailBorder.backgroundColor = Global.colorSeparator
                return true
            }
            errorLabel.text = "Invalid Email"
            emailBorder.backgroundColor = UIColor.red.withAlphaComponent(0.8)
            
        case phoneField:
            if let newValue = value, newValue.isValidPhone() {
                errorLabel.text = nil
                phoneBorder.backgroundColor = Global.colorSeparator
                return true
            }
            errorLabel.text = "Invalid Phone"
            phoneBorder.backgroundColor = UIColor.red.withAlphaComponent(0.8)
            
        default:
            if let newValue = value, newValue.isValidPassword() {
                errorLabel.text = nil
                passwordBorder.backgroundColor = Global.colorSeparator
                return true
            }
            errorLabel.text = "Invalid password"
            passwordBorder.backgroundColor = UIColor.red.withAlphaComponent(0.8)
        }
        return false
    }
}

// Mark: - TextField Delegate
extension RegisterViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newString = NSString(string: textField.text!).replacingCharacters(in: range, with: string)
        _ = checkInput(textField: textField, value: newString)
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case nameField:
            if checkInput(textField: textField, value: textField.text) {
                textField.resignFirstResponder()
                emailField.becomeFirstResponder()
                return true
            }
        case emailField:
            if checkInput(textField: textField, value: textField.text) {
                textField.resignFirstResponder()
                phoneField.becomeFirstResponder()
                return true
            }
        case phoneField:
            if checkInput(textField: textField, value: textField.text) {
                textField.resignFirstResponder()
                passwordField.becomeFirstResponder()
                return true
            }
        default:
            if checkInput(textField: textField, value: textField.text) {
                textField.resignFirstResponder()
                return true
            }
        }
        return false
    }
}
