//
//  SignUpCell.swift
//  CameraApp
//
//  Created by JEEVAN TIWARI on 27/05/18.
//  Copyright © 2018 JEEVAN TIWARI. All rights reserved.
//

import UIKit

class SignupCell: UITableViewCell{
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        selectionStyle = .none
        addViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    lazy var profileImageButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = UIScreen.main.bounds.width * 0.3 / 2
        btn.clipsToBounds = true
        btn.imageView?.contentMode = .center
        btn.setImage(#imageLiteral(resourceName: "userPlaceHolderImage").withRenderingMode(.alwaysOriginal), for: .normal)
        return btn
    }()
    
    lazy var userNameTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.addEffects()
        tf.placeholder = "Username"
        tf.isSecureTextEntry = false
        tf.delegate = self
        return tf
    }()
    
    lazy var nameTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.addEffects()
        tf.placeholder = "Name"
        tf.isSecureTextEntry = false
        tf.delegate = self
        tf.alpha = 0.2
        tf.isUserInteractionEnabled = false
        return tf
    }()
    
    
    lazy var emailTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.addEffects()
        tf.placeholder = "Email"
        tf.isSecureTextEntry = false
        tf.delegate = self
        tf.alpha = 0.2
        tf.isUserInteractionEnabled = false
        return tf
    }()
    
    lazy var mobileNumberTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.addEffects()
         tf.placeholder = "Mobile Number"
        tf.isSecureTextEntry = false
        tf.delegate = self
        tf.alpha = 0.2
        tf.isUserInteractionEnabled = false
        return tf
    }()
    
    lazy var passwordTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.addEffects()
        tf.placeholder = "Password"
        tf.delegate = self
        tf.alpha = 0.2
        tf.isUserInteractionEnabled = false
        return tf
    }()
    
    lazy var confirmPasswordTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.addEffects()
        tf.alpha = 0.2
        tf.isUserInteractionEnabled = false
         tf.placeholder = "Confirm Password"
        tf.delegate = self
        return tf
    }()
    
    lazy var signUpButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("SIGN UP", for: .normal)
        btn.backgroundColor = #colorLiteral(red: 0.4470588235, green: 0.568627451, blue: 0.9568627451, alpha: 1)
        btn.layer.cornerRadius = 10
        btn.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
      //  btn.addTarget(self, action: #selector(handleEnter), for: .touchUpInside)
        return btn
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let ai = UIActivityIndicatorView()
        ai.activityIndicatorViewStyle = .white
        ai.translatesAutoresizingMaskIntoConstraints = false
        return ai
    }()
    
    
}
