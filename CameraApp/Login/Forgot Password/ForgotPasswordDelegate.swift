//
//  ForgotPasswordDelegate.swift
//  CameraApp
//
//  Created by JEEVAN TIWARI on 24/04/18.
//  Copyright © 2018 JEEVAN TIWARI. All rights reserved.
//

import UIKit



extension ForgotPasswordView: ForgotPasswordProtocol{
   

    
    func getForgotData(forgotData: String?, error: String?) {
        
        // Stop Activity Indicator
        
        hideActivityIndicator()
    }

    
    func showActivityIndicator(){
        activityIndicator.startAnimating()
        submitButton.setTitle("", for: .normal)
    }
    
    func hideActivityIndicator(){
        activityIndicator.stopAnimating()
        submitButton.setTitle("Submit", for: .normal)
    }
    
    
    @objc func handleSubmit(){
        
        // Show Indicator
        showActivityIndicator()
        
        guard let email = emailTextField.text else{
            return
        }
        
        
        let bodyParam = [
            "EmailId" : email
        ]
        
        
        let apiObj = ForgotPasswordApiInteraction()
        apiObj.delegate = self
        apiObj.getLoginResponse(loginData: bodyParam)
        
        
    }
    
    
}
