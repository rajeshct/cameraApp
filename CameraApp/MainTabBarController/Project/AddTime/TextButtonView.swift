//
//  TextButtonView.swift
//  CameraApp
//
//  Created by JEEVAN TIWARI on 08/04/18.
//  Copyright © 2018 JEEVAN TIWARI. All rights reserved.
//

import UIKit

class TextButtonView: UIView{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        addViews()
        backgroundColor = .clear
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)

    }
    
    func addViews(){
    
        
        let grayView = UIView().returnTempView(backgroundColor: UIColor.lightGray)
        
        
        
        
        addSubview(buttonName)
        addSubview(selectButton)
        addSubview(grayView)
        selectButton.addSubview(dropDownImageView)
        addSubview(descriptionText)
        
        buttonName.anchorWithConstantsToTop(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 0, leftConstant: 16, bottomConstant: 0, rightConstant: 16)
        
        
       
      selectButton.anchorWithConstantsToTop(top: buttonName.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 16, bottomConstant: 0, rightConstant: 16)
        
        selectButton.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.05).isActive = true
        
        
        descriptionText.anchorWithConstantsToTop(top: buttonName.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 16, bottomConstant: 0, rightConstant: 16)
        
        descriptionText.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.05).isActive = true
        
        grayView.anchorToTop(top: nil, left: selectButton.leftAnchor, bottom: selectButton.bottomAnchor, right: selectButton.rightAnchor)
        grayView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        dropDownImageView.rightAnchor.constraint(equalTo: selectButton.rightAnchor, constant: -8).isActive = true
        dropDownImageView.centerYAnchor.constraint(equalTo: selectButton.centerYAnchor).isActive = true
        dropDownImageView.heightAnchor.constraint(equalTo: selectButton.heightAnchor, multiplier: 0.4).isActive = true
        dropDownImageView.widthAnchor.constraint(equalTo: selectButton.heightAnchor, multiplier: 0.4).isActive = true

    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    let dropDownImageView: UIImageView = {
       let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = #imageLiteral(resourceName: "dropDown")
        iv.tintColor = .lightGray
        return iv
    }()
    
    let buttonName: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = #colorLiteral(red: 0.4470588235, green: 0.568627451, blue: 0.9568627451, alpha: 1)
        lbl.text = "Project"
        return lbl
    }()
    
    lazy var selectButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Select", for: .normal)
        btn.contentHorizontalAlignment = .left
        btn.contentVerticalAlignment = .bottom
        btn.setTitleColor(.black, for: .normal)
        btn.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        //btn.addTarget(self, action: #selector(handleEnter), for: .touchUpInside)
        return btn
    }()
    
    lazy var descriptionText: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Write Description"
        return tf
    }()
    
    
}
