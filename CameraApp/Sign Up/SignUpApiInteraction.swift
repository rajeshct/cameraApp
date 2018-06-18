//
//  SignUpApiInteraction.swift
//  CameraApp
//
//  Created by JEEVAN TIWARI on 29/05/18.
//  Copyright © 2018 JEEVAN TIWARI. All rights reserved.
//

import UIKit


protocol EditDelegate {
    func editProfile(loginData: LoginData?, error: String?)
}

class EditSuccessModel : Decodable{
    
    
    var message: String?
    var error: Bool?
    var data : LoginData?
    
    
}



class SignUpApiInteraction{
    
    
    
    var delegate: EditDelegate?
    
    func registerUser(bodyParam: [String: String], images: [UIImage]){
        
        let url = NetworkWebApisConstant.baseUrl + NetworkWebApisConstant.LoginController.editProfile
        
        Networking.shared.requestWith(url: url, headers: url.getMultiPartHeader(), parameters: bodyParam, imageArray: images, onCompletion: { (data) in
            
            do{
                let jsonData = try JSONDecoder().decode(EditSuccessModel.self, from: data)
                if jsonData.error == false{
                    self.delegate?.editProfile(loginData: jsonData.data, error: jsonData.message)
                }else{
                    self.delegate?.editProfile(loginData: nil, error: jsonData.message)
                }
                print(dump(jsonData))
            }catch let jsonError{
               self.delegate?.editProfile(loginData: nil, error: jsonError.localizedDescription)
            }
            
        }) { (error) in
        
            self.delegate?.editProfile(loginData: nil, error: error)
        }
        
        
        
    }
    
}
