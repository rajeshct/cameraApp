//
//  GroupChatDelegate.swift
//  CameraApp
//
//  Created by JEEVAN TIWARI on 28/04/18.
//  Copyright © 2018 JEEVAN TIWARI. All rights reserved.
//

import UIKit

extension GroupChatController: UITableViewDelegate, UITableViewDataSource{
    
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        navigationController?.pushViewController(ReplyToConversationController(), animated: true)
//    }
//
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupChatData?.count ?? 0 
    }
    
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {


        if returnAppropiateCell(indexpath: indexPath) == "commentAndPicture"{
            
           
            let cell = tableView.dequeueReusableCell(withIdentifier: "GroupChatCellWithCommentAndPic", for: indexPath) as! GroupChatCellWithCommentAndPic
            cell.data =  groupChatData?[indexPath.item]
            cell.item = indexPath.item
            cell.delegate = self
            return cell
            
            
        }else if returnAppropiateCell(indexpath: indexPath) == "picture"{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "GroupChatCellWithCommentAndPicture", for: indexPath) as! GroupChatCellWithCommentAndPicture
                       cell.data = groupChatData?[indexPath.item]
                     cell.selectionStyle = .none
            cell.item = indexPath.item
            cell.delegate = self
                      return cell
            
        }
            
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupChatCellWithComment", for: indexPath) as! GroupChatCellWithComment
        cell.selectionStyle = .none
        cell.item = indexPath.item
        cell.delegate = self
        cell.data = groupChatData?[indexPath.item]
        return cell
        
        
    }
    
    func returnAppropiateCell(indexpath: IndexPath) -> String{
        
            if let comment = groupChatData?[indexpath.item].Comment, let fileArray = groupChatData?[indexpath.item].File{
                
                
                if comment != "" && fileArray.count > 0 {
                    return "commentAndPicture"
                }else if comment == "" && fileArray.count > 0{
                    return "picture"
                }
                
                
            }
        
        return "comment"
            
    
}
}


extension GroupChatController{
    
    func getChats(){
        
        refreshControl.endRefreshing()
        view.showActivityIndicator(activityIndicator: activityIndicator)
        let getChatObj = GroupChatApiInteraction()
        getChatObj.delegate = self
        
        if let projectId = groupData?.ProjectID{
            getChatObj.getGroupList(projectId: String(projectId), parentCommentId: "0", subGroupId: "0")
        }
        
        
//        if let projectId = subGroupData?.GroupId, let subGroupId = subGroupData?.SubGroupId{
//            getChatObj.getGroupList(projectId: String(projectId), parentCommentId: "0", subGroupId: String(subGroupId))
//        }
        
        
        
    }
    
    func getSubGroupData(){
       
        refreshControl.endRefreshing()
        view.showActivityIndicator(activityIndicator: activityIndicator)
        let getChatObj = GroupChatApiInteraction()
        getChatObj.delegate = self
        
        
        if let projectId = subGroupData?.GroupId, let subgroupId = subGroupData?.SubGroupId{
            
            getChatObj.getGroupList(projectId: String(projectId), parentCommentId: "0", subGroupId: String(subgroupId))
        }
        
//        if let projectId = groupData?.ProjectID{
//            getChatObj.getGroupList(projectId: String(projectId), parentCommentId: "0", subGroupId: <#String#>)
//        }
        
    }
    
    func createSubGroup(){
        
        let createSubGroupBarButton = UIBarButtonItem(title: "Create Subgroup", style: .plain, target: self, action: #selector(handleCreateGroup))
        createSubGroupBarButton.setTitleTextAttributes([NSAttributedStringKey.font: UIFont(name: UILabel().font.fontName, size: 13)], for: .normal)
        navigationItem.rightBarButtonItem = createSubGroupBarButton
    }
    
    
    @objc func handleCreateGroup(){
     let createSubGroupController = CreateSubgroupController()
        createSubGroupController.groupData = groupData
      navigationController?.pushViewController(createSubGroupController, animated: true)
        
        
    }
    
    
}




extension  UserNameCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 64 , height: (UIScreen.main.bounds.width - 64) * 9 / 16)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data?.File?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserNameCollectionViewCell", for: indexPath) as! UserNameCollectionViewCell
        cell.imageName = data?.File?[indexPath.item].Url
        return cell
    }
    
}


extension  UserNameCommentCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 64 , height: (UIScreen.main.bounds.width - 64) * 9 / 16)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data?.File?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserNameCollectionViewCell", for: indexPath) as! UserNameCollectionViewCell
        cell.imageName = data?.File?[indexPath.item].Url
        return cell
    }
    
}

extension GroupChatController: GetGroupChatDelegate{
    func setSeenBy(data: String?, error: String?) {
        
    }
    
    
    
    func getDeleteConversation(data: DeleteConversationModel?, error: String?) {
        
        if let getError = error{
            
            Alerts.shared.displaySimpleAlert(displayIn: self, title: "Warning", message: getError)
            
        }else{
            
            if let getStatus = data?.status{
                if getStatus{
                    if let message = data?.message{
                             Alerts.shared.displaySimpleAlert(displayIn: self, title: "Success", message: message)
                        getChats()
                    }
                   
                }else{
                    if let message = data?.message{
                          Alerts.shared.displaySimpleAlert(displayIn: self, title: "Warning", message: message)
                    }
                    
                }
            }
            
        }
    }
    
   
    
    func getSeenConversation(data: String?, error: String?) {
        
    }
    
  
    
    func getGroupChatData(data: [GroupChatDataModel]?, error: String?) {
        
        view.removeActivityIndicator(activityIndicator: activityIndicator)
        
        if let getError = error{
            Alerts.shared.displaySimpleAlert(displayIn: self, title: "Warning", message: getError)
        }else{
            groupChatData = data
            groupChatTableView.reloadData()
        }
        
        
       
    }
    
    
    @objc func handleNewConversation(){
        
        
        let createConversation = NewConversationController()
        createConversation.projectId = groupData?.ProjectID
        createConversation.subGroupData = subGroupData
        navigationController?.pushViewController(createConversation, animated: true)
        
        
    }
    
    
}



extension GroupChatController: ViewFullConversationDelegate{
  
    
    func handleEdit(item: Int?) {
        
        let editConversationObj = NewConversationController()
        if let index = item{
            editConversationObj.groupData = groupChatData?[index]
            editConversationObj.projectId = groupData?.ProjectID
            
        }
        
        navigationController?.pushViewController(editConversationObj, animated: true)
        
    }
    
    
    
    func handleDeleteConversation(item: Int?) {
        print("handle Deelete conversation at", item)
        
        var bodyParam = [String: String]()
       
        
        if let projectId = groupData?.ProjectID{
            
            bodyParam.updateValue(String(projectId), forKey: "ProjectId")
        }
        
        
        if let index = item{
            
            if let parentCommentId = groupChatData?[index].CommentId{
                
                bodyParam.updateValue(String(parentCommentId), forKey: "ParentCommentId")
            }
            
            
        }
        
        
        
        let deleteConversationObj =  GroupChatApiInteraction()
        deleteConversationObj.delegate = self
        deleteConversationObj.deleteConversation(body: bodyParam)
        
    }
    
    
    func handleSeenBy(commentId: Int?) {
        
        if let window = UIApplication.shared.keyWindow{
            let seenBy = SeenByPopUp()
            seenBy.commentId = commentId
            window.addSubview(seenBy)
            seenBy.anchorToTop(top: window.topAnchor, left: window.leftAnchor, bottom: window.bottomAnchor, right: window.rightAnchor)
        }
        
        
    }
    
    
    func handleFullConversation(item: Int) {
    
        setSeenByUser(item: item)
        let replyToChat = ReplyToConversationController()
        let cell = tableView(groupChatTableView, cellForRowAt: IndexPath(item: item, section: 0))
      //replyToChat.chattingCell = cell
        if let _ = groupData{
          replyToChat.projectId = groupData?.ProjectID
        }else{
            replyToChat.projectId = subGroupData?.GroupId
        }
        
        replyToChat.groupData = groupChatData?[item]
        replyToChat.subGroupId = subGroupData?.SubGroupId
        
        navigationController?.pushViewController(replyToChat, animated: true)
        
        
    }
    
    func setSeenByUser(item: Int){
        
        if let seenByValue = groupChatData?[item].LoggedUserSeen{
            
            if !seenByValue{
                
                let seenByObj = GroupChatApiInteraction()
                
                if let userId = UserDefaults.standard.value(forKey: "userId") as? String{
                    if let projectId = groupChatData?[item].projectId, let commentId = groupChatData?[item].CommentId{
                        
                        let serverBody = [
                            "ProjectId": String(projectId),
                            "CommentId": String(commentId),
                            "CommentType": "0",
                            "UserId": userId
                        ]
                        
                        seenByObj.setSeenBy(body: serverBody)
                        
                    }
                    
                }
                
                    
                    

            }
        }
        
        
    }
    
    @objc func handleRefresh(){
        getChats()
    }
    
    
}







extension GroupChatCellWithComment: DeleteConversationDelegate{
    
    func deleteConversation() {
        
        delegate?.handleDeleteConversation(item: item)
        
    }
    
    
    
}

extension GroupChatCellWithCommentAndPicture: DeleteConversationDelegate{
    
    func deleteConversation() {
        
        delegate?.handleDeleteConversation(item: item)
        
    }
    
    
    
}

extension GroupChatCellWithCommentAndPic: DeleteConversationDelegate{
    
    
    
    func deleteConversation() {
        
        delegate?.handleDeleteConversation(item: item)
        
    }
    
    
    
}


