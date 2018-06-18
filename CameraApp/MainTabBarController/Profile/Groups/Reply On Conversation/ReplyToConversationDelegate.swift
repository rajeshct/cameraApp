//
//  ReplyToConversationDelegate.swift
//  CameraApp
//
//  Created by JEEVAN TIWARI on 28/04/18.
//  Copyright © 2018 JEEVAN TIWARI. All rights reserved.
//

import UIKit
import PINRemoteImage


extension ReplyToConversationController: UITableViewDelegate, UITableViewDataSource{
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        switch section {
        case 0:
            return 1
        default:
            return repliesToChatData?.count ?? 0
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        if indexPath.section == 0 {
            return chattingCell
        }
        
         let cell = tableView.dequeueReusableCell(withIdentifier: "ReplyToConversationCell", for: indexPath) as! ReplyToConversationCell
        cell.data = repliesToChatData?[indexPath.item]
        cell.parentInstance = self
        cell.selectionStyle = .none
        return cell
    }
}

extension ReplyToConversationController{
    
    @objc func getChatData(){
        let getChatObj = GroupChatApiInteraction()
        getChatObj.delegate = self
        
        dump(groupData)
        if let projectId = projectId, let parentId = groupData?.CommentId{
            if let getsubGroupId = subGroupId{
                 getChatObj.getGroupList(projectId: String(projectId), parentCommentId: String(parentId), subGroupId: String(getsubGroupId))
            }else{
                  getChatObj.getGroupList(projectId: String(projectId), parentCommentId: String(parentId), subGroupId: "0")
            }
           
        }
        
       
        
        
    }
    
    
}


extension ReplyToConversationController: GetGroupChatDelegate{
    func setSeenBy(data: String?, error: String?) {
        
    }
    
    
    func getDeleteConversation(data: DeleteConversationModel?, error: String?) {
        
    }
    
   
    func getSeenConversation(data: String?, error: String?) {
        
    }
    
    
    func getGroupChatData(data: [GroupChatDataModel]?, error: String?) {
        
        repliesToChatData = data
        replyTableView.reloadData()
        dump(data)
    }

    @objc func handleAttachment(){

        view.addSubview(selectedImagesCollectionView)
        view.addSubview(cameraGalleryView)


        cameraGalleryView.anchorToTop(top: nil, left: view.leftAnchor, bottom: replyView.topAnchor, right: view.rightAnchor)
        cameraGalleryView.heightAnchor.constraint(equalToConstant: 49).isActive = true

        selectedImagesCollectionView.anchorWithConstantsToTop(top: nil, left: view.leftAnchor, bottom: cameraGalleryView.topAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 16, bottomConstant: 16, rightConstant: 16)
        selectedImagesCollectionView.heightAnchor.constraint(equalToConstant: 100).isActive  = true
    }

    
}


extension ReplyToConversationController:  UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    @objc func handleGallery(){
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }


    @objc func handleSend(){

        //view.showActivityIndicator(activityIndicator: activityIndicator)

        var bodyParam = [String: String]()

        SaveUserDataOnLogin.shared.getUserDataFromPlist(completion: { (result) in

            if let userId = result.result?.ID{
                bodyParam.updateValue(String(userId), forKey: "UserId")
            }

            if let comment = self.replyView.replyTextField.text{
                if comment != ""{
                    bodyParam.updateValue(comment, forKey: "Comment")
                }else{
                    bodyParam.updateValue("", forKey: "Comment")
                }
            }

            if let companyId = result.result?.CompanyId{
                bodyParam.updateValue(String(companyId), forKey: "CompanyId")
            }


            if let unWrappedProjectId = self.projectId{
                bodyParam.updateValue(String(unWrappedProjectId), forKey: "ProjectId")
            }

            if let parentId = self.groupData?.CommentId{
                bodyParam.updateValue(String(parentId), forKey: "ParentCommentId")
            }

            bodyParam.updateValue("1", forKey: "CommentType")

            self.callServer(bodyParam: bodyParam)
//
//            let createConversation = NewConversationApiInteraction()
//            createConversation.delegate = self
//            createConversation.createNewConversation(imageArray: self.selectedImages, bodyParam: bodyParam, type: "create", groupId: "0")

        }) { (error) in

        }



    }
    
    
    
    func callServer(bodyParam: [String: String]){
        
        
        if let _ = groupData{
            let createConversation = NewConversationApiInteraction()
            createConversation.delegate = self
            createConversation.createNewConversation(imageArray: self.selectedImages, bodyParam: bodyParam, type: "create", groupId: "0")
            
        }
        
        if let subGroupId = subGroupId{
            let createConversation = NewConversationApiInteraction()
            createConversation.delegate = self
            createConversation.createNewConversation(imageArray: self.selectedImages, bodyParam: bodyParam, type: "create", groupId: String(subGroupId))
            
            
        }
        
    }



    @objc func handleCamera(){
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {

        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
             //  imageView.contentMode = .ScaleAspectFit
              //imageView.image = pickedImage
            selectedImages.append(pickedImage)
            selectedImagesCollectionView.reloadData()

        }
        dismiss(animated: true, completion: nil)

}
}

extension ReplyToConversationController: NewConversationDelegate{
    
    func newConversationCreated(successData: String?, onError: String?) {
        if let getError = onError{
            Alerts.shared.displaySimpleAlert(displayIn: self, title: "Error Occoured", message: getError)
        }else{
            getChatData()
        }
    }



}


extension ReplyToConversationController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return selectedImages.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewConversationCell", for: indexPath) as! NewConversationCell
        cell.selectImage.image = selectedImages[indexPath.item]
        return cell
    }


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.width - 32) / 2, height: 200)
    }
}


extension ReplyToConversationController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        replyView.replyTextField.resignFirstResponder()
        
        return true
    }
}



extension ReplyToCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictureData?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserNameCollectionViewCell", for: indexPath) as! UserNameCollectionViewCell
        cell.imageName = pictureData?[indexPath.item].Url
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 64 , height: (UIScreen.main.bounds.width - 64) * 9 / 16)
    }
    
}
