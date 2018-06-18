//
//  LoginDelegates.swift
//  CameraApp
//
//  Created by JEEVAN TIWARI on 07/04/18.
//  Copyright © 2018 JEEVAN TIWARI. All rights reserved.
//

import UIKit
import BiometricAuthentication

extension LoginController{
    
    
    @objc func handleEnter(){
        
        if !checkEmptyTextField(){
            callLoginApi()
        }
        
    }
    
    func callLoginApi(){
        
        activityIndicator.startAnimating()
        let apiCallObj = LoginApiInteraction()


        enterButton.setTitle("", for: .normal)

        if let email = emailTextField.text, let password = passwordTextField.text{

            let param = [
                "Email": email,
                "Password": password
            ]

            apiCallObj.delegate = self
            apiCallObj.getLoginResponse(loginData: param)
        }
        

        
    }
    
    
    func userDetails(userData: LoginData?) {
        dismiss(animated: true, completion: nil)
    }
    
    func wrongCredentials(error: String) {
        
    }
    
    
    
    
}


//MARK: Text Field Delegats

extension LoginController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField {
        case emailTextField:
            passwordTextField.becomeFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        
        return true
    }
    
    
    func checkEmptyTextField() -> Bool{
        
        var emptyCheck = false
        
        if DataRestrictionCheck.shared.checkEmptyTextField(textField: emailTextField){
            emptyCheck = true
            Alerts.shared.displaySimpleAlert(displayIn: self, title: "Warning", message: "Email field is required")
        }else if DataRestrictionCheck.shared.checkEmptyTextField(textField: passwordTextField){
            emptyCheck = true
            Alerts.shared.displaySimpleAlert(displayIn: self, title: "Warning", message: "Password field is required")
        }
        
        return emptyCheck
    }
    
}


// Add Gesture recognizer

extension LoginController{

func addGestures(){
    
    let tapGestrure = UITapGestureRecognizer(target: self, action: #selector(handleTap))
    view.addGestureRecognizer(tapGestrure)
}

    @objc func handleTap(){
        
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
    
    @objc func handleForgot(){
        
        let forgotView = ForgotPasswordView()
        view.addSubview(forgotView)
        forgotView.anchorToTop(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        
    }
    
    
}


extension LoginController:  LoginDataDelegate{


    func wrongCredentials(error: String?) {
        if let getError = error{
            
            enterButton.setTitle("ENTER", for: .normal)
            activityIndicator.stopAnimating()
            Alerts.shared.displaySimpleAlert(displayIn: self, title: "Warning", message: getError)
            
        }
        
    }
    
    func userDetails(userData: LoginResultsModel?) {
        
        UserDefaults.standard.setValue(true, forKey: "isLogin")
        UserDefaults.standard.setValue(userData?.result?.Token, forKey: "token")
        UserDefaults.standard.set(userData?.result?.ID, forKey: "userId")
        UserDefaults.standard.set(userData?.result?.UserType, forKey: "userType")

        SaveUserDataOnLogin.shared.saveDataToPList(userModel: userData)
        dismiss(animated: true, completion: nil)
        reportDelegate?.presentCamera()
    }
    
    
    func setupNavigation(){
        navigationController?.navigationBar.titleTextAttributes = [ NSAttributedStringKey.foregroundColor: #colorLiteral(red: 0.4470588235, green: 0.568627451, blue: 0.9568627451, alpha: 1)]
        
        navigationController?.navigationBar.isTranslucent = false
        
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    @objc func handleSignup(){
        let signupObj = SignupController()
        signupObj.screenType = SignUpEdit.SIGNUP
        navigationController?.pushViewController(signupObj, animated: true)
    }
    
    
}


extension LoginController{
    func presentTouch(){
        
        

        BioMetricAuthenticator.authenticateWithBioMetrics(reason: "Security Reason", success: {

            // authentication successful
            self.dismiss(animated: true, completion:  nil)
            print("Authentication succesfull")

        }, failure: { [weak self] (error) in

            // do nothing on canceled
            if error == .canceledByUser || error == .canceledBySystem {
                return
            }

                // device does not support biometric (face id or touch id) authentication
            else if error == .biometryNotAvailable {

                // self?.showErrorAlert(message: error.message())
            }

                // show alternatives on fallback button clicked
            else if error == .fallback {

                // here we're entering username and password
                //self?.txtUsername.becomeFirstResponder()
            }

                // No biometry enrolled in this device, ask user to register fingerprint or face
            else if error == .biometryNotEnrolled {
                //self?.showGotoSettingsAlert(message: error.message())
            }

                // Biometry is locked out now, because there were too many failed attempts.
                // Need to enter device passcode to unlock.
            else if error == .biometryLockedout {
                // show passcode authentication
            }

                // show error on authentication failed
            else {
                //self?.showErrorAlert(message: error.message())
            }
        })

    }
}

