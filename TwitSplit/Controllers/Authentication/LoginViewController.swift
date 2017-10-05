//
//  LoginViewController.swift
//  TwitSplit
//
//  Created by Thanh Tam Le on 10/4/17.
//  Copyright © 2017 Thanh Tam Le. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController {
    
    // Mark: - Outlet
    @IBOutlet fileprivate weak var errorLabel: UILabel!
    @IBOutlet fileprivate weak var emailField: UITextField!
    @IBOutlet fileprivate weak var passwordField: UITextField!
    @IBOutlet fileprivate weak var loginButton: UIButton!
    @IBOutlet fileprivate weak var registerButton: UIButton!
    @IBOutlet fileprivate weak var emailBorder: UIView!
    @IBOutlet fileprivate weak var passwordBorder: UIView!
    
    // Mark: - Variables
    fileprivate let loginPresenter = LoginPresenter()
    
    // Mark: - View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        initCommon()
        loginPresenter.attachView(view: self)
    }

    // Mảrk: - Memory Warning
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
    }
    
    @IBAction func actionTapToLoginButton(_ sender: Any) {
        loginPresenter.login()
    }
    
    @IBAction func actionTapToRegisterButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Authentication", bundle: nil)
        if let viewController = storyboard.instantiateViewController(withIdentifier: "RegisterViewController") as? RegisterViewController {
            present(viewController, animated: true, completion: nil)
        }
    }
}

// Mark: - Login Cycle
extension LoginViewController: LoginView {
    
    func startLoading() {
        
    }
    
    func finishLoading() {
        
    }

    func login() {
        Global.currentWorkFlow = WorkFlow.mainScreen.hashValue
        dismiss(animated: true, completion: nil)
    }
}

// Mark: - Setup ViewController
extension LoginViewController {
    
    fileprivate func initCommon() {
        view.backgroundColor = UIColor.white
        loginButton.layer.cornerRadius = 5
        registerButton.layer.borderColor = Global.colorMain.cgColor
        registerButton.layer.borderWidth = 1
        registerButton.layer.cornerRadius = 5
        
        emailField.delegate = self
        passwordField.delegate = self
    }
    
    fileprivate func checkInput(textField: UITextField, value: String?) -> Bool {
        switch textField {
        case emailField:
            if let newValue = value, newValue.isValidEmail() {
                errorLabel.text = nil
                emailBorder.backgroundColor = Global.colorSeparator
                return true
            }
            errorLabel.text = "Invalid Email"
            emailBorder.backgroundColor = UIColor.red.withAlphaComponent(0.8)
            
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
extension LoginViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newString = NSString(string: textField.text!).replacingCharacters(in: range, with: string)
        _ = checkInput(textField: textField, value: newString)
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case emailField:
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
