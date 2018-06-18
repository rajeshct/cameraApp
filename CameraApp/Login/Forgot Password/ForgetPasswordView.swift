//
//  ForgetPasswordView.swift
//  CameraApp
//
//  Created by JEEVAN TIWARI on 24/04/18.
//  Copyright © 2018 JEEVAN TIWARI. All rights reserved.
//

import UIKit

class ForgotPasswordView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5215646404)
    }
    
    override func draw(_ rect: CGRect) {
        cardView.transform = CGAffineTransform(translationX: 0, y: UIScreen.main.bounds.height)
        
        UIView.animate(withDuration: 0.4, delay: 0.2, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseIn, animations: {
            self.cardView.transform = .identity
            
        }, completion: nil)
    }
    
    @objc func handleClose(){
        
        UIView.animate(withDuration: 0.4, delay: 0.2, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseIn, animations: {
            self.cardView.transform = CGAffineTransform(translationX: 0, y: UIScreen.main.bounds.height)
            
        }, completion: {(value) in
            self.removeFromSuperview()
        })
        
    }
    
  
    
    func addViews(){
        
      
        
        
        addSubview(cardView)
        cardView.addSubview(emailTextField)
        cardView.addSubview(submitButton)
        cardView.addSubview(forgotPasswordLabel)
        cardView.addSubview(closeButton)
        
        cardView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        cardView.anchorWithConstantsToTop(top: nil, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 0, leftConstant: 16, bottomConstant: 16, rightConstant: 16)

        
        cardView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.07 * 2 + 48 + 50).isActive = true
        
        
        forgotPasswordLabel.anchorWithConstantsToTop(top: cardView.topAnchor, left: cardView.leftAnchor, bottom: nil, right: cardView.rightAnchor, topConstant: 16, leftConstant: 16, bottomConstant: 1, rightConstant: 16)

        emailTextField.anchorWithConstantsToTop(top: forgotPasswordLabel.bottomAnchor, left: cardView.leftAnchor, bottom: nil, right: cardView.rightAnchor, topConstant: 8, leftConstant: 16, bottomConstant: 6, rightConstant: 16)
        emailTextField.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.07).isActive = true

        submitButton.anchorWithConstantsToTop(top: emailTextField.bottomAnchor, left: cardView.leftAnchor, bottom: cardView.bottomAnchor, right: cardView.rightAnchor, topConstant: 8, leftConstant: 16, bottomConstant: 16, rightConstant: 16)
        submitButton.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.07).isActive = true
        
        
        closeButton.anchorWithConstantsToTop(top: cardView.topAnchor, left: nil, bottom: nil, right: cardView.rightAnchor, topConstant: 8, leftConstant: 16, bottomConstant: 16, rightConstant: 16)
        closeButton.heightAnchor.constraint(equalToConstant: 24).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: 24).isActive = true
        
        
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let cardView: CardView = {
            let cv = CardView()
        cv.backgroundColor = .white
        return cv
    }()
    
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
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        tf.leftViewMode = .always
      //  tf.delegate = self
        tf.leftView = leftView
        return tf
    }()
    
    lazy var submitButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Submit", for: .normal)
        btn.backgroundColor = #colorLiteral(red: 0.4470588235, green: 0.568627451, blue: 0.9568627451, alpha: 1)
        btn.layer.cornerRadius = 10
        btn.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
      //  btn.addTarget(self, action: #selector(handleEnter), for: .touchUpInside)
        return btn
    }()
    
    lazy var closeButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.tintColor = #colorLiteral(red: 0.4470588235, green: 0.568627451, blue: 0.9568627451, alpha: 1)
        btn.setImage(#imageLiteral(resourceName: "closeImage").withRenderingMode(.alwaysTemplate), for: .normal)
        btn.addTarget(self, action: #selector(handleClose), for: .touchUpInside)
        return btn
    }()
    
    let forgotPasswordLabel: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Forgot Password"
        lbl.textColor = .black
        return lbl
    }()
}
