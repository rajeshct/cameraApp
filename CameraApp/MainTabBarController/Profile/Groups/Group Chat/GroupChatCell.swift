//
//  GroupChatCell.swift
//  CameraApp
//
//  Created by JEEVAN TIWARI on 28/04/18.
//  Copyright © 2018 JEEVAN TIWARI. All rights reserved.
//

import UIKit
import PINRemoteImage


// if comment available, file array is empty

class GroupChatCellWithComment: UITableViewCell{
    
    var item: Int?
    var delegate: ViewFullConversationDelegate?
    
    var data: GroupChatDataModel?{
        didSet{
            setData()
        
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        addViews()
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongGesture(longPress:)))
        
        addGestureRecognizer(longPressGesture)
    }
    
    
    func setData(){
      
        userNameCommentView.data = data
        
        if let childCount = data?.TotalChildCount {
            viewfullConversationButton.setTitle("View full Conversation (" + String(childCount) + ")", for: .normal)
        }
        
        
        if let comments = data?.ChildComment{
            
            if comments.count > 1 {
                
                
                commentLbl.attributedText =  commentLbl.getConversation(userName1: UILabel().getFullName(firstName: comments[0].UserProfile?.FirstName, lastName: comments[0].UserProfile?.LastName), userName2: UILabel().getFullName(firstName: comments[1].UserProfile?.FirstName, lastName: comments[1].UserProfile?.LastName), firstName: comments[0].Comment, lastName: comments[1].Comment)
                
            }else if comments.count == 2{
                commentLbl.text = comments[1].Comment
            }
            
        }
        
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        viewfullConversationButton.addCornerRadius(btn: viewfullConversationButton)
        userNameCommentView.seenByLabel.addTarget(self, action: #selector(handleSeenBy), for: .touchUpInside)
    }
    
    
    @objc func handleEdit(button: UIButton){
        editDeleteObj.handleClose()
        delegate?.handleEdit(item: item)
    }
    
    
    
    @objc func handleLongGesture(longPress: UILongPressGestureRecognizer){
        
        if let window = UIApplication.shared.keyWindow{
            
            editDeleteObj.delegate = self
            editDeleteObj.editCommentButton.addTarget(self, action: #selector(handleEdit(button:)), for: .touchUpInside)
            window.addSubview(editDeleteObj)
            editDeleteObj.anchorToTop(top: window.topAnchor, left: window.leftAnchor, bottom: window.bottomAnchor, right: window.rightAnchor)
            
        }
        
    }
    
    @objc func handleSeenBy(){
        
        delegate?.handleSeenBy(commentId: data?.CommentId)
    }
    
    
    
    func addViews(){
        
        let cardView = CardView()
        cardView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        addSubview(cardView)
        addSubview(userNameCommentView)
        addSubview(commentLbl)
        addSubview(viewfullConversationButton)
        
        cardView.anchorWithConstantsToTop(top: topAnchor, left: leftAnchor, bottom: viewfullConversationButton.bottomAnchor, right: rightAnchor, topConstant: 16, leftConstant: 16, bottomConstant: 0, rightConstant: 16)
        
        userNameCommentView.anchorWithConstantsToTop(top: cardView.topAnchor, left: cardView.leftAnchor, bottom: nil, right: cardView.rightAnchor, topConstant: 8, leftConstant: 0, bottomConstant: 16, rightConstant: 0)
        
        
        
        commentLbl.anchorWithConstantsToTop(top: userNameCommentView.bottomAnchor, left: cardView.leftAnchor, bottom: nil, right: cardView.rightAnchor, topConstant: 16, leftConstant: 16, bottomConstant: 16, rightConstant: 16)
        
        viewfullConversationButton.anchorWithConstantsToTop(top: commentLbl.bottomAnchor, left: cardView.leftAnchor, bottom: bottomAnchor, right: cardView.rightAnchor, topConstant: 16, leftConstant: 0, bottomConstant: 8, rightConstant: 0)
        
        
        
    }
    
    @objc func handleFullConversation(){
        if let getItem = item{
            delegate?.handleFullConversation(item: getItem)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let userNameCommentView = UserNameCommentView()
    
    let commentLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        return lbl
    }()
    
    lazy var viewfullConversationButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("View full Conversation (4)", for: .normal)
        btn.setTitleColor(#colorLiteral(red: 0.4470588235, green: 0.568627451, blue: 0.9568627451, alpha: 1), for: .normal)
        btn.backgroundColor = #colorLiteral(red: 0.9294117647, green: 0.9411764706, blue: 0.9568627451, alpha: 1)
        btn.addTarget(self, action: #selector(handleFullConversation), for: .touchUpInside)
        return btn
    }()
    
    let editDeleteObj = GroupCommentDelegatePopUp()
}



// if comment available, file array is not empty

class GroupChatCellWithCommentAndPicture: UITableViewCell{
    
    var data: GroupChatDataModel?{
        didSet{
            commentLbl.text = data?.Comment
            userCommentCollection.data = data
            
            if let childCount = data?.TotalChildCount {
                viewfullConversationButton.setTitle("View full Conversation (" + String(childCount) + ")", for: .normal)
            }
            
            
            if let comments = data?.ChildComment{
                
                if comments.count > 1 {
                    
                    
                    commentLbl.attributedText =  commentLbl.getConversation(userName1: UILabel().getFullName(firstName: comments[0].UserProfile?.FirstName, lastName: comments[0].UserProfile?.LastName), userName2: UILabel().getFullName(firstName: comments[1].UserProfile?.FirstName, lastName: comments[1].UserProfile?.LastName), firstName: comments[0].Comment, lastName: comments[1].Comment)
                    
                }else if comments.count == 2{
                    commentLbl.text = comments[1].Comment
                }
                
            }
            
        }
    }
    
    var item: Int?
    var delegate: ViewFullConversationDelegate?
    var viewFullHeightAnchor: NSLayoutConstraint?
    
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addViews()
        selectionStyle = .none
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongGesture(longPress:)))
        
        addGestureRecognizer(longPressGesture)
    }
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        viewfullConversationButton.addCornerRadius(btn: viewfullConversationButton)
        userCommentCollection.seenByLabel.addTarget(self, action: #selector(handleSeenBy), for: .touchUpInside)
        
    }
    
    
    func addViews(){
        
        let cardView = CardView()
        cardView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        addSubview(cardView)
        addSubview(userCommentCollection)
        addSubview(commentLbl)
        addSubview(viewfullConversationButton)
        
        cardView.anchorWithConstantsToTop(top: topAnchor, left: leftAnchor, bottom: viewfullConversationButton.bottomAnchor, right: rightAnchor, topConstant: 16, leftConstant: 16, bottomConstant: 0, rightConstant: 16)
        
        userCommentCollection.anchorWithConstantsToTop(top: cardView.topAnchor, left: cardView.leftAnchor, bottom: nil, right: cardView.rightAnchor, topConstant: 8, leftConstant: 0, bottomConstant: 16, rightConstant: 0)
        
        
        
        commentLbl.anchorWithConstantsToTop(top: userCommentCollection.bottomAnchor, left: cardView.leftAnchor, bottom: nil, right: cardView.rightAnchor, topConstant: 16, leftConstant: 16, bottomConstant: 16, rightConstant: 16)
        
        viewfullConversationButton.anchorWithConstantsToTop(top: commentLbl.bottomAnchor, left: cardView.leftAnchor, bottom: bottomAnchor, right: cardView.rightAnchor, topConstant: 16, leftConstant: 0, bottomConstant: 8, rightConstant: 0)
        
        
    }
    
    @objc func handleEdit(){
        editDeleteObj.handleClose()
        delegate?.handleEdit(item: item)
    }
    
    
    
    @objc func handleLongGesture(longPress: UILongPressGestureRecognizer){
        
        if let window = UIApplication.shared.keyWindow{
            editDeleteObj.delegate = self
            editDeleteObj.editCommentButton.addTarget(self, action: #selector(handleEdit), for: .touchUpInside)
            window.addSubview(editDeleteObj)
            editDeleteObj.anchorToTop(top: window.topAnchor, left: window.leftAnchor, bottom: window.bottomAnchor, right: window.rightAnchor)
            
        }
        
        
        
    }
    
    
    
    
    @objc func handleFullConversation(){
        if let getItem = item{
            delegate?.handleFullConversation(item: getItem)
        }
        
    }
    
    @objc func handleSeenBy(){
        
        delegate?.handleSeenBy(commentId: data?.CommentId)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    let userCommentCollection = UserNameCollectionView()
    
    let commentLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Hi My name is Jeevan chandra tiwari hi I am implemnting something coll hope you like it"
        lbl.numberOfLines = 0
        return lbl
    }()
    
    lazy var viewfullConversationButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("View full Conversation (4)", for: .normal)
        btn.setTitleColor(#colorLiteral(red: 0.4470588235, green: 0.568627451, blue: 0.9568627451, alpha: 1), for: .normal)
        btn.addTarget(self, action: #selector(handleFullConversation), for: .touchUpInside)
        btn.backgroundColor = #colorLiteral(red: 0.9294117647, green: 0.9411764706, blue: 0.9568627451, alpha: 1)
        return btn
    }()
    
    let editDeleteObj = GroupCommentDelegatePopUp()
}


// Comment and picture available

class GroupChatCellWithCommentAndPic: UITableViewCell{
    
    
    var data: GroupChatDataModel?{
        didSet{
            commentLbl.text = data?.Comment
            userNameCommentView.data = data
            
            if let childCount = data?.TotalChildCount {
                viewfullConversationButton.setTitle("View full Conversation " + String(childCount), for: .normal)
            }
        }
    }
    
    var item: Int?
    var delegate: ViewFullConversationDelegate?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addViews()
        selectionStyle = .none
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongGesture(longPress:)))
        
        addGestureRecognizer(longPressGesture)
    }
    
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        viewfullConversationButton.addCornerRadius(btn: viewfullConversationButton)
    }
    
    
    func addViews(){
        
        let cardView = CardView()
        cardView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        addSubview(cardView)
        addSubview(userNameCommentView)
        addSubview(commentLbl)
        addSubview(viewfullConversationButton)
        
        cardView.anchorWithConstantsToTop(top: topAnchor, left: leftAnchor, bottom: viewfullConversationButton.bottomAnchor, right: rightAnchor, topConstant: 16, leftConstant: 16, bottomConstant: 0, rightConstant: 16)
        
        userNameCommentView.anchorWithConstantsToTop(top: cardView.topAnchor, left: cardView.leftAnchor, bottom: nil, right: cardView.rightAnchor, topConstant: 8, leftConstant: 0, bottomConstant: 16, rightConstant: 0)
        
        
        
        commentLbl.anchorWithConstantsToTop(top: userNameCommentView.bottomAnchor, left: cardView.leftAnchor, bottom: nil, right: cardView.rightAnchor, topConstant: 16, leftConstant: 16, bottomConstant: 16, rightConstant: 16)
        
        viewfullConversationButton.anchorWithConstantsToTop(top: commentLbl.bottomAnchor, left: cardView.leftAnchor, bottom: bottomAnchor, right: cardView.rightAnchor, topConstant: 16, leftConstant: 0, bottomConstant: 8, rightConstant: 0)
        
        
        
    }
    
    @objc func handleEdit(){
        editDeleteObj.handleClose()
        delegate?.handleEdit(item: item)
    }
    
    
    @objc func handleLongGesture(longPress: UILongPressGestureRecognizer){
        
        if let window = UIApplication.shared.keyWindow{
            editDeleteObj.delegate = self
            editDeleteObj.editCommentButton.addTarget(self, action: #selector(handleEdit), for: .touchUpInside)
            window.addSubview(editDeleteObj)
            editDeleteObj.anchorToTop(top: window.topAnchor, left: window.leftAnchor, bottom: window.bottomAnchor, right: window.rightAnchor)
            
        }
        
        
        
        
        
    }
    
    @objc func handleFullConversation(){
        if let getItem = item{
            delegate?.handleFullConversation(item: getItem)
        }
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let userNameCommentView = UserNameCommentCollectionView()
    
    let commentLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Hi My name is Jeevan chandra tiwari hi I am implemnting something coll hope you like it"
        lbl.numberOfLines = 0
        return lbl
    }()
    
    lazy var viewfullConversationButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("View full Conversation (4)", for: .normal)
        btn.setTitleColor(#colorLiteral(red: 0.4470588235, green: 0.568627451, blue: 0.9568627451, alpha: 1), for: .normal)
        btn.backgroundColor = #colorLiteral(red: 0.9294117647, green: 0.9411764706, blue: 0.9568627451, alpha: 1)
        btn.addTarget(self, action: #selector(handleFullConversation), for: .touchUpInside)
        return btn
    }()
    
    let editDeleteObj = GroupCommentDelegatePopUp()
}


// Common Name and chat View

class UserNameCommentView: UIView {
    
    var data: GroupChatDataModel?{
        didSet{
            
            userName.text = userName.getFullName(firstName: data?.UserProfile?.FirstName, lastName: data?.UserProfile?.LastName)
            commentLbl.text = data?.Comment
      
                if let userImage = data?.UserProfile?.ImageUrl{
                    userImageView.pin_updateWithProgress = true
                    if let imageUrl = URL(string: NetworkWebApisConstant.baseUrl + userImage){
                    userImageView.pin_setImage(from: imageUrl)
                    }
                }
            
            if let userSeenCount = data?.seenCount{
                seenByLabel.setTitle("Seen by \(String(userSeenCount))", for: .normal)
                
            }
    
            
        }
    }
    
    var userImageHeight: NSLayoutConstraint?
    var userImageWidth: NSLayoutConstraint?
    
   
    
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
        grayView.backgroundColor = .lightGray
        addSubview(userImageView)
        addSubview(userName)
        addSubview(seenByLabel)
        addSubview(postedLabel)
        addSubview(commentLbl)
        addSubview(grayView)
        
        userImageView.anchorWithConstantsToTop(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, topConstant: 16, leftConstant: 16, bottomConstant: 16, rightConstant: 16)
        
        userImageHeight = userImageView.heightAnchor.constraint(equalToConstant: 24)
        userImageWidth = userImageView.widthAnchor.constraint(equalToConstant: 24)
        
        userImageWidth?.isActive = true
        userImageHeight?.isActive = true
        
        userName.anchorWithConstantsToTop(top: userImageView.topAnchor, left: userImageView.rightAnchor, bottom: nil, right: rightAnchor, topConstant: 0, leftConstant: 16, bottomConstant: 0, rightConstant: 16)
        
        postedLabel.anchorWithConstantsToTop(top: userName.bottomAnchor, left: userImageView.rightAnchor, bottom: nil, right: nil, topConstant: 8, leftConstant: 16, bottomConstant: 0, rightConstant: 0)
        
        commentLbl.anchorWithConstantsToTop(top: postedLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 16, leftConstant: 16, bottomConstant: 16, rightConstant: 16)
        
        seenByLabel.anchorWithConstantsToTop(top: commentLbl.bottomAnchor, left: nil, bottom: nil, right: rightAnchor, topConstant: 2, leftConstant: 9, bottomConstant: 8, rightConstant: 16)
        
        
        grayView.anchorWithConstantsToTop(top: seenByLabel.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 4, leftConstant: 0, bottomConstant: 8, rightConstant: 0)
        grayView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
    }
    
    
    @objc func handleSeenBy(){
        
        
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
        lbl.textColor = #colorLiteral(red: 0.568627451, green: 0.631372549, blue: 0.7529411765, alpha: 1)
        lbl.numberOfLines = 0
        return lbl
    }()
    
    lazy var seenByLabel: UIButton = {
        let lbl = UIButton(type: .system)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        lbl.setTitleColor(.black, for: .normal)
        return lbl
    }()
}


// Common Name and chat View

class UserNameCollectionView: UIView {
    
    var data: GroupChatDataModel?{
        didSet{
           
            userName.text = getFullName(firstName: data?.UserProfile?.FirstName, lastName: data?.UserProfile?.LastName)
            
            if let userImage = data?.UserProfile?.ImageUrl{
                userImageView.pin_updateWithProgress = true
                if let imageUrl = URL(string: NetworkWebApisConstant.baseUrl + userImage){
                    userImageView.pin_setImage(from: imageUrl)
                }
                
            }
            
            if let userSeenCount = data?.seenCount{
                seenByLabel.setTitle("Seen by \(String(userSeenCount))", for: .normal)
                
            }
            
            
            
            pictureCollectionView.reloadData()
        }
    }
    
    
    var userImageHeight: NSLayoutConstraint?
    var userImageWidth: NSLayoutConstraint?
    
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
    
    func getFullName(firstName: String?, lastName: String?) -> String{
        
        var fullName = ""
        
        if let first = firstName{
            fullName = fullName + first
        }
        
        if let second = lastName{
            fullName = fullName + second
        }
        
        return fullName
    }
    
    
    func addViews(){
        
        
        let grayView = UIView()
        grayView.translatesAutoresizingMaskIntoConstraints = false
        grayView.backgroundColor = .lightGray
        addSubview(userImageView)
        addSubview(userName)
        addSubview(seenByLabel)
        addSubview(postedLabel)
        addSubview(pictureCollectionView)
        addSubview(grayView)
        
        userImageView.anchorWithConstantsToTop(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, topConstant: 16, leftConstant: 16, bottomConstant: 16, rightConstant: 16)
        
        userImageHeight = userImageView.heightAnchor.constraint(equalToConstant: 24)
        userImageWidth = userImageView.widthAnchor.constraint(equalToConstant: 24)
        
        userImageWidth?.isActive = true
        userImageHeight?.isActive = true
        
        userName.anchorWithConstantsToTop(top: userImageView.topAnchor, left: userImageView.rightAnchor, bottom: nil, right: rightAnchor, topConstant: 0, leftConstant: 16, bottomConstant: 0, rightConstant: 16)
        
        postedLabel.anchorWithConstantsToTop(top: userName.bottomAnchor, left: userImageView.rightAnchor, bottom: nil, right: nil, topConstant: 8, leftConstant: 16, bottomConstant: 0, rightConstant: 0)
        
        pictureCollectionView.anchorWithConstantsToTop(top: postedLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 16, leftConstant: 16, bottomConstant: 16, rightConstant: 16)
        
        pictureCollectionView.heightAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width - 64) * 9 / 16).isActive = true
        
        seenByLabel.anchorWithConstantsToTop(top: pictureCollectionView.bottomAnchor, left: nil, bottom: nil, right: rightAnchor, topConstant: 2, leftConstant: 9, bottomConstant: 8, rightConstant: 16)
        
        
        grayView.anchorWithConstantsToTop(top: seenByLabel.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 4, leftConstant: 0, bottomConstant: 8, rightConstant: 0)
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
    
    
    lazy var pictureCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
       cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        cv.register(UserNameCollectionViewCell.self, forCellWithReuseIdentifier: "UserNameCollectionViewCell")
        cv.isPagingEnabled = true
        return cv
    }()
    
    lazy var seenByLabel: UIButton = {
        let lbl = UIButton(type: .system)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        lbl.setTitleColor(.black, for: .normal)
        return lbl
    }()
    
}



class UserNameCommentCollectionView: UIView {
    
    var data: GroupChatDataModel?{
        didSet{
            commentLabel.text = data?.Comment
            userName.text = getFullName(firstName: data?.UserProfile?.FirstName, lastName: data?.UserProfile?.LastName)
            
            if let userImage = data?.UserProfile?.ImageUrl{
                userImageView.pin_updateWithProgress = true
                if let imageUrl = URL(string: NetworkWebApisConstant.baseUrl + userImage){
                    userImageView.pin_setImage(from: imageUrl)
                }
                
            }
            
            
            
            pictureCollectionView.reloadData()
        }
    }
    
    
    var userImageHeight: NSLayoutConstraint?
    var userImageWidth: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func getFullName(firstName: String?, lastName: String?) -> String{
        
        var fullName = ""
        
        if let first = firstName{
            fullName = fullName + first
        }
        
        if let second = lastName{
            fullName = fullName + second
        }
        
        return fullName
    }
    
    override func draw(_ rect: CGRect) {
        userImageHeight?.constant = userName.frame.height + postedLabel.frame.height + 8
        userImageWidth?.constant = userName.frame.height + postedLabel.frame.height + 8
        userImageView.layer.cornerRadius = (userName.frame.height + postedLabel.frame.height + 8) / 2
    }
    
    
    func addViews(){
        
        
        let grayView = UIView()
        grayView.translatesAutoresizingMaskIntoConstraints = false
        grayView.backgroundColor = .lightGray
        addSubview(userImageView)
        addSubview(userName)
        addSubview(seenByLabel)
        addSubview(postedLabel)
        addSubview(pictureCollectionView)
        addSubview(grayView)
        addSubview(commentLabel)
        
        userImageView.anchorWithConstantsToTop(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, topConstant: 16, leftConstant: 16, bottomConstant: 16, rightConstant: 16)
        
        userImageHeight = userImageView.heightAnchor.constraint(equalToConstant: 24)
        userImageWidth = userImageView.widthAnchor.constraint(equalToConstant: 24)
        
        userImageWidth?.isActive = true
        userImageHeight?.isActive = true
        
        userName.anchorWithConstantsToTop(top: userImageView.topAnchor, left: userImageView.rightAnchor, bottom: nil, right: rightAnchor, topConstant: 0, leftConstant: 16, bottomConstant: 0, rightConstant: 16)
        
        postedLabel.anchorWithConstantsToTop(top: userName.bottomAnchor, left: userImageView.rightAnchor, bottom: nil, right: nil, topConstant: 8, leftConstant: 16, bottomConstant: 0, rightConstant: 0)
        
        commentLabel.anchorWithConstantsToTop(top: postedLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 4, leftConstant: 16, bottomConstant: 0 , rightConstant:  16)
        
        
        pictureCollectionView.anchorWithConstantsToTop(top: commentLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 16, leftConstant: 16, bottomConstant: 16, rightConstant: 16)
        
        pictureCollectionView.heightAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width - 64) * 9 / 16).isActive = true
        
        seenByLabel.anchorWithConstantsToTop(top: pictureCollectionView.bottomAnchor, left: nil, bottom: nil, right: rightAnchor, topConstant: 2, leftConstant: 9, bottomConstant: 8, rightConstant: 16)
        
        
        grayView.anchorWithConstantsToTop(top: seenByLabel.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 4, leftConstant: 0, bottomConstant: 8, rightConstant: 0)
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
    
    
    let commentLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Hi I am updating policis of the world"
        lbl.font  = UIFont(name: lbl.font.fontName, size: 12)
        return lbl
    }()
    
    
    
    lazy var pictureCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        cv.register(UserNameCollectionViewCell.self, forCellWithReuseIdentifier: "UserNameCollectionViewCell")
        cv.isPagingEnabled = true
        return cv
    }()
    
    let seenByLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Seen by 3"
        lbl.font = UIFont(name: lbl.font.fontName, size: 12)
        return lbl
    }()
}


class UserNameCollectionViewCell: UICollectionViewCell{
    
    var imageName: String?{
        didSet{
            if let replyImage = imageName{
                commentImageView.pin_updateWithProgress = true
                if let imageUrl = URL(string: NetworkWebApisConstant.baseUrl + replyImage){
                   commentImageView.pin_setImage(from: imageUrl)
                }
                
            }
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
    
    func addViews(){
     addSubview(commentImageView)
    commentImageView.anchorToTop(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let commentImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.backgroundColor = .red
        return iv
    }()
}
