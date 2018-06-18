//
//  CreateSubgroupController.swift
//  CameraApp
//
//  Created by JEEVAN TIWARI on 6/10/18.
//  Copyright © 2018 JEEVAN TIWARI. All rights reserved.
//

import UIKit

class CreateSubgroupController: UIViewController {
    
    
    
    var groupData: GroupDataModel?{
        didSet{
            setValues()
            
        }
    }
    
    var employeeList: [LoginData]?{
        didSet{
            employeeSearchList = employeeList
        }
    }
    

    var assignIds = [String: Int]()
    var employeeSearchList: [LoginData]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        addViews()
        setupController()
        
        let downGesture = UISwipeGestureRecognizer(target: self, action: #selector(hideKeyboard))
        downGesture.direction = .down
        view.addGestureRecognizer(downGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = false
        }
    }
    
   
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
        }
    }
    
    
    lazy var createSubGroup: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints  = false
        tv.delegate = self
        tv.dataSource = self
        tv.rowHeight = UITableViewAutomaticDimension
        tv.estimatedRowHeight = 1000
        tv.separatorStyle = .none
        tv.register(ProjectAssignCell.self, forCellReuseIdentifier: "ProjectAssignCell")
        tv.showsVerticalScrollIndicator  = false
        tv.allowsMultipleSelection = true
        return tv
        
    }()
    
    lazy var createButton: UIButton = {
       let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = #colorLiteral(red: 0.4470588235, green: 0.568627451, blue: 0.9568627451, alpha: 1)
        btn.setTitle("CREATE SUBGROUP", for: .normal)
        btn.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        btn.addTarget(self, action: #selector(createSubGroupServer), for: .touchUpInside)
        return btn
    }()
    
    
    let subGroupName: UILabel = {
       let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "V Finder app"
        lbl.font = UIFont.boldSystemFont(ofSize: 15)
        return lbl
    }()
    
    
    lazy var groupNameTextField: UITextField = {
        let tf  = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Group Name"
        tf.borderStyle = .none
        tf.layer.backgroundColor = UIColor.white.cgColor
        tf.layer.masksToBounds = false
        tf.layer.shadowColor = UIColor.lightGray.cgColor
        tf.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        tf.layer.shadowOpacity = 1.0
        tf.layer.shadowRadius = 0.0
        tf.delegate = self
        return tf
    }()
    
    lazy var searchNameTextField: UITextField = {
        let tf  = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Search Members"
        tf.borderStyle = .none
        tf.layer.backgroundColor = UIColor.white.cgColor
        tf.layer.masksToBounds = false
        tf.layer.shadowColor = UIColor.lightGray.cgColor
        tf.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        tf.layer.shadowOpacity = 1.0
        tf.layer.shadowRadius = 0.0
        tf.delegate = self
        return tf
    }()
    
    
}
