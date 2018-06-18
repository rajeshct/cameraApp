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
        
        
     //   tabBar.isTranslucent = false
    
        
        let reportsController = UINavigationController(rootViewController: ReportController())
        reportsController.tabBarItem.title = "Reports"
        reportsController.tabBarItem.image = #imageLiteral(resourceName: "reportsImage")
        
        
        let projectController = UINavigationController(rootViewController: ProjectController())
        projectController.tabBarItem.title = "Project"
        projectController.tabBarItem.image = #imageLiteral(resourceName: "projectImage")
        
        let fakeController = UINavigationController(rootViewController: ViewController())
        fakeController.tabBarItem.title = ""
        
        
        
        let invoiceController = UINavigationController(rootViewController: ViewController())
        invoiceController.tabBarItem.title = "Invoice"
        invoiceController.tabBarItem.image = #imageLiteral(resourceName: "invoiceImage")
        
        let settingController = UINavigationController(rootViewController: ProfileViewController())
        settingController.tabBarItem.title = "Profile"
        settingController.tabBarItem.image = #imageLiteral(resourceName: "profileTabImage")
        
        
        viewControllers = [reportsController, projectController, fakeController, invoiceController, settingController]
        
        
        tabBar.addSubview(enterButton)
        tabBar.centerXAnchor.constraint(equalTo: enterButton.centerXAnchor).isActive = true
      //  tabBar.topAnchor.constraint(equalTo: enterButton.centerYAnchor).isActive = true
        tabBar.topAnchor.constraint(equalTo: enterButton.centerYAnchor, constant: -10).isActive = true
        
    }
    
    
    
    lazy var enterButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(#imageLiteral(resourceName: "cameraImage").withRenderingMode(.alwaysOriginal), for: .normal)
        btn.layer.cornerRadius = 10
        btn.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        btn.addTarget(self, action: #selector(handleCamera), for: .touchUpInside)
        return btn
    }()
}

extension HomeTabBarController{

    @objc func handleCamera(){
        present(UINavigationController(rootViewController: CameraController()), animated: true, completion: nil)
    }

}
