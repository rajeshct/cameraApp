//
//  AddTimeApiInteraction.swift
//  CameraApp
//
//  Created by JEEVAN TIWARI on 18/04/18.
//  Copyright © 2018 JEEVAN TIWARI. All rights reserved.
//

import Foundation


protocol CreateProjectDelegate {

    func addTask(data: CreateProjectDataModel?, error: String?)

}


class CreateProjectModel: Decodable{


    var error: Bool?
    var message: String?
    var status: Bool?
    var data: CreateProjectDataModel?

}

class CreateProjectDataModel: Decodable{

    var CompanyId: Int?
    var CreateDate: String?
    var CreatedByName:String?
    var Description: String?
    var EndDate : CLong?
    var ModifiedDate: String?
    var ProjectAssignTo: String?
    var ProjectBudGet: String?
    var ProjectID: Int?
    var ProjectName: String?
    var StartDate: CLong?
    var Status: Bool?
    var UserID: Int?

}



class EditProjectApiInteraction{

    var delegate: EditProjectTaskController?

    func addTaskToServer(bodyParameter: [String: String], taskType: String){
        
        var url = ""
        
        if taskType == "update"{
            url = NetworkWebApisConstant.baseUrl + NetworkWebApisConstant.ProjectControllerApi.updateProject
        }else{
            url = NetworkWebApisConstant.baseUrl + NetworkWebApisConstant.ProjectControllerApi.projectCreateUrl
        }
        
        


        Networking.shared.httpPostRequest(url: url, bodyParameter: bodyParameter, header: url.getBodyHeader(), dataIn: { (data) in

            do{
                
                
                
                let jsonData = try JSONDecoder().decode(CreateProjectModel.self, from: data)
                
                if jsonData.error == false{
                    self.delegate?.addTask(data: jsonData.data, error: nil)
                }else{
                    self.delegate?.addTask(data: nil, error: jsonData.message)
                }
                
            }catch let error{
                self.delegate?.addTask(data: nil, error: error.localizedDescription)
            }


        }) { (error) in
            self.delegate?.addTask(data: nil, error: error)
        }

    }

}
