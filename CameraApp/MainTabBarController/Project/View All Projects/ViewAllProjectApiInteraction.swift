//
//  ViewAllProjectApiInteraction.swift
//  CameraApp
//
//  Created by JEEVAN TIWARI on 27/05/18.
//  Copyright © 2018 JEEVAN TIWARI. All rights reserved.
//

import Foundation

protocol AllprojectsDelegate{
    func allProjects(data: [ProjectListModel]?,error: String?)
}


class ViewAllProjectsModel: Decodable{
    
    
}


class ViewAllProjectApiInteraction{
    
    var delegate: AllprojectsDelegate?
    
    func getAllProjectList(companyId: String, projectName: String){
        
        let url = NetworkWebApisConstant.baseUrl  + NetworkWebApisConstant.ProjectControllerApi.viewAllProject + "?projectName=\(projectName)&companyId=\(companyId)"
            
    
            
        Networking.shared.httpGetRequest(url: url, bodyParameter: [:], header: url.getBodyHeader(), dataIn: { (data) in
            
            do{
                
                let jsonData = try JSONDecoder().decode(ProjectListApiModel.self, from: data)
                self.delegate?.allProjects(data: jsonData.data, error: nil)
            }catch let error{
                
                
            }
            
        }) { (error) in
            
            
            
        }
        
    }
    
}
