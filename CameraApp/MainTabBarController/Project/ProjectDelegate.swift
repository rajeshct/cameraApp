//
//  ProjectDelegate.swift
//  CameraApp
//
//  Created by JEEVAN TIWARI on 08/04/18.
//  Copyright © 2018 JEEVAN TIWARI. All rights reserved.
//

import UIKit

extension ProjectController{
    
    
    func setup(){
        addViews()
        setupNavigationController()
        dateCollectionCell.delegate = self

        if let userType = UserDefaults.standard.value(forKey: "userType") as? Int{
            if userType == 1 || userType == 2{
                addTaskButton.isHidden = false
            }else{
                addTaskButton.isHidden = true
            }
        }
    }
    
    func addViews(){
        view.addSubview(projectTableView)
        view.addSubview(addTaskButton)

        self.projectTableView.addSubview(self.refreshControl)


        projectTableView.anchorToTop(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        
        addTaskButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        addTaskButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        addTaskButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        if #available(iOS 11.0, *){
            addTaskButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16).isActive = true
        }else{
            addTaskButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -65).isActive = true
        }


    }
    
    
    @objc func handleCalendar(){
        
        if let window = UIApplication.shared.keyWindow{
            let calendar = CalendarView()
            calendar.delegate = self
            calendar.defaultValue = DefaultSelectedDate.STARTDATE
                window.addSubview(calendar)
            calendar.anchorToTop(top: window.topAnchor, left: window.leftAnchor, bottom: window.bottomAnchor, right: window.rightAnchor)
        }
        
    }
    
    @objc func handleAdd(){
        
         let addTaskObj = AddTimeController()
        addTaskObj.projectData = projectData
        addTaskObj.delegate = self
        navigationController?.pushViewController(addTaskObj, animated: true)
        
    }
    
    @objc func handleAddTask(){

        navigationController?.pushViewController(EditProjectTaskController(), animated: true)
    }
    
}

//MARK: TABLE VIEW DELEGATE

extension ProjectController: UITableViewDelegate, UITableViewDataSource{
    
    
     func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        switch section {
        case 0,1:
            return 1
        default:
            return  projectTasks.count

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
            collectionCell.projectControllerInstance = self
            return collectionCell
        case 1:
            return dateCollectionCell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectNotificationCell", for: indexPath) as! ProjectNotificationCell
            cell.taskData = projectTasks[indexPath.item]
            return cell
        }
        

        //return collectionCell
    }
    
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 2 {
            
            let cell = tableView.cellForRow(at: indexPath)  as! ProjectNotificationCell
            let addTimeObj = AddTimeController()
            addTimeObj.projectTask = cell.taskData
            addTimeObj.delegate = self
            
            addTimeObj.projectDetails = projectData?[findIndex()]  // have to correct
             navigationController?.pushViewController(addTimeObj, animated: true)
        }
    }
    
    func findIndex() -> Int{
       
    
        if let projects  = projectData{
            
            for index in 0..<projects.count{
                
                if projects[index].ProjectID == projectId{
                    
                    return index
                    
                }
                
            }
        }
        
        return 0
        
    }
    
    
    
    func loadMoreProjects(){
        
        let loadMoreProjects = ViewAllProjectsController()
        loadMoreProjects.projectData = projectData
        navigationController?.pushViewController(loadMoreProjects, animated: true)
    }
    
    
}



extension ProjectDateCollectionCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width * 0.3, height: 70)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return projectTaskDates?.count ?? 0//projectDates?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let cell = collectionView.cellForItem(at: indexPath) as? ProjectDateCell
        cell?.dateLabel.font = UIFont.boldSystemFont(ofSize: 15)
        cell?.dayNameLabel.font = UIFont.boldSystemFont(ofSize: 15)
        cell?.dateLabel.textColor = .black
        cell?.dayNameLabel.textColor = .black
        if let data = projectTaskDates?[indexPath.item]{
            delegate?.dateTaskCellClicked(projectData: data.Task)
            allProjectsDelegate?.dateTaskCellClicked(projectData: data.Task)
            
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! ProjectDateCell
        cell.dateLabel.font = UIFont(name: cell.dateLabel.font.fontName, size: 13)
        cell.dayNameLabel.font = UIFont(name: cell.dateLabel.font.fontName, size: 13)
        cell.dateLabel.textColor = .gray
        cell.dayNameLabel.textColor = .gray
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProjectDateCell", for: indexPath) as! ProjectDateCell
        cell.date = projectTaskDates?[indexPath.item]
        
        if cell.isSelected{
            cell.dateLabel.font = UIFont.boldSystemFont(ofSize: 15)
            cell.dayNameLabel.font = UIFont.boldSystemFont(ofSize: 15)
            cell.dateLabel.textColor = .black
            cell.dayNameLabel.textColor = .black
        }else{
            cell.dateLabel.font = UIFont(name: cell.dateLabel.font.fontName, size: 13)
            cell.dayNameLabel.font = UIFont(name: cell.dateLabel.font.fontName, size: 13)
            cell.dateLabel.textColor = .gray
            cell.dayNameLabel.textColor = .gray
        }
        return cell
        
    }
    
    
    
}


//MARK: Setup Navigation Controller

extension ProjectController: RefreshProjectsDelegate, OnTaskDateSelection{
  
    func onPreviousNextButtonClicked(startingDating: String, endingDate: String) {
        
        let apiObj = ProjectApiInteraction()
        apiObj.delegate = self
       
        
        apiObj.getProjectTasks(projectId: projectData?[findIndex()].ProjectID, itemIndex: findIndex(), startingDate: startingDating, endingDate: endingDate, from: "previousTasks")

        
        
    }
    

    func dateTaskCellClicked(projectData: [ProjectTaskModel]?) {

        if let list = projectData{
            projectTasks = list
            projectTableView.reloadData()
        }

    }

    func onRefreshProjects() {

        projectId =  nil
        projectData = nil
        collectionCell.projectData = nil
        dateCollectionCell.projectDates = nil
        dateCollectionCell.projectTaskDates = nil
        projectTasks.removeAll()
        projectTableView.reloadData()
        getProjectList(startingDate: "0", endingDate: "0")
    }
    
    func onRefreshTask(){
      projectTasks.removeAll()
      projectTableView.reloadData()
      getTaskList()
    
    
    }

    
    func getTaskList(){
        
        
        if let projects  = projectData{
            
            for index in 0..<projects.count{
                
                if projects[index].ProjectID == projectId{
                    
                    let apiObj = ProjectApiInteraction()
                    apiObj.delegate = self
                    apiObj.getProjectTasks(projectId: projectId, itemIndex: index, startingDate: "0", endingDate: "0", from: "no")
                }
                
            }
        }
        
        
        
        
    }
    
    


    func setupNavigationController(){

        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "calendarImage").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleCalendar))
        
        let addTaskButton = UIBarButtonItem(title: "Add Task", style: .plain, target: self, action: #selector(handleAdd))
        addTaskButton.setTitleTextAttributes([NSAttributedStringKey.font: UIFont(name: UILabel().font.fontName, size: 13)], for: .normal)
        
        
        let refreshButton = UIBarButtonItem(image: #imageLiteral(resourceName: "refreshImage").withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(handleRefresh))
        
        refreshButton.tintColor = #colorLiteral(red: 0.4470588235, green: 0.568627451, blue: 0.9568627451, alpha: 1)
        
        navigationItem.rightBarButtonItems = [ refreshButton, addTaskButton]
        
        
        
        navigationController?.navigationBar.titleTextAttributes = [ NSAttributedStringKey.foregroundColor: #colorLiteral(red: 0.4470588235, green: 0.568627451, blue: 0.9568627451, alpha: 1)]
        
        navigationController?.navigationBar.isTranslucent = false
        
        navigationController?.navigationBar.shadowImage = UIImage()
        
    }



    
}



//MARKL: api calls


extension ProjectController{
    
    func getProjectList(startingDate: String, endingDate: String){


        view.showActivityIndicator(activityIndicator: activityIndicator)
       
        let apiObj = ProjectApiInteraction()
        apiObj.delegate = self

        SaveUserDataOnLogin.shared.getUserDataFromPlist(completion: { (loginData) in

            if let companyId = loginData.result?.CompanyId{
                apiObj.getProjectsList(startingDate: startingDate, endingDate: endingDate, companyId: String(companyId))

            }

        }) { (error) in

        }
        
    }




    
}



extension ProjectController: ProjectLIstDelegate{

  

    func projectList(list: [ProjectListModel]?, error: String?) {

        view.removeActivityIndicator(activityIndicator: activityIndicator)
         refreshControl.endRefreshing()
        
        if  let unwrappedError = error{

            Alerts.shared.displaySimpleAlert(displayIn: self, title: "Warning", message: unwrappedError)

        }else{
       
        
        let projects = list
            
            
            if projects?.count == 0 {
                dateCollectionCell.previousButton.isHidden = true
            }else{
                dateCollectionCell.previousButton.isHidden = false
            }
            
        if let projectList = list{
            
            
            for index in 0..<projectList.count{
            
                    let apiObj = ProjectApiInteraction()
                    apiObj.delegate = self
                apiObj.getProjectTasks(projectId: projectList[index].ProjectID, itemIndex: index, startingDate: "0", endingDate: "0", from: "no")


            }
            
            projectData = projects
          //  collectionCell.projectCollectionView.projectControllerInstance = self
            collectionCell.projectData = projectData
            
        }
        
        

        }


        
    }
    
    func onScrollProject(dateArray: [ProjectTaskDateListModel]?, index: Int){
        
        projectId = index
        dateCollectionCell.currentProject = index
        dateCollectionCell.projectDates = dateArray
    
        
        
        if let getDateArray = dateArray{
            if getDateArray.isEmpty{
                view.addSubview(noTaskText)
                noTaskText.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
                noTaskText.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
            }else{
                noTaskText.removeFromSuperview()
            }
        }
        //print("The start and end date is ", dateArray)
        
    }
    
    
    
}


extension ProjectController: ProjectTaskDelegate{
   
    
    
    
    func projectTaskListPreviousNext(list: [ProjectTaskDateListModel]?, arrayIndex: Int) {
        
        var previousNextData =  [ProjectTaskDateListModel]()
      
        if let getPreviousTask = projectData?[arrayIndex].projectTasks{
            previousNextData = getPreviousTask
        }
        
        if let newDateList = list{
            previousNextData = previousNextData + newDateList
        }
       
        
        projectData?[arrayIndex].projectTasks = previousNextData
        dateCollectionCell.projectDates = previousNextData
        
        projectTableView.reloadData()
        
        
        
    }
    
  
    
    func projectTaskList(list: [ProjectTaskDateListModel]?, arrayIndex: Int) {

        if arrayIndex == 0{
            
            if let projectTasksList = list{
                if projectTasksList.count > 0 {
                    if let  projectlist = list?[0].Task{
                        projectTasks = projectlist
                        dateCollectionCell.projectDates = list
                }
            }
            
            }
            
        }
        
        if let _ = projectId{
//            let previousTasks = projectData?[arrayIndex].projectTasks
//            if var previousTask = previousTasks, let newTasks = list{
//
//                previousTask = previousTask + newTasks
//                projectData?[arrayIndex].projectTasks = previousTask
//                collectionCell.projectData = projectData
//
//            }
            
            projectData?[arrayIndex].projectTasks = list
            
            if let getList = list{
                
                if getList.count > 0{
                
                    if let getTask = getList[0].Task{
                         projectTasks = getTask
                    }
                   
                }
                
                
            }
            
            
            projectTableView.reloadData()
           
           
        }else{
            projectData?[arrayIndex].projectTasks = list
            collectionCell.projectData = projectData
        }
        
        projectTableView.reloadData()
        
    }

    
    func onScrollProjectTask(list: [ProjectTaskDateListModel]?){
        

        projectTasks.removeAll()
        if let projectTasksList = list{
            if projectTasksList.count > 0 {
                if let  projectlist = list?[0].Task{
                    projectTasks = projectlist
                }
            }
            
        }
        projectTableView.reloadData()
    }
    
    
    
    func handleProjectEdit(projectDataList: ProjectListModel?){
        
        let projectAddObj = EditProjectTaskController()
        projectAddObj.editProject = projectDataList
        projectAddObj.delegate = self
        navigationController?.pushViewController(projectAddObj, animated: true)
    }
    
    
    
}


extension ProjectController: CalendarDatesDelegate{

    func setCalendarDates(startDate: Date?, endDate: Date?) {

        projectId =  nil
        projectData = nil
        collectionCell.projectData = nil
        dateCollectionCell.projectDates = nil
        dateCollectionCell.projectTaskDates = nil
        projectTasks.removeAll()
        projectTableView.reloadData()
        if let startingDate = startDate, let endingDate = endDate{

            let startDate = String(LogicHelper.shared.convertDateToTimeStamp(date: startingDate)) + "000"
            let endDate = String(LogicHelper.shared.convertDateToTimeStamp(date: endingDate)) + "000"
            getProjectList(startingDate: startDate, endingDate: endDate)

        }

    }

    @objc func handleRefresh(){


        projectId =  nil
        projectData = nil
        collectionCell.projectData = nil
        dateCollectionCell.projectDates = nil
        dateCollectionCell.projectTaskDates = nil
        projectTasks.removeAll()
        projectTableView.reloadData()
        getProjectList(startingDate: "0", endingDate: "0")



    }


}












