//
//  GroupChatApiInteraction.swift
//  CameraApp
//
//  Created by JEEVAN TIWARI on 28/04/18.
//  Copyright © 2018 JEEVAN TIWARI. All rights reserved.
//

import Foundation


protocol GetGroupChatDelegate{
    
    func getGroupChatData(data: [GroupChatDataModel]?, error: String?)
    func getSeenConversation(data: String?, error: String?)
    func getDeleteConversation(data: DeleteConversationModel?, error: String?)
    func setSeenBy(data: String?, error: String?)
}


class GroupChatModel: Decodable{
    
    var data: [GroupChatDataModel]?
    var status: Bool?
   // var code: String?
    var message: String?
    var error: Bool?
}

class GroupChatDataModel: Decodable{
    
    var CommentId: Int?
    var Comment : String?
    var UserProfile: UserProfileModel?
    var CreatedTime: CLong?
    var File: [UserProfileFileModel]?
    var ParentCommentId: Int?
    var projectId: Int?
    var TotalChildCount: Int?
    var ChildComment: [GroupChatDataModel]?
    //var isMoreDataAvailable: String?
    var seenBy: [UserCommentSeenModel]?
    var seenCount: Int?
    var LoggedUserSeen: Bool?

}

class ClassCommentModel: Decodable{
    var Comment: String?
    var CommentId: Int?
    var CommentType: Int?
    var CompanyId: Int?
    var CreateDate: CLong?
    var MobileCreatedId: Int?
    var ModifieDate: CLong?
    var ParentCommentId: Int?
    var ProjectId: Int?
    var Status: Bool?
    var ThreadId: Int?
    var UserId: Int?
}


class UserProfileModel: Decodable{
   var UserId: Int?
    var ImageUrl: String?
    var CreatedDate: CLong?
    var FirstName: String?
    var LastName: String?

    
    
}



class UserProfileFileModel: Decodable{
   
    var Url: String?
    var FileType: String?

}


class UserCommentSeenModel: Decodable{
 //   var UserId: String?
    var ImageUrl: String?
    var FirstName: String?
    var LastName: String?
    var CreatedDate: CLong?
}

class DeleteConversationModel: Decodable{
    
    var error:  Bool?
    var message: String?
    var status: Bool?
}




class GroupChatApiInteraction{
    
    var delegate: GetGroupChatDelegate?
    
    func  getGroupList(projectId: String, parentCommentId: String, subGroupId: String){
        
        let url  = NetworkWebApisConstant.baseUrl + NetworkWebApisConstant.GroupsControllerApi.groupChatComments + "?projectId=\(projectId)&parentCommentId=\(parentCommentId)&pageNo=1&SubGroupID=\(subGroupId)"
        
        //NetworkWebApisConstant.baseUrl + NetworkWebApisConstant.ProjectControllerApi.projectUrl
        
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
                
                let jsonData = try JSONDecoder().decode(GroupChatModel.self, from: data)
                
                self.delegate?.getGroupChatData(data: jsonData.data, error: nil)
                // self.delegate?.projectList(list: jsonData.data)
                print("Data is ")
             //   print(dump(jsonData))
                
                
            }catch  let jsonError{
                
                print(jsonError)
                self.delegate?.getGroupChatData(data: nil, error: jsonError.localizedDescription)
            }
            
        }) { (error) in
            self.delegate?.getGroupChatData(data: nil, error: error)
        }
        
    }
    
    
    
    func getGroupSeen(body: [String: String]){
        
        let url = NetworkWebApisConstant.baseUrl + NetworkWebApisConstant.GroupsControllerApi.getConversationSeen
        
        Networking.shared.httpGetRequest(url: url, bodyParameter: body, header: url.getHeader(), dataIn: { (data) in
            
            
        }) { (error) in
            
            
        }
        
        
    }
    
    
    
    func deleteConversation(body: [String: String]){
        
        let url = NetworkWebApisConstant.baseUrl + NetworkWebApisConstant.GroupsControllerApi.deleteConversation
        
        
        
        Networking.shared.httpPostRequest(url: url, bodyParameter: body, header: url.getBodyHeader(), dataIn: { (data) in
            
            do{
                let jsonData = try JSONDecoder().decode(DeleteConversationModel.self, from: data)
                
              //  self.delegate?.setSeenBy(data: <#T##String?#>, error: <#T##String?#>)
                
            }catch let jsonError{
                self.delegate?.setSeenBy(data: nil, error: jsonError.localizedDescription)
            }
        }) { (error) in
                self.delegate?.setSeenBy(data: nil, error: error)
        }
        
        
        
        
    }
    
    
    func setSeenBy(body: [String: String]){
        
        let url = NetworkWebApisConstant.baseUrl + NetworkWebApisConstant.GroupsControllerApi.setSeenBy
        
        
        
        Networking.shared.httpPostRequest(url: url, bodyParameter: body, header: url.getBodyHeader(), dataIn: { (data) in
            
            do{
                let jsonData = try JSONDecoder().decode(DeleteConversationModel.self, from: data)
                
                //self.delegate?.getDeleteConversation(data: jsonData, error: nil)
            }catch let jsonError{
               // self.delegate?.getDeleteConversation(data: nil, error: jsonError.localizedDescription)
            }
        }) { (error) in
            //self.delegate?.getDeleteConversation(data: nil, error: error)
        }
        
        
    
    }
    
    
    
    
    
    
    
}



class SeenByModel: Decodable{
    
    var data: SeenByCountModel?
    var status: Bool?
    var error: Bool?
   // var code: Int?
    var message: String?
    
    
    
}


class SeenByCountModel: Decodable{
    
    var Count: Int?
    var result: [SeenByDataModel]?
    
    
}


class SeenByDataModel: Decodable{
    var UserId: Int?
   var  ImageUrl: String?
    var FirstName: String?
    var LastName: String?
    var CreatedDate: CLong?
}


protocol SeenByDelegate{
    
    func seenByDetails(data: SeenByCountModel?,error: String?)
}

class SeenByApiInteraction{
    
    var delegate: SeenByDelegate?
    func getSeenBy(commentId: String, groupId: String){
        
        
        
        let url = NetworkWebApisConstant.baseUrl + NetworkWebApisConstant.GroupsControllerApi.getSeenBy + "?commentId=\(commentId)&subGroupId=\(groupId)"
        
        Networking.shared.httpGetRequest(url: url, bodyParameter: [:], header: url.getBodyHeader(), dataIn: { (data) in
            
            do{
                let jsonData = try JSONDecoder().decode(SeenByModel.self, from: data)
                self.delegate?.seenByDetails(data: jsonData.data, error: nil)
            }catch let jsonError{
                self.delegate?.seenByDetails(data: nil, error: jsonError.localizedDescription)
            }
            
            
        }) { (error) in
             self.delegate?.seenByDetails(data: nil, error: error)
        }
        
    }
    
}







