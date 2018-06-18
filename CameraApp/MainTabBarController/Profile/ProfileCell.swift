//
//  ProfileCell.swift
//  CameraApp
//
//  Created by JEEVAN TIWARI on 13/04/18.
//  Copyright © 2018 JEEVAN TIWARI. All rights reserved.
//

import UIKit


class ProfileOptionCell: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addViews()
        selectionStyle = .none
    }
    
    func addViews(){
        addSubview(optionImageView)
        addSubview(optionTextLbl)
       // addSubview(seperatorView)
        addSubview(moreImageView)
        addSubview(blueNotficationCountView)
        blueNotficationCountView.addSubview(notificationCountLabel)
        
        optionImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        optionImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        optionImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4).isActive = true
        optionImageView.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4).isActive = true
        
        
        moreImageView.rightAnchor.constraint(equalTo:rightAnchor, constant: -16).isActive = true
        moreImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        moreImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4).isActive = true
        moreImageView.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4).isActive = true
        
        
        optionTextLbl.anchorWithConstantsToTop(top: topAnchor, left: optionImageView.rightAnchor, bottom: bottomAnchor, right: moreImageView.leftAnchor, topConstant: 0, leftConstant: 16, bottomConstant: 0, rightConstant: 16)
        
      //  seperatorView.anchorToTop(top: nil, left: leftAnchor, bottom: optionTextLbl.bottomAnchor, right: rightAnchor)
      //  seperatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        blueNotficationCountView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        blueNotficationCountView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5).isActive = true
        blueNotficationCountView.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5).isActive = true
        blueNotficationCountView.rightAnchor.constraint(equalTo: moreImageView.leftAnchor, constant: -8).isActive = true
        
        
        notificationCountLabel.centerYAnchor.constraint(equalTo: blueNotficationCountView.centerYAnchor).isActive = true
        notificationCountLabel.centerXAnchor.constraint(equalTo: blueNotficationCountView.centerXAnchor).isActive = true
        
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let optionImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let moreImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = #imageLiteral(resourceName: "moreImage").withRenderingMode(.alwaysTemplate)
        iv.tintColor = #colorLiteral(red: 0.4470588235, green: 0.568627451, blue: 0.9568627451, alpha: 1)
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    let optionTextLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Jeevan Chandra"
        lbl.textColor =  .gray
        return lbl
    }()
    
    let seperatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        return view
    }()
    
    let blueNotficationCountView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.4470588235, green: 0.568627451, blue: 0.9568627451, alpha: 1)
        view.layer.cornerRadius = UIScreen.main.bounds.height * 0.07 * 0.5 / 2
        view.clipsToBounds = true
        return view
    }()
    
    let notificationCountLabel: UIView = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        lbl.font = UIFont.boldSystemFont(ofSize: 12)
        lbl.text = "3"
        return lbl
    }()
    
}
