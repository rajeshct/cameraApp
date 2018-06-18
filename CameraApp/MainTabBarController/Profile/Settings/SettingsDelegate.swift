//
//  SettingsDelegate.swift
//  CameraApp
//
//  Created by JEEVAN TIWARI on 6/18/18.
//  Copyright © 2018 JEEVAN TIWARI. All rights reserved.
//

import UIKit

extension SettingsViewController{
    
    @objc func handleSettings(settings: UISwitch){
        
        if settings.isOn{
            settings.isOn = false
        }else{
            settings.isOn = true
        }
    }
}
