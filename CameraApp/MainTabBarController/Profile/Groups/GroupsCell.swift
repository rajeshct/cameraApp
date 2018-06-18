//
//  GroupsCell.swift
//  CameraApp
//
//  Created by JEEVAN TIWARI on 24/04/18.
//  Copyright © 2018 JEEVAN TIWARI. All rights reserved.
//

import UIKit


class GroupsCell: UITableViewCell{
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        addViews()
    }
    
    func addViews(){
        
        addSubview(optionText)
       // addSubview(rightView)
       // addSubview(grayView)
        
        optionText.anchorWithConstantsToTop(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 16, bottomConstant: 0, rightConstant: 16)
        
      //  grayView.anchorToTop(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
      //  grayView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
//        rightView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
//        rightView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
//        rightView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4).isActive = true
//        rightView.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let grayView = UIView().returnTempView(backgroundColor: .lightGray)
    
    
    let optionText: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .gray
        return lbl
    }()
    
//    let rightView: UIImageView = {
//            let iv = UIImageView()
//        iv.translatesAutoresizingMaskIntoConstraints = false
//        iv.image = #imageLiteral(resourceName: "moreImage").withRenderingMode(.alwaysTemplate)
//        iv.contentMode = .scaleAspectFit
//        iv.tintColor = #colorLiteral(red: 0.4470588235, green: 0.568627451, blue: 0.9568627451, alpha: 1)
//        return iv
//    }()
}
