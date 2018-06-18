//
//  EditprofileController.swift
//  CameraApp
//
//  Created by JEEVAN TIWARI on 29/04/18.
//  Copyright © 2018 JEEVAN TIWARI. All rights reserved.
//

import UIKit

class EditProfileController: UITableViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "Edit Profile"
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationItem.title = ""
        tabBarController?.tabBar.isHidden = false
    }
}
