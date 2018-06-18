//
//  AddTimeApiInteraction.swift
//  CameraApp
//
//  Created by JEEVAN TIWARI on 18/04/18.
//  Copyright © 2018 JEEVAN TIWARI. All rights reserved.
//

import Foundation


protocol AddTaskProtocol {
    
    func addTask(data: AddTaskDataModel?, error: String?)

}


class AddTaskModel: Decodable{


    var error: Bool?
    var message: String?
    var status: Bool?
    var data: AddTaskDataModel?

}

class AddTaskDataModel: Decodable{

    var CompanyId: Int?
    var CreateDate: CLong?
    var Description: String?
    var Hours: Int?
    var Minutes: Int?
    var ModifieDate: CLong?
    var ProjectId: Int?
    var TaskId: Int?
    var TaskText: String?
    var UserId: Int?

}



class AddTimeApiInteraction{
    
    var delegate: AddTimeController?
    
    func addTaskToServer(bodyParameter: [String: String], type: String){

        var url = ""
        if type == "update"{
            url = NetworkWebApisConstant.baseUrl + NetworkWebApisConstant.AddTimeControllerApi.updateTask
        }else{
            url = NetworkWebApisConstant.baseUrl + NetworkWebApisConstant.AddTimeControllerApi.addTaskUrl
        }
        
        
    
        Networking.shared.httpPostRequest(url: url, bodyParameter: bodyParameter, header: url.getBodyHeader(), dataIn: { (data) in


            do{
                let jsonData = try JSONDecoder().decode(AddTaskModel.self, from: data)
                
                if jsonData.error == false{
                        self.delegate?.addTask(data: jsonData.data, error: nil)
                }else{
                        self.delegate?.addTask(data: nil ,error: jsonData.message)
                }
                
                
            }catch let error{
                self.delegate?.addTask(data: nil, error: error.localizedDescription)
            }


        }) { (error) in
                 self.delegate?.addTask(data: nil, error: error)
        }
        
    }
    
}
