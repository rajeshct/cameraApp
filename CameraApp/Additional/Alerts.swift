//
//  Alerts.swift
//  CameraApp
//
//  Created by JEEVAN TIWARI on 07/04/18.
//  Copyright © 2018 JEEVAN TIWARI. All rights reserved.
//

import UIKit

class Alerts{
    
    
    static let shared = Alerts()
    
    func displaySimpleAlert(displayIn: UIViewController,title: String, message: String){
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        
        alertController.addAction(alertAction)
        displayIn.present(alertController, animated: true, completion: nil)
    }
    
}
