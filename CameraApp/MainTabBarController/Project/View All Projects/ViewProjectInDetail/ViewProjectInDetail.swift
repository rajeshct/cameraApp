//
//  ProjectController.swift
//  CameraApp
//
//  Created by JEEVAN TIWARI on 08/04/18.
//  Copyright © 2018 JEEVAN TIWARI. All rights reserved.
//

import UIKit

class ViewProjectInDetails: UIViewController{
    
    
    var projectId: Int?
    var projectData: ProjectListModel?{
        didSet{
            setup()
        }
    }
    var dateCollectionCell = ProjectDateCollectionCell()
    var projectDataCell = ViewProjectDetailCell()
    var projectTasks: [ProjectTaskModel]?{
        didSet{
            setNoTaskText()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        addViews()
        navigationItem.title = ""
    }
    
    func addViews(){
        view.addSubview(projectTableView)
        projectTableView.anchorToTop(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        
        addNoTaskView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "Projects"
        tabBarController?.tabBar.isHidden = true
        extendedLayoutIncludesOpaqueBars = true
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationItem.title = ""
       tabBarController?.tabBar.isHidden = false
        extendedLayoutIncludesOpaqueBars = false
    }
    
    
//    lazy var addTaskButton: UIButton = {
//        let btn = UIButton(type: .system)
//        btn.setImage(#imageLiteral(resourceName: "addButtonImage").withRenderingMode(.alwaysTemplate), for: .normal)
//        btn.translatesAutoresizingMaskIntoConstraints  = false
//        btn.tintColor = #colorLiteral(red: 0.4470588235, green: 0.568627451, blue: 0.9568627451, alpha: 1)
//        btn.addTarget(self, action: #selector(handleAddTask), for: .touchUpInside)
//        return btn
//    }()
//
    
    lazy var projectTableView : UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        tv.showsVerticalScrollIndicator = false
        tv.separatorStyle = .none
        tv.register(ProjectNotificationCell.self, forCellReuseIdentifier: "ProjectNotificationCell")
        tv.delegate = self
        tv.dataSource = self
        tv.estimatedRowHeight = 1000
        return tv
    }()
    
    lazy var refreshControl: UIRefreshControl = {
        
        let refreshControl = UIRefreshControl()
        
      //  refreshControl.addTarget(self, action:
          //  #selector(handleRefresh),
             //                    for: UIControlEvents.valueChanged)
        
        refreshControl.tintColor = #colorLiteral(red: 0.4470588235, green: 0.568627451, blue: 0.9568627451, alpha: 1)
        
        return refreshControl
    }()
    
    let noTaskText: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = #colorLiteral(red: 0.4470588235, green: 0.568627451, blue: 0.9568627451, alpha: 1)
        lbl.text = "No task added"
        return lbl
    }()
    
    
    let activityIndicator = ActivityIndicatorView()
    
    
    
    
    
}
