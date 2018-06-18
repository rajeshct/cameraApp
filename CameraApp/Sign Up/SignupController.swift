//
//  SignupController.swift
//  CameraApp
//
//  Created by JEEVAN TIWARI on 27/05/18.
//  Copyright © 2018 JEEVAN TIWARI. All rights reserved.
//

import UIKit

class SignupController: UITableViewController{
    
    var signupCell = SignupCell()
    var screenType: SignUpEdit?{
        didSet{
            setui()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        setup()
        tableView.showsVerticalScrollIndicator = false
        signupCell.profileImageButton.addTarget(self, action: #selector(handleProfile), for: .touchUpInside)
        signupCell.signUpButton.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        imagePicker.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = true
    }

    let imagePicker = UIImagePickerController()
    
    
    
}
