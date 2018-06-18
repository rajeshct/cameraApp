//
//  ProjectApiInteraction.swift
//  CameraApp
//
//  Created by JEEVAN TIWARI on 15/04/18.
//  Copyright © 2018 JEEVAN TIWARI. All rights reserved.
//

import Foundation

protocol ProjectLIstDelegate {
    
    func projectList(list: [ProjectListModel]?, error: String?)
}

protocol ProjectListErroDelegate {
    
    func projectListErro(error: String)
}


protocol ProjectTaskDelegate {
    
    func projectTaskList(list: [ProjectTaskDateListModel]?,arrayIndex: Int)
    func projectTaskListPreviousNext(list: [ProjectTaskDateListModel]?,arrayIndex: Int)
}

protocol ProjectTaskErroDelegate {
    
    func projectListErro(error: String)
}



class ProjectListApiModel: Decodable{
    
    var message: String?
    //var error: Int?
    var data : [ProjectListModel]?

}


class ProjectListModel: Decodable{
    
    var ProjectID : Int?
    var ProjectName: String?
    var StartDate: CLong?
    var EndDate: CLong?
    var ProjectAssignTo: String?
    var ProjectBudGet: String?
    var ModifiedDate: CLong?
    var CreatedByName: String?
    //var CreateDate: String?
    var Status: Bool?
    var UserID: Int?
    var CompanyId: Int?
    var Description: String?
    var taskDates: [ProjectTaskDateListModel]?
    var projectTasks:[ProjectTaskDateListModel]?
}


class ProjectTaskApiModel: Decodable{
    var message: String?
    var error: Bool?
    var data : [ProjectTaskDateListModel]?
    
}


class ProjectTaskDateListModel: Decodable{
    var TaskDate: CLong?
    var Task: [ProjectTaskModel]?
}

class ProjectTaskModel: Decodable{
    
    
    var TaskDate: CLong?
    var ProjectId: Int?
    var TaskText: String?
    var Hours: Int?
    var Minutes: Int?
    var Description: String?
    var CreateDate: CLong?
    var ModifieDate: CLong?
    var UserId: Int?
    var CompanyId: Int?
    var TaskId: Int?
    
}

class ProjectTaskDetailsModel: Decodable{
    
    
}


class ProjectApiInteraction{
    
    var delegate: ProjectController?
    var projectDelegate: ProjectTaskDelegate?
    func getProjectsList(startingDate: String, endingDate: String, companyId: String){

        
        let url =  NetworkWebApisConstant.baseUrl + NetworkWebApisConstant.ProjectControllerApi.projectUrl + "?companyId=\(companyId)&startDate=\(startingDate)&endDate=\(endingDate)&pageNo=1"
        
        guard let token = UserDefaults.standard.value(forKey: "token") as? String else{
            return
        }
        
        print("The token is ", token)
        let header = [
            "Content-Type":"application/x-www-form-urlencoded",
            "token": token,
            "client" : "android"
        ]
            
            
        Networking.shared.httpGetRequest(url: url, bodyParameter: [:], header: header, dataIn: { (data) in
            
            do{
                
                let jsonData = try JSONDecoder().decode(ProjectListApiModel.self, from: data)
                
                
         
                
                self.delegate?.projectList(list: jsonData.data, error: nil)
                print("Data is ")
                print(jsonData)
                
                
            }catch  let jsonError{
                
                self.delegate?.projectList(list: nil, error: jsonError.localizedDescription)
            }
            
        }) { (error) in
            self.delegate?.projectList(list: nil, error: error)
        }
        
    }
    
    func getProjectTasks(projectId: Int?, itemIndex: Int,startingDate: String, endingDate: String, from: String){
        
        guard let getProjectId = projectId else{
            return
        }
        
        
        let url = NetworkWebApisConstant.baseUrl + NetworkWebApisConstant.ProjectControllerApi.projectTaskUrl + "?projectId=\(getProjectId)&startDate=\(startingDate)&endDate=\(endingDate)"
        
        guard let token = UserDefaults.standard.value(forKey: "token") as? String else{
            return
        }
        
        
        let header = [
            "Content-Type":"application/x-www-form-urlencoded",
            "token": token,
            "client" : "android"
        ]
        
        Networking.shared.httpGetRequest(url: url, bodyParameter: [:], header: header, dataIn: { (data) in
            
            do{
                
                
                  let jsonData = try JSONDecoder().decode(ProjectTaskApiModel.self, from: data)
                
                if from == "previousTasks"{
                    self.delegate?.projectTaskListPreviousNext(list: jsonData.data, arrayIndex: itemIndex)
                }else if from == "viewDetailProject"{
                    self.projectDelegate?.projectTaskList(list:  jsonData.data, arrayIndex: 0)
                }else{
                    self.delegate?.projectTaskList(list: jsonData.data, arrayIndex: itemIndex)
                }
                
                
              
                
               // self.delegate?.projectList(list: jsonData.data)
                print("Data is ")
                dump(jsonData)
                
              
                
            }catch  let jsonError{
                
                print(jsonError)
            }
            
        }) { (error) in
            
        }
        
        
    }
    
    
}
