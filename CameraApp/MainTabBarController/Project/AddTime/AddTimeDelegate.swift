//
//  AddTimeDelegate.swift
//  CameraApp
//
//  Created by JEEVAN TIWARI on 18/04/18.
//  Copyright © 2018 JEEVAN TIWARI. All rights reserved.
//

import UIKit


extension AddTimeController: AddTaskProtocol{


    
    @objc func handleSubmit(){

        if let emptyFieldsString = checkEmptyFields(){


            Alerts.shared.displaySimpleAlert(displayIn: self, title: "Warning", message: emptyFieldsString)
        }else{

            showActivityIndicator()
            let bodyParameter = makeServerBody()

            let addTaskObj = AddTimeApiInteraction()
            addTaskObj.delegate = self
            
            if let _ = projectTask?.CompanyId{
                addTaskObj.addTaskToServer(bodyParameter: bodyParameter, type: "update")
            }else{
                addTaskObj.addTaskToServer(bodyParameter: bodyParameter, type: "create")

            }
        }

        
    }


    func addTask(data: AddTaskDataModel?, error: String?) {
        hideActivityIndicator()

        if let errorString = error{
            Alerts.shared.displaySimpleAlert(displayIn: self, title: "Warning", message: errorString)
        }else{
            
            if let _ = projectTask{
                delegate?.onRefreshTask()
            }else{
                delegate?.onRefreshProjects()
            }
            
            navigationController?.popViewController(animated: true)

        }
    }



    func checkEmptyFields() -> String?{

        if projectView.selectButton.title(for: .normal) == "Select"{
            return "Project cannot be empty"
        }else if taskView.descriptionText.text == ""{
            return "Task cannot be empty"
        }else if durationInHoursView.selectButton.title(for: .normal) == "Select Hrs"{
            return "Hours cannot be empty"
        }else if durationInMinutesView.selectButton.title(for: .normal) == "Select Mins"{
            return "Minutes cannot be empty"
        }

        return nil

    }



    func showActivityIndicator(){
        saveButton.setTitle("", for: .normal)
        activityIndicator.startAnimating()
    }



    func hideActivityIndicator(){
        saveButton.setTitle("SAVE", for: .normal)
        activityIndicator.stopAnimating()
    }




    func makeServerBody() -> [String: String]{


        var bodayParameter = [String: String]()
        
        if let projectId = projectDetails?.ProjectID{
             bodayParameter.updateValue(String(projectId), forKey: "ProjectId")
        }else{
             bodayParameter.updateValue(String(projectView.selectButton.tag), forKey: "ProjectId")
        }
        
        if let taskId = projectTask?.TaskId{
            bodayParameter.updateValue(String(taskId), forKey: "TaskId")
        }

        if let task = taskView.descriptionText.text{
            bodayParameter.updateValue(task, forKey: "Tasks")
        }

        if let hours = durationInHoursView.selectButton.title(for: .normal){

            bodayParameter.updateValue(hours, forKey: "Hours")
        }

        if let minutes = durationInMinutesView.selectButton.title(for: .normal){
            bodayParameter.updateValue(minutes, forKey: "Minutes")
        }

        if let description = descriptionView.descriptionText.text{
            bodayParameter.updateValue(description, forKey: "Description")
        }

        if let userId = UserDefaults.standard.value(forKey: "userId") as? Int{
            bodayParameter.updateValue(String(userId), forKey: "UserId")
        }

        if let createdDate = taskCreatedDate{
            bodayParameter.updateValue(String(createdDate), forKey: "CreateDate")
        }
        
        SaveUserDataOnLogin.shared.getUserDataFromPlist(completion: { (result) in
            
            if let companyId = result.result?.CompanyId{
                bodayParameter.updateValue(String(companyId), forKey: "CompanyId")
            }
            
            
        }) { (error) in
            
        }

        


        //        var bodyParameter = [
        //            "ProjectId": "0",
        //            "Tasks": "string",
        //            "Hours": "0",
        //            "Minutes": "0",
        //            "Description": "string",
        //            "UserId": "0",
        //            "CompanyId": "0"
        //        ]

        return bodayParameter

    }

    
    
}


extension AddTimeController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}


extension AddTimeController: PopUpSelectDelegate{

    func onClickCell(value: String?, type: String, projectId: Int?) {

        if type == "projectList"{
            if let projectIdTag = projectId {
                projectView.selectButton.tag = projectIdTag
            }
            
            if let projects  = projectData{
                
                for project in projects{
                    if project.ProjectID == projectView.selectButton.tag{
                        
                        
                        if let firstDate = project.StartDate, let lastDate = project.EndDate{
                            
                            if firstDate == lastDate{
                                
                                taskView.selectButton.isUserInteractionEnabled = false
                                
                                let getDate = LogicHelper.shared.convertStringToDate(date: firstDate)
                                
                                taskDate.selectButton.setTitle(LogicHelper.shared.convertDateToServerFormat(date: getDate), for: .normal)
                                
                                taskCreatedDate = firstDate
                                
                            }else{
                                taskDate.selectButton.setTitle("DD/MM/YY", for: .normal)
                            }
                        }
                        
                    }
                    
                }
                
            }
            
            
            
            
            
            
            
            
            
            
            projectView.selectButton.setTitle(value, for: .normal)
        }else if type == "hours"{
            durationInHoursView.selectButton.setTitle(value, for: .normal)
        }else{
            durationInMinutesView.selectButton.setTitle(value, for: .normal)
        }

    }

}


extension AddTimeController{
    
    @objc func handleProjectSelection(){

        handleTap()
        if let window = UIApplication.shared.keyWindow{
            let projectList = ProjectPopUp()
            projectList.projectData = projectData
            projectList.delegate = self
            window.addSubview(projectList)
            projectList.anchorToTop(top: window.topAnchor, left: window.leftAnchor, bottom: window.bottomAnchor, right: window.rightAnchor)
        }
    }


    @objc func handleMinute(){
        handleTap()
        if let window = UIApplication.shared.keyWindow{
            let minuteList = HoursMinutePopUp()
            minuteList.popUpType = "minutes"
            minuteList.delegate = self
            window.addSubview(minuteList)
            minuteList.anchorToTop(top: window.topAnchor, left: window.leftAnchor, bottom: window.bottomAnchor, right: window.rightAnchor)
        }
    }

    @objc func handleHours(){
        handleTap()
        if let window = UIApplication.shared.keyWindow{
            let hoursList = HoursMinutePopUp()
            hoursList.popUpType = "hours"
            hoursList.delegate = self
            window.addSubview(hoursList)
            hoursList.anchorToTop(top: window.topAnchor, left: window.leftAnchor, bottom: window.bottomAnchor, right: window.rightAnchor)
        }
    }

    
    func setupEditProject(){
        
        projectView.selectButton.isUserInteractionEnabled = false
       
        taskView.descriptionText.text = projectTask?.TaskText
        
        projectView.selectButton.setTitle(projectDetails?.ProjectName, for: .normal)
        
        
        
       
     descriptionView.descriptionText.text = projectTask?.Description
        
    }
    
    
    @objc func handleTaskdate(){
        
        if let projects  = projectData{
            
            for project in projects{
                if project.ProjectID == projectView.selectButton.tag{
                    
                    if let firstDate = project.StartDate, let lastDate = project.EndDate{
                        
                        if firstDate == lastDate{
                            
                            taskView.selectButton.isUserInteractionEnabled = false
                           
                            let getDate = LogicHelper.shared.convertStringToDate(date: firstDate)
                         
                            taskDate.selectButton.setTitle(LogicHelper.shared.convertDateToServerFormat(date: getDate), for: .normal)
                            
                        }else{
                        
                        
                        let convertedFirstDate = LogicHelper.shared.convertStringToDate(date: firstDate)
                        let convertedSecondDate = LogicHelper.shared.convertStringToDate(date: lastDate)
                        
                        let calendarView = CalendarView()
                            calendarView.delegate = self
                        calendarView.projectStartingDate = convertedFirstDate
                        calendarView.projectEndingDate = convertedSecondDate
                        
                        if let window = UIApplication.shared.keyWindow{
                            window.addSubview(calendarView)
                            calendarView.anchorToTop(top: window.topAnchor, left: window.leftAnchor, bottom: window.bottomAnchor, right: window.rightAnchor)
                            
                        }
                        
                        }
                        
                    }
                    
                    
                }
                
            }
            
            
        }
    }

}


extension AddTimeController: CalendarDatesDelegate{
   
    func setCalendarDates(startDate: Date?, endDate: Date?) {
        
        if let getDate = startDate{
           

               
                taskDate.selectButton.setTitle(LogicHelper.shared.convertDateToServerFormat(date: getDate), for: .normal)
                taskCreatedDate = LogicHelper.shared.convertDateToTimeStamp(date: getDate)
                
        
            
            
        }
        
        
    }
    
    
    
}
