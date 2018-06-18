//
//  CameraPhotoView.swift
//  CameraApp
//
//  Created by JEEVAN TIWARI on 28/04/18.
//  Copyright © 2018 JEEVAN TIWARI. All rights reserved.
//

import UIKit

class CameraPhotoView: UIView{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        backgroundColor = #colorLiteral(red: 0.9176470588, green: 0.9176470588, blue: 0.9176470588, alpha: 1)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func addViews(){
        addSubview(cameraButton)
        addSubview(galleryButton)
        addSubview(sendButton)
        
        cameraButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        cameraButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4).isActive = true
        cameraButton.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4).isActive = true
        cameraButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        
        galleryButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        galleryButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4).isActive = true
        galleryButton.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4).isActive = true
        galleryButton.leftAnchor.constraint(equalTo: cameraButton.rightAnchor, constant: 16).isActive = true
        
        
        sendButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        sendButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4).isActive = true
        sendButton.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4).isActive = true
        sendButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var cameraButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(#imageLiteral(resourceName: "cameraImageblack").withRenderingMode(.alwaysTemplate), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints  = false
        btn.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return btn
    }()
    
    lazy var galleryButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(#imageLiteral(resourceName: "galleryImage").withRenderingMode(.alwaysTemplate), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints  = false
        btn.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return btn
    }()
    
    lazy var sendButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(#imageLiteral(resourceName: "sendImage").withRenderingMode(.alwaysTemplate), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints  = false
        btn.tintColor = #colorLiteral(red: 0.4470588235, green: 0.568627451, blue: 0.9568627451, alpha: 1)
        return btn
    }()
}
