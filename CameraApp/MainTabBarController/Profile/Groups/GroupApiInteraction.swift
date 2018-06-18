//
//  GroupApiInteraction.swift
//  CameraApp
//
//  Created by JEEVAN TIWARI on 28/04/18.
//  Copyright © 2018 JEEVAN TIWARI. All rights reserved.
//

import Foundation


protocol GetGroupDelegate{
    
    func getGroupData(data: [GroupDataModel]?, error: String?)
    
}


class GroupModel: Decodable{
    
    var data: [GroupDataModel]?
    var status: Bool?
    var code: String?
    var message: String?
    var error: Bool?
}

class GroupDataModel: Decodable{
    var ProjectID: Int?
    var ProjectName: String?
    var StartDate: CLong?
    var EndDate: CLong?
    var  ProjectAssignTo: String?
    var ProjectBudGet: String?
    var ModifiedDate: CLong?
    var Status: Bool?
    var UserID: Int?
    var CompanyId: Int?
    var Description: String?
    var CreatedByName: String?
    var CreateDate: CLong?
    var SubGroup: [SubGroupModel]?
}

class SubGroupModel: Decodable{
    
    
    var CreateDate : CLong?
    var GroupId : Int?
    var ModifiedDate : CLong?
    var SubGroupDescription : String?
    var SubGroupId : Int?
    var SubGroupMembers : String?
    var SubGroupName : String?
    var UserId : Int?
    var status : Bool?
    
    
}

public struct Item {
    
    
    var CreateDate : CLong?
    var GroupId : Int?
    var  ModifiedDate : CLong?
    var SubGroupDescription : String?
    var  SubGroupId : Int?
    var SubGroupMembers : String?
    var SubGroupName : String?
    var UserId : Int?
    var  status : Bool?
    
    public init(CreateDate: CLong?, GroupId: Int?, ModifiedDate: CLong?, SubGroupDescription: String?, SubGroupId: Int?,SubGroupMembers: String?, SubGroupName: String?, UserId: Int?, status: Bool?) {
        
        self.CreateDate = CreateDate
        self.GroupId = GroupId
        self.ModifiedDate = ModifiedDate
        self.SubGroupDescription = SubGroupDescription
        self.SubGroupId = SubGroupId
        self.SubGroupMembers = SubGroupMembers
        self.SubGroupName = SubGroupName
        self.UserId = UserId
        self.status = status
    }
}

public struct Section {
    
    var ProjectID: Int?
    var ProjectName: String?
    var StartDate: CLong?
    var EndDate: CLong?
    var  ProjectAssignTo: String?
    var ProjectBudGet: String?
    var ModifiedDate: CLong?
    var Status: Bool?
    var UserID: Int?
    var CompanyId: Int?
    var Description: String?
    var CreatedByName: String?
    var CreateDate: CLong?
    var items: [Item]
    var collapsed: Bool
    
    public init(ProjectID: Int?,ProjectName: String?,StartDate: CLong?,EndDate: CLong?,ProjectAssignTo: String?,ProjectBudGet: String?,ModifiedDate: CLong?,Status: Bool?,UserID: Int?, CompanyId: Int?,Description: String?,CreatedByName: String?, CreateDate: CLong?, items: [Item], collapsed: Bool = true) {
        
        self.ProjectID = ProjectID
        self.ProjectName = ProjectName
        self.StartDate = StartDate
        self.EndDate = EndDate
        self.ProjectAssignTo = ProjectAssignTo
        self.ProjectBudGet = ProjectBudGet
        self.ModifiedDate = ModifiedDate
        self.Status = Status
        self.UserID = UserID
        self.CompanyId = CompanyId
        self.Description = Description
        self.CreatedByName = CreatedByName
        self.CreateDate = CreateDate
        self.items = items
        self.collapsed = collapsed
        
    }
}







class GroupApiInterataction{
    
    var delegate: GroupController?
    
    func  getGroupList(companyId: String){
        
        
        
        
        let url  = NetworkWebApisConstant.baseUrl + NetworkWebApisConstant.GroupsControllerApi.groupListsUrl + "?companyId=\(companyId)"
        
        
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
                
                let jsonData = try JSONDecoder().decode(GroupModel.self, from: data)
                
                self.delegate?.getGroupData(data: jsonData.data, error: nil)
                // self.delegate?.projectList(list: jsonData.data)
                print("Data is ")
                print(jsonData)
                
                
            }catch  let jsonError{
                
                self.delegate?.getGroupData(data: nil, error: jsonError.localizedDescription)
                print(jsonError)
            }
            
        }) { (error) in
            self.delegate?.getGroupData(data: nil, error: error)
        }
        
    }
}
