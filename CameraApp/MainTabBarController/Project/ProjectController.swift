//
//  ProjectController.swift
//  CameraApp
//
//  Created by JEEVAN TIWARI on 08/04/18.
//  Copyright © 2018 JEEVAN TIWARI. All rights reserved.
//

import UIKit

class ProjectController: UITableViewController{
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        setupNavigationController()
        
        
    }
    
    
    func setupNavigationController(){
    
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: calendar, style: <#T##UIBarButtonItemStyle#>, target: <#T##Any?#>, action: <#T##Selector?#>)
        navigationController?.navigationBar.isTranslucent = false
    }
    
    
}
