//
//  NewConversationController.swift
//  CameraApp
//
//  Created by JEEVAN TIWARI on 28/04/18.
//  Copyright © 2018 JEEVAN TIWARI. All rights reserved.
//

import UIKit

class NewConversationController: UIViewController{
    
    var selectedImages = [UIImage]()
    var keyboardHeight: CGFloat = 0
    var projectId: Int?
    var groupData: GroupChatDataModel?
    var sendViewConstraint: NSLayoutConstraint?
    var subGroupData: SubGroupModel?

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        addViews()
        imagePicker.delegate = self
        sendView.galleryButton.addTarget(self, action: #selector(handleGallery), for: .touchUpInside)
        sendView.cameraButton.addTarget(self, action: #selector(handleCamera), for: .touchUpInside)
        sendView.sendButton.addTarget(self, action: #selector(handleSend), for: .touchUpInside)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: NSNotification.Name.UIKeyboardWillShow,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: NSNotification.Name.UIKeyboardWillHide,
            object: nil
        )
    }
    
    func addViews(){
        view.addSubview(sendView)
        view.addSubview(selectedImagesCollectionView)
        view.addSubview(chatCommentTextView)
        addKeyboardDelegate()
        prefillValues()
        
        
        if #available(iOS 11.0, *){
            sendViewConstraint = sendView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: 0)
            sendViewConstraint?.isActive = true
        }else{
            sendViewConstraint = sendView.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: 0)
            sendViewConstraint?.isActive = true
        }

        
        sendView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.07).isActive = true
        sendView.anchorToTop(top: nil, left: view.leftAnchor, bottom: nil, right: view.rightAnchor)

        
        selectedImagesCollectionView.anchorWithConstantsToTop(top: nil, left: view.leftAnchor, bottom: sendView.topAnchor, right: sendView.rightAnchor, topConstant: 0, leftConstant: 16, bottomConstant: 16, rightConstant: 16)
        selectedImagesCollectionView.heightAnchor.constraint(equalToConstant: 100).isActive  = true
        
        chatCommentTextView.anchorWithConstantsToTop(top: view.topAnchor, left: view.leftAnchor, bottom: selectedImagesCollectionView.topAnchor, right: view.rightAnchor, topConstant: 16, leftConstant: 16, bottomConstant: 16, rightConstant: 16)

        
    }
    
    
    
    func prefillValues(){
        if let _ = groupData?.Comment{
            chatCommentTextView.text = groupData?.Comment
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "New Conversation"
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    let sendView = CameraPhotoView()
    let imagePicker = UIImagePickerController()
    
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
    
    lazy var chatCommentTextView: UITextView = {
        let tv = UITextView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv .text = "Start new conversation..."
        tv.delegate = self
        return tv
    }()
    
    let activityIndicator = ActivityIndicatorView()
    
    
    
    
}
