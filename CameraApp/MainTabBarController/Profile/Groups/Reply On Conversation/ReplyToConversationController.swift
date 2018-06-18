//
//  ReplyToConversationController.swift
//  CameraApp
//
//  Created by JEEVAN TIWARI on 28/04/18.
//  Copyright © 2018 JEEVAN TIWARI. All rights reserved.
//

import UIKit
import PINRemoteImage
class ReplyToConversationController: UIViewController{
    
    
    var projectId: Int?
    var chattingCell =  ReplyToCell()
    var repliesToChatData: [GroupChatDataModel]?
    var groupData: GroupChatDataModel?{
        didSet{
            getChatData()
            
        }
    }
    
    var subGroupId: Int?
    
    var currentReplyTo: GroupChatDataModel?{
        didSet{
           
            replyView.replyTextField.text = UILabel().getFullName(firstName: currentReplyTo?.UserProfile?.FirstName, lastName: currentReplyTo?.UserProfile?.LastName) + " "
        }
    }
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        chattingCell.commentView.commentLbl.text = groupData?.Comment
        chattingCell.commentView.userName.text = UILabel().getFullName(firstName: groupData?.UserProfile?.FirstName, lastName: groupData?.UserProfile?.LastName)
        
        if let userImage = groupData?.UserProfile?.ImageUrl{
            chattingCell.commentView.userImageView.pin_updateWithProgress = true
            if let imageUrl = URL(string: NetworkWebApisConstant.baseUrl + userImage){
                chattingCell.commentView.userImageView.pin_setImage(from: imageUrl)
            }
        }
        
        if let pictureArray = groupData?.File{
            if pictureArray.count > 0 {
            chattingCell.pictureHeightAnchor?.constant = (UIScreen.main.bounds.width - 32) * 9 / 16
            chattingCell.pictureData = pictureArray
            }else{
                chattingCell.pictureHeightAnchor?.constant = 0
            }
        }else{
             chattingCell.pictureHeightAnchor?.constant = 0
        }

        replyView.attachmentButton.addTarget(self, action: #selector(handleAttachment), for: .touchUpInside)
        imagePicker.delegate = self
        cameraGalleryView.camerButton.addTarget(self, action: #selector(handleCamera), for: .touchUpInside)
        cameraGalleryView.galleryButton.addTarget(self, action: #selector(handleGallery), for: .touchUpInside)
        replyView.sendButton.addTarget(self, action: #selector(handleSend), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
        navigationItem.title = "Reply to"
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationItem.title = ""
        tabBarController?.tabBar.isHidden = false
    }
    
    
    func addViews(){
        
        
        let cardView = CardView()
        cardView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        view.addSubview(cardView)
        view.addSubview(replyView)
        view.addSubview(replyTableView)
        
        
        cardView.anchorWithConstantsToTop(top: view.topAnchor, left: view.leftAnchor, bottom: replyView.topAnchor, right: view.rightAnchor, topConstant: 16, leftConstant: 16, bottomConstant: -10, rightConstant: 16)
        
        
        if #available(iOS 11.0, *){
            replyView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        }else{
                replyView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        }
        
        replyView.anchorToTop(top: nil, left: view.leftAnchor, bottom: nil, right: view.rightAnchor)
        replyView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.07).isActive = true
        
        
        
        replyTableView.anchorWithConstantsToTop(top: cardView.topAnchor, left: cardView.leftAnchor, bottom: replyView.topAnchor, right: cardView.rightAnchor, topConstant: 10, leftConstant: 0, bottomConstant: 0, rightConstant: 0)
        
        
    }
    
    let imagePicker = UIImagePickerController()
    lazy var replyView:  ReplyView = {
        let rv = ReplyView()
        rv.replyTextField.delegate = self
        return rv
    }()
    let cameraGalleryView = ReplyToGalleryCameraView()
    var selectedImages = [UIImage]()


    lazy var replyTableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints  = false
        tv.delegate = self
        tv.dataSource = self
        tv.rowHeight = UITableViewAutomaticDimension
        tv.estimatedRowHeight = 1000
        tv.separatorStyle = .none
        tv.register(ReplyToConversationCell.self, forCellReuseIdentifier: "ReplyToConversationCell")
       tv.showsVerticalScrollIndicator  = false
        return tv
        
    }()

    lazy var selectedImagesCollectionView: UICollectionView =  {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(NewConversationCell.self, forCellWithReuseIdentifier: "NewConversationCell")
        cv.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        cv.isPagingEnabled = true
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()
    
}

class ReplyView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = #colorLiteral(red: 0.9176470588, green: 0.9176470588, blue: 0.9176470588, alpha: 1)
        addViews()
    }
    
    func addViews(){
        
        let grayView = UIView()
        grayView.translatesAutoresizingMaskIntoConstraints = false
        grayView.backgroundColor = .lightGray
        
        
        addSubview(replyTextField)
        addSubview(attachmentButton)
        addSubview(sendButton)
        addSubview(grayView)
        
        sendButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        sendButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
        sendButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4).isActive = true
        sendButton.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4).isActive = true
        
        attachmentButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        attachmentButton.rightAnchor.constraint(equalTo: sendButton.leftAnchor, constant: -16).isActive = true
        attachmentButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4).isActive = true
        attachmentButton.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4).isActive = true
        
        replyTextField.anchorWithConstantsToTop(top: attachmentButton.topAnchor, left: leftAnchor, bottom: attachmentButton.bottomAnchor, right: attachmentButton.leftAnchor, topConstant: 0, leftConstant: 16, bottomConstant: 0, rightConstant: 16)
        
        grayView.anchorToTop(top: nil, left: replyTextField.leftAnchor, bottom: replyTextField.bottomAnchor, right: replyTextField.rightAnchor)
        grayView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    



//    let replyTextField: UISearchBar = {
//        let sb = UISearchBar()
//        sb.translatesAutoresizingMaskIntoConstraints = false
//        sb.placeholder = "Reply here"
//        return sb
//    }()

    lazy var replyTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints  = false
        tf.placeholder = "Reply here"
        return tf
    }()

    lazy var attachmentButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(#imageLiteral(resourceName: "attachmentImage").withRenderingMode(.alwaysTemplate), for: .normal)
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
