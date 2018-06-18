//
//  CopyrightView.swift
//  CameraApp
//
//  Created by JEEVAN TIWARI on 07/04/18.
//  Copyright © 2018 JEEVAN TIWARI. All rights reserved.
//

import UIKit

class CopyrightView: UIView{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = #colorLiteral(red: 0.9450980392, green: 0.9568627451, blue: 0.9764705882, alpha: 1)
        addViews()
    }
    
    func addViews(){
        let copyrightText = UILabel().returnTempLabel(text: "(c) All Rights Reserved @2018")
        copyrightText.textColor = #colorLiteral(red: 0.4470588235, green: 0.568627451, blue: 0.9568627451, alpha: 1)
        
        addSubview(copyrightText)
        
        copyrightText.topAnchor.constraint(equalTo: topAnchor, constant: 4).isActive = true
        copyrightText.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4).isActive = true
        
        copyrightText.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        copyrightText.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
