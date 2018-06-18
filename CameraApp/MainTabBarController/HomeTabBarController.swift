//
//  HomeTabBarController.swift
//  CameraApp
//
//  Created by JEEVAN TIWARI on 07/04/18.
//  Copyright © 2018 JEEVAN TIWARI. All rights reserved.
//

import UIKit

class HomeTabBarController: UITabBarController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tabBar.isTranslucent = false
        
        
        let reportsController = UINavigationController(rootViewController: ViewController())
        reportsController.tabBarItem.title = "Reports"
        reportsController.tabBarItem.image = #imageLiteral(resourceName: "reportsImage")
        
        
        let projectController = UINavigationController(rootViewController: ViewController())
        projectController.tabBarItem.title = "Project"
        projectController.tabBarItem.image = #imageLiteral(resourceName: "projectImage")
        
        let fakeController = UINavigationController(rootViewController: ViewController())
        fakeController.tabBarItem.title = ""
        fakeController.tabBarItem.image = #imageLiteral(resourceName: "projectImage")
        
        let invoiceController = UINavigationController(rootViewController: ViewController())
        invoiceController.tabBarItem.title = "Invoice"
        invoiceController.tabBarItem.image = #imageLiteral(resourceName: "invoiceImage")
        
        let settingController = UINavigationController(rootViewController: ViewController())
        settingController.tabBarItem.title = "Settings"
        settingController.tabBarItem.image = #imageLiteral(resourceName: "settingsImage")
        
        
        viewControllers = [reportsController, projectController, fakeController, invoiceController, settingController]
        
        
    }
}
