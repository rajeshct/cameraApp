//
//  NewConversationApiInteraction.swift
//  CameraApp
//
//  Created by JEEVAN TIWARI on 14/05/18.
//  Copyright © 2018 JEEVAN TIWARI. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

protocol NewConversationDelegate{
    func newConversationCreated(successData: String?,onError: String?)
}


class NewConversationModel: Decodable{
    var error: Bool?
    var message: String?
    var status: Bool?
   // var data: NewConversationDataModel?
}

class NewConversationDataModel: Decodable{
    var Comment :  String?

}

class NewConversationApiInteraction{
    
    var delegate: NewConversationDelegate?
    
    func createNewConversation(imageArray: [UIImage], bodyParam: [String: String], type: String, groupId: String){
        
        guard let token = UserDefaults.standard.value(forKey: "token") as? String else{
            return
        }
        
        var url = ""
        if type == "create"{
             url = NetworkWebApisConstant.baseUrl  + NetworkWebApisConstant.GroupsControllerApi.createGroupMessage
        }else{
            url = NetworkWebApisConstant.baseUrl  + NetworkWebApisConstant.GroupsControllerApi.updateConversation 
        }
        
        
        
        
        
        let headers: HTTPHeaders = [
            /* "Authorization": "your_access_token",  in case you need authorization header */
            "token": token,
            "client" : "android",
            "Content-type": "multipart/form-data"
        ]
        
        
       
        
        Networking.shared.requestWith(url: url, headers: headers, parameters: bodyParam, imageArray: imageArray, onCompletion: { (value) in
            
            
            do{
                let jsonData = try JSONDecoder().decode(NewConversationModel.self, from: value)
                
                if let status  = jsonData.error{
                    if !status{
                            self.delegate?.newConversationCreated(successData: jsonData.message, onError: nil)
                    }else{
                            self.delegate?.newConversationCreated(successData: nil, onError: jsonData.message)
                    }
                    
                }
            
                
            }catch let jsonError{
                self.delegate?.newConversationCreated(successData: nil, onError: jsonError.localizedDescription)
            }
            
            
        }) { (error) in
            self.delegate?.newConversationCreated(successData: nil, onError: error)
        }
        
        
    }
    
    
}
