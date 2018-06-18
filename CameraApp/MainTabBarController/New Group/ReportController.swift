//
//  ReportController.swift
//  CameraApp
//
//  Created by JEEVAN TIWARI on 13/04/18.
//  Copyright © 2018 JEEVAN TIWARI. All rights reserved.
//

import UIKit

class ReportController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let isLogin = UserDefaults.standard.value(forKey: "isLogin") as? Bool{
            let loginObj = LoginController()
            loginObj.useFingerPrint = true
            present(UINavigationController(rootViewController: loginObj), animated: true, completion: nil)
        }else{
            let loginObj = LoginController()
            //loginObj.reportDelegate = self
            
            present(UINavigationController(rootViewController: loginObj), animated: true, completion: nil)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "Projects"
        tabBarController?.tabBar.isHidden = false
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationItem.title = ""
       // tabBarController?.tabBar.isHidden = true
    }
    
    
    
}


extension ReportController: PresentCameraDelegate{

    func presentCamera() {
        present(UINavigationController(rootViewController: CameraController()), animated: false, completion: nil)
    }




}

