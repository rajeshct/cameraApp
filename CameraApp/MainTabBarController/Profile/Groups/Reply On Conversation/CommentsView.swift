//
//  CommentsView.swift
//  CameraApp
//
//  Created by JEEVAN TIWARI on 28/04/18.
//  Copyright © 2018 JEEVAN TIWARI. All rights reserved.
//

import UIKit


class CommentsView: UIView {
    
    var data: GroupChatDataModel?{
        didSet{
            if let userImage = data?.UserProfile?.ImageUrl{
                userImageView.pin_updateWithProgress = true
                userImageView.pin_setImage(from: URL(string: NetworkWebApisConstant.baseUrl + userImage)!)
            }
            
            userName.text = userName.getFullName(firstName: data?.UserProfile?.FirstName, lastName: data?.UserProfile?.LastName)
            commentLbl.text = data?.Comment
            
        }
    }
    
    var userImageHeight: NSLayoutConstraint?
    var userImageWidth: NSLayoutConstraint?

    var userDetails: String? {
        didSet{
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    override func draw(_ rect: CGRect) {
        userImageHeight?.constant = userName.frame.height + postedLabel.frame.height + 8
        userImageWidth?.constant = userName.frame.height + postedLabel.frame.height + 8
        userImageView.layer.cornerRadius = (userName.frame.height + postedLabel.frame.height + 8) / 2
    }
    
    
    func addViews(){
        
        
        let grayView = UIView()
        grayView.translatesAutoresizingMaskIntoConstraints = false
        grayView.backgroundColor = #colorLiteral(red: 0.9019607843, green: 0.9019607843, blue: 0.9019607843, alpha: 1)
        
        addSubview(userImageView)
        addSubview(userName)
        addSubview(postedLabel)
        addSubview(commentLbl)
        addSubview(grayView)
        addSubview(replyButton)
        
        userImageView.anchorWithConstantsToTop(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, topConstant: 16, leftConstant: 16, bottomConstant: 16, rightConstant: 16)
        
        userImageHeight = userImageView.heightAnchor.constraint(equalToConstant: 24)
        userImageWidth = userImageView.widthAnchor.constraint(equalToConstant: 24)
        
        userImageWidth?.isActive = true
        userImageHeight?.isActive = true
        
        userName.anchorWithConstantsToTop(top: userImageView.topAnchor, left: userImageView.rightAnchor, bottom: nil, right: rightAnchor, topConstant: 0, leftConstant: 8, bottomConstant: 0, rightConstant: 16)
        
        postedLabel.anchorWithConstantsToTop(top: userName.bottomAnchor, left: userImageView.rightAnchor, bottom: nil, right: nil, topConstant: 2, leftConstant: 8, bottomConstant: 0, rightConstant: 0)
        
        commentLbl.anchorWithConstantsToTop(top: postedLabel.bottomAnchor, left: userImageView.rightAnchor, bottom: nil, right: replyButton.leftAnchor, topConstant: 2, leftConstant: 8, bottomConstant: 16, rightConstant: 8)
        
        replyButton.anchorWithConstantsToTop(top: postedLabel.bottomAnchor, left: nil, bottom: nil, right: rightAnchor, topConstant: 2, leftConstant: 9, bottomConstant: 8, rightConstant: 16)
        replyButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        grayView.anchorWithConstantsToTop(top: commentLbl.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 4, leftConstant: 0, bottomConstant: 8, rightConstant: 0)
        grayView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    let userImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.backgroundColor = .red
        iv.clipsToBounds = true
        return iv
    }()
    
    let userName: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Thierry Madvig"
        return lbl
    }()
    
    let postedLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "30 Min ago"
        lbl.font  = UIFont(name: lbl.font.fontName, size: 12)
        return lbl
    }()
    
    
    let commentLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Hi My name is Jeevan chandra tiwari"
        lbl.numberOfLines = 0
        lbl.textColor = #colorLiteral(red: 0.568627451, green: 0.631372549, blue: 0.7529411765, alpha: 1)
        return lbl
    }()
    
    let replyButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Reply", for: .normal)
        btn.setTitleColor(#colorLiteral(red: 0.4470588235, green: 0.568627451, blue: 0.9568627451, alpha: 1), for: .normal)
        return btn
    }()
    
    
}
