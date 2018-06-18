//
//  ReplyToConverationCell.swift
//  CameraApp
//
//  Created by JEEVAN TIWARI on 28/04/18.
//  Copyright © 2018 JEEVAN TIWARI. All rights reserved.
//

import UIKit

class ReplyToConversationCell: UITableViewCell{
    
    
    var data: GroupChatDataModel?{
        didSet{
            commentView.data = data
        }
    }
    
    var parentInstance: ReplyToConversationController?
    
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addViews()
    }
    
    func addViews(){
        addSubview(commentView)
       
        
        
        commentView.anchorToTop(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
       
        
        
    }
    
    @objc func handleReply(){
        
        parentInstance?.currentReplyTo = data
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var commentView: CommentsView = {
        let cv = CommentsView()
        cv.replyButton.addTarget(self, action: #selector(handleReply), for: .touchUpInside)
        return cv
    }()
    
    
    
}


class ReplyToCell: UITableViewCell{
    
    var pictureHeightAnchor: NSLayoutConstraint?
    var pictureData: [UserProfileFileModel]?{
        didSet{
            pictureCollectionView.reloadData()
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addViews()
    }
    
    func addViews(){
        addSubview(commentView)
         addSubview(pictureCollectionView)
        
        
        commentView.anchorToTop(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor)
        
        
        pictureCollectionView.anchorWithConstantsToTop(top: commentView.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 16, bottomConstant: 0, rightConstant: 16)
        pictureHeightAnchor = pictureCollectionView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 9 / 16)
        pictureHeightAnchor?.isActive = true
    }
    
    @objc func handleSeenBy(){
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let commentView = UserNameCommentView()
    
    lazy var pictureCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .red
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        cv.register(UserNameCollectionViewCell.self, forCellWithReuseIdentifier: "UserNameCollectionViewCell")
        cv.isPagingEnabled = true
        return cv
    }()
    
//    lazy var commentView: CommentsView = {
//        let cv =  CommentsView()
//        cv.replyButton.setTitle("Seen By 1", for: .normal)
//        cv.replyButton.addTarget(self, action: #selector(handleSeenBy), for: .touchUpInside)
//        return cv
//    }()
    
}



