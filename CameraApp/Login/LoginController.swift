//
//  LoginController.swift
//  CameraApp
//
//  Created by JEEVAN TIWARI on 07/04/18.
//  Copyright © 2018 JEEVAN TIWARI. All rights reserved.
//

import UIKit

class LoginController: UIViewController{

    var reportDelegate: PresentCameraDelegate?
    var useFingerPrint: Bool?{
        didSet{
            if useFingerPrint == true{
                presentTouch()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        addViews()
        addGestures()
        setupNavigation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
        navigationItem.title = ""
        
    }
    
    lazy var emailTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Email"
        tf.layer.cornerRadius = 10
        tf.layer.masksToBounds = false
        tf.layer.shadowRadius = 3.0
        tf.layer.shadowColor = UIColor.gray.cgColor
        tf.layer.shadowOffset = CGSize(width: 0, height: 0)
        tf.layer.shadowOpacity = 1.0
        tf.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        tf.keyboardType = .emailAddress
        tf.autocapitalizationType = .none
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.height * 0.07 * 0.4 + 32, height: 0))
        tf.leftViewMode = .always
        tf.delegate = self
        tf.leftView = leftView
        return tf
    }()
    
    lazy var passwordTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Password"
        tf.layer.cornerRadius = 10
        tf.layer.masksToBounds = false
        tf.layer.shadowRadius = 3.0
        tf.layer.shadowColor = UIColor.gray.cgColor
        tf.layer.shadowOffset = CGSize(width: 0, height: 0)
        tf.layer.shadowOpacity = 1.0
        tf.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.height * 0.07 * 0.4 + 32, height: 0))
        tf.leftViewMode = .always
        tf.isSecureTextEntry = true
        tf.delegate = self
        tf.leftView = leftView
        return tf
    }()
    
    lazy var enterButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("ENTER", for: .normal)
        btn.backgroundColor = #colorLiteral(red: 0.4470588235, green: 0.568627451, blue: 0.9568627451, alpha: 1)
        btn.layer.cornerRadius = 10
        btn.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        btn.addTarget(self, action: #selector(handleEnter), for: .touchUpInside)
        return btn
    }()
    
    
    lazy var forgotPasswordButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Forgot Password?", for: .normal)
        btn.setTitleColor(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), for: .normal)
        btn.addTarget(self, action: #selector(handleForgot), for: .touchUpInside)
        return btn
    }()
    
    lazy var signupButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Signup", for: .normal)
        btn.setTitleColor(#colorLiteral(red: 0.4470588235, green: 0.568627451, blue: 0.9568627451, alpha: 1), for: .normal)
        btn.addTarget(self, action: #selector(handleSignup), for: .touchUpInside)
        return btn
    }()
    
    
    let logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = #imageLiteral(resourceName: "logoImage")
        return iv
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let ai = UIActivityIndicatorView()
        ai.activityIndicatorViewStyle = .white
        ai.translatesAutoresizingMaskIntoConstraints = false
        return ai
    }()
    
}

