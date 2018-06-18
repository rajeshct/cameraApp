//
//  LoginViews.swift
//  CameraApp
//
//  Created by JEEVAN TIWARI on 07/04/18.
//  Copyright © 2018 JEEVAN TIWARI. All rights reserved.
//


import UIKit

extension LoginController{
    
    func addViews(){
        
        let centerView = view.returnTempView(backgroundColor: .clear)
        let loginToYourText = UILabel().returnTempLabel(text: "LOGIN TO YOUR ACCOUNT")
        let copyrightView = CopyrightView()
        let emailImageView = UIImageView().returnTempImageView(image: #imageLiteral(resourceName: "emailImage"))
        let passwordImageView = UIImageView().returnTempImageView(image: #imageLiteral(resourceName: "passwordImage"))
        
        
        view.addSubview(centerView)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(forgotPasswordButton)
        view.addSubview(enterButton)
        view.addSubview(loginToYourText)
        view.addSubview(logoImageView)
        view.addSubview(copyrightView)
        emailTextField.addSubview(emailImageView)
        passwordTextField.addSubview(passwordImageView)
        view.addSubview(activityIndicator)
        view.addSubview(signupButton)
        
        
        
        
        
        
        centerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        centerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        centerView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        centerView.widthAnchor.constraint(equalToConstant: 1).isActive = true
        
        
        emailTextField.anchorWithConstantsToTop(top: nil, left: view.leftAnchor, bottom: centerView.topAnchor, right: view.rightAnchor, topConstant: 8, leftConstant: 24, bottomConstant: 8, rightConstant: 24)
        emailTextField.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.07).isActive = true
        
    emailImageView.leftAnchor.constraint(equalTo: emailTextField.leftAnchor, constant: 16).isActive = true
        emailImageView.centerYAnchor.constraint(equalTo: emailTextField.centerYAnchor).isActive = true
        emailImageView.heightAnchor.constraint(equalTo: emailTextField.heightAnchor, multiplier: 0.4).isActive = true
        
        passwordTextField.anchorWithConstantsToTop(top: centerView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 8, leftConstant: 24, bottomConstant: 24, rightConstant: 24)
        passwordTextField.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.07).isActive = true
        
        passwordImageView.leftAnchor.constraint(equalTo: passwordTextField.leftAnchor, constant: 16).isActive = true
        passwordImageView.centerYAnchor.constraint(equalTo: passwordTextField.centerYAnchor).isActive = true
        passwordImageView.heightAnchor.constraint(equalTo: emailTextField.heightAnchor, multiplier: 0.4).isActive = true
        
        
        forgotPasswordButton.anchorWithConstantsToTop(top: passwordTextField.bottomAnchor, left: nil, bottom: nil, right: view.rightAnchor, topConstant: 8, leftConstant: 16, bottomConstant: 16, rightConstant: 24)
        
        
        enterButton.anchorWithConstantsToTop(top: forgotPasswordButton.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 24, leftConstant: 24, bottomConstant: 24, rightConstant: 24)
        enterButton.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.07).isActive = true
        
        
        signupButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        signupButton.topAnchor.constraint(equalTo: enterButton.bottomAnchor, constant: 24).isActive = true
        
        
        loginToYourText.anchorWithConstantsToTop(top: nil, left: view.leftAnchor, bottom: emailTextField.topAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 24, bottomConstant: 24, rightConstant: 24)
        
        
        
        logoImageView.bottomAnchor.constraint(equalTo: loginToYourText.topAnchor, constant: -64).isActive = true
        logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoImageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.25).isActive = true
        logoImageView.widthAnchor.constraint(equalTo: view.widthAnchor
            , multiplier: 0.4).isActive = true
        
        
        copyrightView.anchorToTop(top: nil, left: view.leftAnchor, bottom: nil, right: view.rightAnchor)
      //  copyrightView.heightAnchor.constraint(equalToConstant: 19).isActive = true
        
        if #available(iOS 11.0, *){
            copyrightView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
            
        }else{
            copyrightView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        }
        
        
        activityIndicator.centerXAnchor.constraint(equalTo: enterButton.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: enterButton.centerYAnchor).isActive = true
        
        
        
        
    }
    
}

