//
//  LoginApiInteraction.swift
//  CameraApp
//
//  Created by JEEVAN TIWARI on 07/04/18.
//  Copyright © 2018 JEEVAN TIWARI. All rights reserved.
//

import Foundation



protocol LoginDataDelegate {
    
    func userDetails(userData: LoginResultsModel?)
    func wrongCredentials(error: String?)
}

class LoginModel: Codable{
    
    var Email: String?
    var Password: String?
}


class LoginSuccessModel: Decodable{
    
    
    var message: String?
    var error: Bool?
    var data : LoginResultsModel?
    
    
}

class EmployeeAssignModel: Decodable{
    
    var message: String?
    var error: Bool?
    var data : [LoginData]?
    
}

class LoginResultsModel: Codable{
    
    var employees: [LoginData]?
    var result: LoginData?
    
}

class LoginData: Codable{
    
    var ID: Int?
    var Email: String?
    var FirstName: String?
    var LastName: String?
   var UserType: Int?
   var IsActive: Bool?
    var Deleted: String?
    var Password: String?
    var CreateDate: CLong?
    var ModifiedDate: CLong?
    var LastLoginDate: CLong?
    var ParentID: Int?
    var CreatedBy: String?
    var AssignId: String?
    var Token: String?
   var CompanyId: Int?
    var ImagePath: String?
    
}



class LoginApiInteraction{
    
    var delegate: LoginDataDelegate?
    
    func getLoginResponse(loginData: [String: String]){
        
        let url = NetworkWebApisConstant.baseUrl + NetworkWebApisConstant.LoginController.loginUrl
        
    
        
        
        let header = [
            "token" : "",
            "client" :" android"
        ]
        
        Networking.shared.httpPostRequest(url: url, bodyParameter:loginData, header: header
            , dataIn: { (data) in
            
            
            do{
                
                
                let loginCredentials = try JSONDecoder().decode(LoginSuccessModel.self, from: data)
                
                if  loginCredentials.error == true{
                    self.delegate?.wrongCredentials(error: loginCredentials.message)
                }else{
                    self.delegate?.userDetails(userData: loginCredentials.data)
                }
                
                
                
            }catch let jsonError{
                print(jsonError)
               self.delegate?.wrongCredentials(error: jsonError.localizedDescription)
            }
            
            
        }) { (error) in
            self.delegate?.wrongCredentials(error: error)
        }
        
    }
    
    
}
