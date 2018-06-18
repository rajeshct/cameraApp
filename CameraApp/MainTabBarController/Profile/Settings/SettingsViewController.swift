//
//  SettingsViewController.swift
//  CameraApp
//
//  Created by JEEVAN TIWARI on 6/18/18.
//  Copyright © 2018 JEEVAN TIWARI. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        addViews()
        navigationItem.title = "Settings"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    
    
    let privacySwitch: UISwitch = {
       let settings = UISwitch()
        settings.translatesAutoresizingMaskIntoConstraints = false
        settings.isOn = false
        settings.tintColor = #colorLiteral(red: 0.4470588235, green: 0.568627451, blue: 0.9568627451, alpha: 1)
        settings.onTintColor = #colorLiteral(red: 0.4470588235, green: 0.568627451, blue: 0.9568627451, alpha: 1)
        settings.addTarget(self, action: #selector(handleSettings(settings:)), for: .touchUpInside)
        return settings
    }()
    
    let privacyLabel: UILabel = {
       let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Turn on application protection"
        return lbl
    }()
}
