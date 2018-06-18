//
//  GroupChatController.swift
//  CameraApp
//
//  Created by JEEVAN TIWARI on 28/04/18.
//  Copyright © 2018 JEEVAN TIWARI. All rights reserved.
//

import UIKit

class GroupChatController: UIViewController{
    
    var groupData: GroupDataModel?{
        didSet{
          //  getChats()
            createSubGroup()
            
        }
    }
    
    var subGroupData: SubGroupModel?{
        didSet{
           // getSubGroupData()
            
        }
    }
    
    var groupChatData: [GroupChatDataModel]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let _ = groupData{
            getChats()
            navigationItem.title = groupData?.ProjectName
        }
        
        if let _ = subGroupData{
            getSubGroupData()
            navigationItem.title = subGroupData?.SubGroupName
        }
        tabBarController?.tabBar.isHidden = true
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationItem.title  = ""
        tabBarController?.tabBar.isHidden = false
        
    }
    
    
    
    func addViews(){
        
        view.addSubview(groupChatTableView)
        view.addSubview(startConverstationButton)
        
        
        groupChatTableView.anchorToTop(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        
        if #available(iOS 11.0, *){
            startConverstationButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16).isActive = true
        }else{
            startConverstationButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16).isActive = true
        }
        
        startConverstationButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        startConverstationButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        startConverstationButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        
    }
    
    
    lazy var groupChatTableView : UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        tv.rowHeight = UITableViewAutomaticDimension
        tv.estimatedRowHeight = 1000
        tv.register(GroupChatCellWithComment.self, forCellReuseIdentifier: "GroupChatCellWithComment")
        tv.register(GroupChatCellWithCommentAndPicture.self, forCellReuseIdentifier: "GroupChatCellWithCommentAndPicture")
        tv.register(GroupChatCellWithCommentAndPic.self, forCellReuseIdentifier: "GroupChatCellWithCommentAndPic")
        tv.separatorStyle = .none
        tv.addSubview(self.refreshControl)
        tv.delegate = self
        tv.dataSource = self
        tv.showsVerticalScrollIndicator = false
        return tv
    }()
    
    
    lazy var startConverstationButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(#imageLiteral(resourceName: "addButtonImage").withRenderingMode(.alwaysTemplate), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints  = false
        btn.tintColor = #colorLiteral(red: 0.4470588235, green: 0.568627451, blue: 0.9568627451, alpha: 1)
        btn.addTarget(self, action: #selector(handleNewConversation), for: .touchUpInside)
        return btn
    }()
    
    
    lazy var refreshControl: UIRefreshControl = {
        
        let refreshControl = UIRefreshControl()
        
        refreshControl.addTarget(self, action:
            #selector(handleRefresh),
                                 for: UIControlEvents.valueChanged)
        
        refreshControl.tintColor = #colorLiteral(red: 0.4470588235, green: 0.568627451, blue: 0.9568627451, alpha: 1)
        
        return refreshControl
    }()
    
    let activityIndicator = ActivityIndicatorView()
    
}
