//
//  SettingsViews.swift
//  CameraApp
//
//  Created by JEEVAN TIWARI on 6/18/18.
//  Copyright © 2018 JEEVAN TIWARI. All rights reserved.
//

import UIKit

extension SettingsViewController{
    
    func addViews(){
        
        
        
        view.addSubview(privacyLabel)
        view.addSubview(privacySwitch)
        
        privacyLabel.anchorWithConstantsToTop(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: privacySwitch.leftAnchor, topConstant: 24, leftConstant: 16, bottomConstant: 0, rightConstant: 4)
        
        privacySwitch.centerYAnchor.constraint(equalTo: privacyLabel.centerYAnchor).isActive = true
        privacySwitch.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
    }
}
