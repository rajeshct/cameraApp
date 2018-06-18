//
//  SignUpView.swift
//  CameraApp
//
//  Created by JEEVAN TIWARI on 27/05/18.
//  Copyright © 2018 JEEVAN TIWARI. All rights reserved.
//

import UIKit

extension SignupCell{
    
    func addViews(){
        
        let userNameImageView = UIImageView().returnTempImageView(image: #imageLiteral(resourceName: "userNameImage"))
        let nameImageView = UIImageView().returnTempImageView(image: #imageLiteral(resourceName: "userNameImage"))
        let emailImageView = UIImageView().returnTempImageView(image: #imageLiteral(resourceName: "emailImage"))
        let mobileImageView = UIImageView().returnTempImageView(image: #imageLiteral(resourceName: "mobileImage"))
        let passwordImageView = UIImageView().returnTempImageView(image: #imageLiteral(resourceName: "passwordImage"))
        let confirmImageView = UIImageView().returnTempImageView(image: #imageLiteral(resourceName: "passwordImage"))
        
        addSubview(profileImageButton)
        addSubview(userNameTextField)
        addSubview(nameTextField)
        addSubview(emailTextField)
        addSubview(mobileNumberTextField)
        addSubview(passwordTextField)
        addSubview(confirmPasswordTextField)
        addSubview(signUpButton)
        addSubview(userNameImageView)
        addSubview(nameImageView)
        addSubview(emailImageView)
        addSubview(mobileImageView)
        addSubview(passwordImageView)
        addSubview(confirmImageView)
        addSubview(activityIndicator)
        
        
        profileImageButton.topAnchor.constraint(equalTo: topAnchor, constant: 24).isActive = true
        profileImageButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        profileImageButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.3).isActive = true
        profileImageButton.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.3).isActive = true
        
        userNameTextField.anchorWithConstantsToTop(top: profileImageButton.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 16, leftConstant: 16, bottomConstant: 16, rightConstant: 16)
        userNameTextField.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.07).isActive = true
        
        userNameImageView.centerYAnchor.constraint(equalTo: userNameTextField.centerYAnchor).isActive = true
        userNameImageView.leftAnchor.constraint(equalTo: userNameTextField.leftAnchor, constant: 16).isActive = true
        userNameImageView.heightAnchor.constraint(equalTo: userNameTextField.heightAnchor, multiplier: 0.4).isActive = true
        userNameImageView.widthAnchor.constraint(equalTo: userNameTextField.heightAnchor, multiplier: 0.4).isActive = true
        
        
        
        nameTextField.anchorWithConstantsToTop(top: userNameTextField.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 16, leftConstant: 16, bottomConstant: 16, rightConstant: 16)
        nameTextField.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.07).isActive = true
        
        
        nameImageView.centerYAnchor.constraint(equalTo: nameTextField.centerYAnchor).isActive = true
        nameImageView.leftAnchor.constraint(equalTo: nameTextField.leftAnchor, constant: 16).isActive = true
        nameImageView.heightAnchor.constraint(equalTo: nameTextField.heightAnchor, multiplier: 0.4).isActive = true
        nameImageView.widthAnchor.constraint(equalTo: nameTextField.heightAnchor, multiplier: 0.4).isActive = true
        
        
        
        emailTextField.anchorWithConstantsToTop(top: nameTextField.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 16, leftConstant: 16, bottomConstant: 16, rightConstant: 16)
        emailTextField.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.07).isActive = true
        
        
        emailImageView.centerYAnchor.constraint(equalTo: emailTextField.centerYAnchor).isActive = true
        emailImageView.leftAnchor.constraint(equalTo: emailTextField.leftAnchor, constant: 16).isActive = true
        emailImageView.heightAnchor.constraint(equalTo: userNameTextField.heightAnchor, multiplier: 0.4).isActive = true
        emailImageView.widthAnchor.constraint(equalTo: userNameTextField.heightAnchor, multiplier: 0.4).isActive = true
        
        
        
        mobileNumberTextField.anchorWithConstantsToTop(top: emailTextField.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 16, leftConstant: 16, bottomConstant: 16, rightConstant: 16)
        mobileNumberTextField.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.07).isActive = true
        
        
        mobileImageView.centerYAnchor.constraint(equalTo: mobileNumberTextField.centerYAnchor).isActive = true
        mobileImageView.leftAnchor.constraint(equalTo: mobileNumberTextField.leftAnchor, constant: 16).isActive = true
        mobileImageView.heightAnchor.constraint(equalTo: userNameTextField.heightAnchor, multiplier: 0.4).isActive = true
        mobileImageView.widthAnchor.constraint(equalTo: userNameTextField.heightAnchor, multiplier: 0.4).isActive = true
        
        
        
        
        passwordTextField.anchorWithConstantsToTop(top: mobileNumberTextField.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 16, leftConstant: 16, bottomConstant: 16, rightConstant: 16)
        passwordTextField.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.07).isActive = true
        
        
        passwordImageView.centerYAnchor.constraint(equalTo: passwordTextField.centerYAnchor).isActive = true
        passwordImageView.leftAnchor.constraint(equalTo: passwordTextField.leftAnchor, constant: 16).isActive = true
        passwordImageView.heightAnchor.constraint(equalTo: userNameTextField.heightAnchor, multiplier: 0.4).isActive = true
        passwordImageView.widthAnchor.constraint(equalTo: userNameTextField.heightAnchor, multiplier: 0.4).isActive = true
        
        
        
        
        confirmPasswordTextField.anchorWithConstantsToTop(top: passwordTextField.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 16, leftConstant: 16, bottomConstant: 16, rightConstant: 16)
        confirmPasswordTextField.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.07).isActive = true
        
        
        confirmImageView.centerYAnchor.constraint(equalTo: confirmPasswordTextField.centerYAnchor).isActive = true
        confirmImageView.leftAnchor.constraint(equalTo: userNameTextField.leftAnchor, constant: 16).isActive = true
        confirmImageView.heightAnchor.constraint(equalTo: userNameTextField.heightAnchor, multiplier: 0.4).isActive = true
        confirmImageView.widthAnchor.constraint(equalTo: userNameTextField.heightAnchor, multiplier: 0.4).isActive = true
        
        
        
        signUpButton.anchorWithConstantsToTop(top: confirmPasswordTextField.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 48, leftConstant: 16, bottomConstant: 24, rightConstant: 16)
        signUpButton.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.07).isActive = true
        
        
        activityIndicator.centerXAnchor.constraint(equalTo: signUpButton.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: signUpButton.centerYAnchor).isActive = true
        
        
        
        
    }
}
