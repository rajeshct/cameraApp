//
//  ForgotPasswordApiInteraction.swift
//  CameraApp
//
//  Created by JEEVAN TIWARI on 24/04/18.
//  Copyright © 2018 JEEVAN TIWARI. All rights reserved.
//

import Foundation



class ForgotModel: Decodable{
    
    //var data :
    var status: String?
    var error: String?
    var code: String?
    var message: String?
    
}

protocol ForgotPasswordProtocol {
    func getForgotData(forgotData: String?, error: String?)
}


class ForgotPasswordApiInteraction{
    
    var delegate: ForgotPasswordProtocol?
    
    
    func getLoginResponse(loginData: [String: String]){
        
        let url = NetworkWebApisConstant.baseUrl + NetworkWebApisConstant.LoginController.forgotPasswordUrl
        
        let param = [
            "Email": "admin@app.com",
            "Password": "123"
        ]
        
        let header = [
            "token" : "MSxhZG1pbkBhcHAuY29tLDNwNGE1azZkMWUyZQ==",
            "client" :" android"
        ]
        
        Networking.shared.httpPostRequest(url: url, bodyParameter:param, header: header
            , dataIn: { (data) in
                
                
                do{
                    
                let loginCredentials = try JSONDecoder().decode(ForgotModel.self, from: data)
                    print("The data is ")
                    dump(loginData)
                    self.delegate?.getForgotData(forgotData: "Hi", error: "hello")
                    
                  
                    
                }catch let jsonError{
                      self.delegate?.getForgotData(forgotData: "Hi", error: "hello")
                }
                
                
        }) { (error) in
            
        }
        
    }
    
    
}
