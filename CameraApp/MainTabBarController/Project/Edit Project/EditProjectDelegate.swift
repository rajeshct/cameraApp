//
//  EditProjectDelegate.swift
//  CameraApp
//
//  Created by Jeevan chandra on 03/05/18.
//  Copyright © 2018 JEEVAN TIWARI. All rights reserved.
//

import UIKit

extension EditProjectTaskController{


    @objc func openCalendar(button: UIButton){
        handleTap()
        if let window = UIApplication.shared.keyWindow{
            let calendarView = CalendarView()

            if button.tag == 0{
                calendarView.defaultValue = DefaultSelectedDate.STARTDATE

            }else{
                calendarView.defaultValue = DefaultSelectedDate.ENDDATE
                calendarView.movingViewLeftAnchor?.constant = 16 + (UIScreen.main.bounds.width - 32) / 2
            }

            calendarView.delegate = self
            window.addSubview(calendarView)
            calendarView.anchorToTop(top: window.topAnchor, left: window.leftAnchor, bottom: window.bottomAnchor, right: window.rightAnchor)

        }
    }



    @objc func hanldeProjectAssign(){
        handleTap()

        if let window = UIApplication.shared.keyWindow{
            let projectAssignView = ProjectAssignPopUp()
            projectAssignView.delegate = self
            
            if let ids = self.editProject?.ProjectAssignTo{
                projectAssignView.preSelectedRows = ids
            }
            
            
            
          SaveUserDataOnLogin.shared.getUserDataFromPlist(completion: { (data) in
                projectAssignView.projectData = data.employees
            
           
            
            
            }) { (error) in
                print(error)
            }
            
            window.addSubview(projectAssignView)
            
            
            projectAssignView.anchorToTop(top: window.topAnchor, left: window.leftAnchor, bottom: window.bottomAnchor, right: window.rightAnchor)

        }
    }



    
}

extension EditProjectTaskController: UITextFieldDelegate{


    @objc func handleTap(){
        projectNameTextField.resignFirstResponder()
        projectBudgetButton.resignFirstResponder()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        handleTap()
        return true
    }

}



extension EditProjectTaskController{

    @objc func handleSubmit(){
        handleTap()
        
        if let checkEmptyStrings = checkEmptyFields(){
            Alerts.shared.displaySimpleAlert(displayIn: self, title: "Warning", message: checkEmptyStrings)
        }else{
            
            if let startingDate = startDate, let endingDate = endDate{
                if startingDate > endingDate{
                    Alerts.shared.displaySimpleAlert(displayIn: self, title: "Warning", message: "Start date cannot be greater than ending date")
                }else{
                    createProjectToServer()
                }
            }
            
        }

    }

    func createProjectToServer(){
        showActivityIndicator()

        let bodyParameter = makeServerBody()
        let addTaskObj = EditProjectApiInteraction()
        addTaskObj.delegate = self
        
        if let _ = editProject?.CompanyId{
            
            addTaskObj.addTaskToServer(bodyParameter: bodyParameter, taskType: "update")

        }else{
            
            addTaskObj.addTaskToServer(bodyParameter: bodyParameter, taskType: "create")

        }
       
    }

    func makeServerBody() -> [String: String] {

        
        var serverBody = [String: String]()
//        {
//            "CompanyId":"12",
//            "CreatedByName":"SK Singh",
//            "EndDate":"1526409000000",
//            "ProjectAssignTo":"50019,50022,50021",
//            "ProjectBudGet":"2500",
//            "ProjectName":"Santra",
//            "StartDate":"1525372200000",
//            "UserID":"1"
//        }
//
        
        SaveUserDataOnLogin.shared.getUserDataFromPlist(completion: { (result) in
            
            
            if let projectId = self.editProject?.ProjectID{
                serverBody.updateValue(String(projectId), forKey: "ProjectId")
            }
            
            if let companyId = result.result?.CompanyId{
             
                serverBody.updateValue(String(companyId), forKey: "CompanyId")
            }
            
            serverBody.updateValue(UILabel().getFullName(firstName: result.result?.FirstName, lastName: result.result?.LastName), forKey: "CreatedByName")
            
        
            if let userId = result.result?.ID{
                serverBody.updateValue(String(userId), forKey: "UserId")
            }
            
            if let startingDate = self.editProject?.StartDate, let endingDate = self.editProject?.EndDate{
                serverBody.updateValue(String(startingDate), forKey: "StartDate")
                serverBody.updateValue(String(endingDate), forKey: "EndDate")
                
            }else{
                if let startingDate = self.startDate, let endingDate = self.endDate{
                
                serverBody.updateValue(String(LogicHelper.shared.convertDateToTimeStamp(date: startingDate)) + "000", forKey: "StartDate")
                serverBody.updateValue(String(LogicHelper.shared.convertDateToTimeStamp(date: endingDate)) + "000", forKey: "EndDate")
            }
            }
            
            if let projectAssignTo  = self.projectAssignIds{
                serverBody.updateValue(projectAssignTo, forKey: "ProjectAssignTo")
            }
            
            if let projectName = self.projectNameTextField.text{
                serverBody.updateValue(projectName, forKey: "ProjectName")
            }
            
            if let projectBudget = self.projectBudgetButton.text{
                serverBody.updateValue(projectBudget, forKey: "ProjectBudGet")
            }
        
            
        }) { (error) in
            
        }
        
    
        return serverBody

    }
    
    
//    func getFullName(firstName: String?, lastName: String?) -> String{
//        var fullName = ""
//
//        if let first = firstName{
//            fullName = fullName + first
//        }
//
//        if let second = lastName{
//            fullName = fullName  + " " + second
//        }
//
//        return fullName
//    }
    
    
    
}



extension EditProjectTaskController{

    func checkEmptyFields() -> String?{

        if projectNameTextField.text == ""{
            return "Project name cannot be empty"
        }else if startDateButton.title(for: .normal) == "DD/MM/YYYY"{
            return "Start date cannot be empty"
        }else if startDateButton.title(for: .normal) == "DD/MM/YYYY"{
            return "End date cannot be empty"
        }else if projectAssignButton.title(for: .normal) == "Select"{
            return "Project Assign cannot be empty"
        }else if projectBudgetButton.text == ""{
            return "Project Budget cannot be empty"
        }

        return nil

    }



    func showActivityIndicator(){
        createProjectButton.setTitle("", for: .normal)
        activityIndicator.startAnimating()
    }



    func hideActivityIndicator(){
        createProjectButton.setTitle("CREATE PROJECT", for: .normal)
        activityIndicator.stopAnimating()
    }
}


extension EditProjectTaskController: CalendarDatesDelegate{
    
    func setCalendarDates(startDate: Date?, endDate: Date?) {

        self.startDate = startDate
        self.endDate = endDate
        
        if let startingDate = startDate {
            startDateButton.setTitle(LogicHelper.shared.convertDateToServerFormat(date: startingDate), for: .normal)
        }

        if let endingDate = endDate{
            endDateButton.setTitle(LogicHelper.shared.convertDateToServerFormat(date: endingDate), for: .normal)
        }
    }


}

extension EditProjectTaskController: CreateProjectDelegate, ProjectAssignDelegate{
  
    func onClickCell(value: String?, assignId: String?) {
       
        projectAssignButton.setTitle(value, for: .normal)
        projectAssignIds = assignId
    }



    func addTask(data: CreateProjectDataModel?, error: String?) {
        
        hideActivityIndicator()

        if let gettingError = error{
            Alerts.shared.displaySimpleAlert(displayIn: self, title: "Warning", message: gettingError)
            
        }else{
            delegate?.onRefreshProjects()
            navigationController?.popViewController(animated: true)
        }

        
    }
    
    
    
    func prefillValues(){
        projectNameTextField.text = editProject?.ProjectName
       
       // endDateButton.setTitle(editProject?.EndDate, for: .normal)
        
        projectBudgetButton.text = editProject?.ProjectBudGet
        
        if let startingDate = editProject?.StartDate{
            
            let date = LogicHelper.shared.convertStringToDate(date: startingDate)
            startDateButton.setTitle(LogicHelper.shared.convertDateToServerFormat(date: date), for: .normal)
            
        }
        
        if let endingDate = editProject?.EndDate{
            
            let date = LogicHelper.shared.convertStringToDate(date: endingDate)
            endDateButton.setTitle(LogicHelper.shared.convertDateToServerFormat(date: date), for: .normal)
        }
        
        createProjectButton.setTitle("UPDATE PROJECT", for: .normal)
        prefillWithName()
    }
    
    
    func prefillWithName(){
        
        
        SaveUserDataOnLogin.shared.getUserDataFromPlist(completion: { (result) in
            
            var ids = ""
            var name = ""
            
            if let projectAssigns = result.employees{
                
                for index in 0..<projectAssigns.count{
                    
                    if let projectAssignId = projectAssigns[index].ID,let  preSelectedAssignId = self.editProject?.ProjectAssignTo{
                        
                        if preSelectedAssignId.localizedCaseInsensitiveContains(String(projectAssignId)){
                            
                            //tableView(contentTable, didSelectRowAt: IndexPath(item: index, section: 0))
                            
                            if let assignId = projectAssigns[index].ID{
                                ids = ids + String(assignId) + ","
                            }
                            
                          name = name +   UILabel().getFullName(firstName:  projectAssigns[index].FirstName, lastName: projectAssigns[index].LastName) + ","
                            
                            
                            
                            
                        }
                        
                        
                    }
                    
                }
                
                if name != ""{
                    name.removeLast()
                }
                
                
                if ids != ""{
                    ids.removeLast()
                }
                
                self.projectAssignIds = ids
                
                
                self.projectAssignButton.setTitle(name, for: .normal)
            }
            
        }) { (error) in
            
        }
        
        
        
       
    }
    
    


}
