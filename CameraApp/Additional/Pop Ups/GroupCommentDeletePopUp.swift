//
//  GroupCommentDeletePopUp.swift
//  CameraApp
//
//  Created by JEEVAN TIWARI on 16/05/18.
//  Copyright © 2018 JEEVAN TIWARI. All rights reserved.
//

import UIKit

class GroupCommentDelegatePopUp: UIView{
    
    var secondViewLeftConstraint: NSLayoutConstraint?
    var delegate: DeleteConversationDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5149828767)
        addViews()
    }
    
    
    override func draw(_ rect: CGRect) {
        cardView.transform = CGAffineTransform(translationX: 0, y: UIScreen.main.bounds.height)
        
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseIn, animations: {
            self.cardView.transform = .identity
        }, completion: nil)
        
    }
    
    
    func addViews(){
        addSubview(cardView)
        cardView.addSubview(commentTitle)
        cardView.addSubview(deleteCommentButton)
        cardView.addSubview(editCommentButton)
        addSubview(closeButton)
        addSubview(secondCardView)
        secondCardView.addSubview(secondViewTitle)
        secondCardView.addSubview(okButton)
        secondCardView.addSubview(cancelButton)
        
        cardView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        cardView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        cardView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.07 * 3).isActive = true
        cardView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9).isActive = true
        
        commentTitle.anchorToTop(top: cardView.topAnchor, left: cardView.leftAnchor, bottom: nil, right: cardView.rightAnchor)
        commentTitle.anchorWithConstantsToTop(top: cardView.topAnchor, left: cardView.leftAnchor, bottom: nil, right: cardView.rightAnchor, topConstant: 0, leftConstant: 16, bottomConstant: 0, rightConstant: 16)
        
        
        commentTitle.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.07).isActive = true
        
        editCommentButton.anchorWithConstantsToTop(top: commentTitle.bottomAnchor, left: cardView.leftAnchor, bottom: nil, right: cardView.rightAnchor, topConstant: 0, leftConstant: 16, bottomConstant: 0, rightConstant: 16)
        editCommentButton.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.07).isActive = true
        
        deleteCommentButton.anchorWithConstantsToTop(top: editCommentButton.bottomAnchor, left: cardView.leftAnchor, bottom: nil, right: cardView.rightAnchor, topConstant: 0, leftConstant: 16, bottomConstant: 0, rightConstant: 16)
        deleteCommentButton.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.07).isActive = true
        
        closeButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        closeButton.topAnchor.constraint(equalTo: cardView.bottomAnchor, constant: 16).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        secondCardView.anchorWithConstantsToTop(top: cardView.topAnchor, left: nil, bottom: cardView.bottomAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0)
        
        secondCardView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9).isActive = true
        secondViewLeftConstraint =  secondCardView.leftAnchor.constraint(equalTo: leftAnchor, constant: UIScreen.main.bounds.width)
        secondViewLeftConstraint?.isActive = true
        
        secondViewTitle.anchorWithConstantsToTop(top: secondCardView.topAnchor, left: secondCardView.leftAnchor, bottom: nil, right: secondCardView.rightAnchor, topConstant: 16, leftConstant: 16, bottomConstant: 16, rightConstant: 16)
        
        okButton.anchorWithConstantsToTop(top: nil, left: nil, bottom: secondCardView.bottomAnchor, right: secondCardView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 16, rightConstant: 16)
        
        cancelButton.anchorWithConstantsToTop(top: nil, left: nil, bottom: secondCardView.bottomAnchor, right: okButton.leftAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 16, rightConstant: 16)
        
    }

    @objc func handleDelete(){
        
        UIView.animate(withDuration: 0.4) {
           
            self.secondViewLeftConstraint?.constant = UIScreen.main.bounds.width * 0.1 / 2
            self.layoutIfNeeded()
        }
    }
    
    @objc func handleClose(){
        
       
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseIn, animations: {
            self.cardView.transform = CGAffineTransform(translationX: 0, y: UIScreen.main.bounds.height   )
            
        }) { (value) in
            self.cardView.transform = .identity
            self.removeFromSuperview()
        }
        
    }
    
    
    @objc func handleOk(){
    
        delegate?.deleteConversation()
        self.removeFromSuperview()
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let cardView: CardView = {
            let cv = CardView()
            cv.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            cv.translatesAutoresizingMaskIntoConstraints = false
            return cv
    }()
    
    lazy var editCommentButton: UIButton = {
            let btn = UIButton(type: .system)
            btn.translatesAutoresizingMaskIntoConstraints = false
            btn.setTitleColor(.black, for: .normal)
            btn.setTitle("Edit comment", for: .normal)
            btn.contentHorizontalAlignment = .left
            return btn
    }()
    
    lazy var deleteCommentButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitleColor(.black, for: .normal)
        btn.setTitle("Delete comment", for: .normal)
        btn.addTarget(self, action: #selector(handleDelete), for: .touchUpInside)
        btn.contentHorizontalAlignment = .left
        return btn
    }()
    
    let commentTitle: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = "Comment"
        title.textAlignment = .center
        title.textColor = #colorLiteral(red: 0.4470588235, green: 0.568627451, blue: 0.9568627451, alpha: 1)
        return title
    }()
    
    lazy var closeButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(handleClose), for: .touchUpInside)
        btn.setImage(#imageLiteral(resourceName: "closeImage").withRenderingMode(.alwaysTemplate), for: .normal)
        btn.tintColor = .white
        return btn
    }()
    
    let secondCardView: CardView = {
        let cv = CardView()
        cv.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    
    let secondViewTitle: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = "Are you sure want to delete message permanently?"
        title.numberOfLines = 0
        title.textAlignment = .center
        title.textColor = #colorLiteral(red: 0.4470588235, green: 0.568627451, blue: 0.9568627451, alpha: 1)
        return title
    }()
    
    
    lazy var okButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitleColor(.black, for: .normal)
        btn.setTitle("DELETE", for: .normal)
        btn.addTarget(self, action: #selector(handleOk), for: .touchUpInside)
        return btn
    }()
    
    lazy var cancelButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitleColor(.black, for: .normal)
        btn.setTitle("CANEL", for: .normal)
        return btn
    }()
    
    
    
}


