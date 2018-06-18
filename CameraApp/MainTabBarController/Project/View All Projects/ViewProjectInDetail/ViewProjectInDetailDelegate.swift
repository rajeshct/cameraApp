//
//  ViewProjectInDetailDelegate.swift
//  CameraApp
//
//  Created by JEEVAN TIWARI on 28/05/18.
//  Copyright © 2018 JEEVAN TIWARI. All rights reserved.
//

import UIKit


extension ViewProjectInDetails: UITableViewDelegate, UITableViewDataSource{
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0,1:
            return 1
        default:
            return  projectTasks?.count ?? 0  //projectTasks.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.section {
        case 0:
            return  200  //  (UIScreen.main.bounds.width - 32) * 9 / 16
        case 1:
            return 70
        default:
            return UITableViewAutomaticDimension
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            //collectionCell.projectControllerInstance = self
            return projectDataCell
        case 1:
            dateCollectionCell.allProjectsDelegate = self
            return dateCollectionCell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectNotificationCell", for: indexPath) as! ProjectNotificationCell
            cell.taskData = projectTasks?[indexPath.item]
            return cell
        }
        
    }
        
        //return collectionCell
}


extension ViewProjectInDetails{

    func setup(){
        getTaskList()

        projectDataCell.titleLabel.text = projectData?.ProjectName

        if let startDate = projectData?.StartDate, let endDate = projectData?.EndDate{


            let getStartDate = LogicHelper.shared.convertStringToDate(date: startDate)
            let getEndDate = LogicHelper.shared.convertStringToDate(date: endDate)



            projectDataCell.startDateLabel.text = "Start Date: \(LogicHelper.shared.getDate(date: getStartDate)) \(LogicHelper.shared.getMonthShort(date: getStartDate)) \(LogicHelper.shared.getYear(date: getStartDate))"

            projectDataCell.endDateLabel.text = "End Date: \(LogicHelper.shared.getDate(date: getEndDate)) \(LogicHelper.shared.getMonthShort(date: getEndDate)) \(LogicHelper.shared.getYear(date: getEndDate))"


        }

        if let createBy = projectData?.CreatedByName{
            projectDataCell.createdByLabel.text = "Created by: \(createBy)"
        }

        if let userId = UserDefaults.standard.value(forKey: "userId") as? String, let secondUserId = projectData?.UserID{

            if userId == String(secondUserId){
                projectDataCell.editButton.isHidden = false
            }else{
                projectDataCell.editButton.isHidden = true
            }
        }

    }






}


extension ViewProjectInDetails: ProjectTaskDelegate{

    func projectTaskList(list: [ProjectTaskDateListModel]?, arrayIndex: Int) {
        dateCollectionCell.projectDates = list
        
        

        if let getList = list{
            
            if getList.count > 0 {
                noTaskText.removeFromSuperview()
                projectTasks = getList[0].Task
                projectTableView.reloadData()
            }
        }else{
            addNoTaskView()
        }
        
        
    }

    func projectTaskListPreviousNext(list: [ProjectTaskDateListModel]?, arrayIndex: Int) {

    }


    func getTaskList(){

        let apiObj = ProjectApiInteraction()
        apiObj.projectDelegate = self
        apiObj.getProjectTasks(projectId: projectData?.ProjectID, itemIndex: 0, startingDate: "0", endingDate: "0", from: "viewDetailProject")

    }

    
    func setNoTaskText(){
        
       // noTaskText.removeFromSuperview()
        if let tasks = projectTasks{
            if tasks.count > 0 {
                
            }else{
                addNoTaskView()
            }
        }else{
            addNoTaskView()
        }
    }
    
    func addNoTaskView(){
        view.addSubview(noTaskText)
        noTaskText.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        noTaskText.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    
    func dateTaskCellClicked(projectData: [ProjectTaskModel]?) {
        
        if let list = projectData{
            projectTasks = list
            projectTableView.reloadData()
        }
        
    }
    
}
