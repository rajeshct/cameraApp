//
//  GroupsController.swift
//  CameraApp
//
//  Created by JEEVAN TIWARI on 24/04/18.
//  Copyright © 2018 JEEVAN TIWARI. All rights reserved.
//

import UIKit

class GroupController: UITableViewController{
    
    var groupDataModel: [GroupDataModel]?
    var groupSectionData  =  [Section]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        tableView.register(GroupsCell.self, forCellReuseIdentifier: "GroupsCell")
       // tableView.separatorStyle = .none
        getGroupList()
        getGroupAssignIds()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "Groups"
        tabBarController?.tabBar.isHidden = true
        
        
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor: #colorLiteral(red: 0.4470588235, green: 0.568627451, blue: 0.9568627451, alpha: 1), NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 24)]
        }
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationItem.title = ""
        tabBarController?.tabBar.isHidden = false
    }
    
    
    var activityIndicator  = ActivityIndicatorView()
    
    
    
    
    
}


//
// MARK: - Section Header Delegate
//
extension GroupController: CollapsibleTableViewHeaderDelegate {
   
    func groupTapped(item: Int) {
        print("Group Taapped")
        
        let groupChatObj = GroupChatController()
        groupChatObj.groupData = groupDataModel?[item]
        navigationController?.pushViewController(groupChatObj, animated: true)
        
        
    }
    
    
    func toggleSection(_ header: CollapsibleTableViewHeader, section: Int) {
        let collapsed = !groupSectionData[section].collapsed
        
        
        // Toggle collapse
        
        groupSectionData[section].collapsed = collapsed
        header.setCollapsed(collapsed)
        
        tableView.reloadSections(NSIndexSet(index: section) as IndexSet, with: .automatic)
    }
    
}
