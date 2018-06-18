//
//  ProjectController.swift
//  CameraApp
//
//  Created by JEEVAN TIWARI on 08/04/18.
//  Copyright © 2018 JEEVAN TIWARI. All rights reserved.
//

import UIKit

class ProjectController: UIViewController{
    

    var projectId: Int? 
    var projectData: [ProjectListModel]?
    var collectionCell = ProjectControllerCollectionCell()
    var dateCollectionCell = ProjectDateCollectionCell()
    var projectTasks = [ProjectTaskModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        setup()
        getProjectList(startingDate: "0", endingDate: "0")
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "Projects"
        tabBarController?.tabBar.isHidden = false
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationItem.title = ""
       // tabBarController?.tabBar.isHidden = true
    }
    
    
    lazy var addTaskButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(#imageLiteral(resourceName: "addButtonImage").withRenderingMode(.alwaysTemplate), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints  = false
        btn.tintColor = #colorLiteral(red: 0.4470588235, green: 0.568627451, blue: 0.9568627451, alpha: 1)
        btn.addTarget(self, action: #selector(handleAddTask), for: .touchUpInside)
        return btn
    }()
    
    
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

        refreshControl.addTarget(self, action:
            #selector(handleRefresh),
                                 for: UIControlEvents.valueChanged)

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
