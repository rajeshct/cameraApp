//
//  NewConversationDelegate.swift
//  CameraApp
//
//  Created by JEEVAN TIWARI on 28/04/18.
//  Copyright © 2018 JEEVAN TIWARI. All rights reserved.
//

import UIKit


extension NewConversationController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource{
    
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


extension NewConversationController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @objc func handleGallery(){
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    @objc func handleSend(){
        
        view.showActivityIndicator(activityIndicator: activityIndicator)
        
        if let _ = groupData{
            
            handleUpdate()
        }else{
        
        
        var bodyParam = [String: String]()
        
        SaveUserDataOnLogin.shared.getUserDataFromPlist(completion: { (result) in
            
            if let userId = result.result?.ID{
                bodyParam.updateValue(String(userId), forKey: "UserId")
            }
            
            if let comment = self.chatCommentTextView.text{
                if comment != "Start new conversation..."{
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
            }else{
                if let unwrappedProjectId = self.subGroupData?.GroupId{
                    bodyParam.updateValue(String(unwrappedProjectId), forKey: "ProjectId")
                }
            }
            
            bodyParam.updateValue("0", forKey: "ParentCommentId")
            bodyParam.updateValue("0", forKey: "CommentType")
            
            
            
            
            self.callServer(bodyParam: bodyParam)
            
            
        
        }) { (error) in
            
        }
            
        }
        

        
    }
    
    
    @objc func handleUpdate(){
        
        var bodyParam = [String: String]()
        
        SaveUserDataOnLogin.shared.getUserDataFromPlist(completion: { (result) in
            
            if let userId = result.result?.ID{
                bodyParam.updateValue(String(userId), forKey: "UserId")
            }
            
            if let comment = self.chatCommentTextView.text{
                if comment != "Start new conversation..."{
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
            }else{
                if let unwrappedProjectId = self.subGroupData?.GroupId{
                    bodyParam.updateValue(String(unwrappedProjectId), forKey: "ProjectId")
                }
            }
            
            bodyParam.updateValue("0", forKey: "ParentCommentId")
            bodyParam.updateValue("0", forKey: "CommentType")
            
            if let commentId = self.groupData?.CommentId{
                bodyParam.updateValue(String(commentId), forKey: "CommentID")
            }
            
            
            if let subgroupId = self.subGroupData{
                
                self.callServer(bodyParam: bodyParam)
                
            }
            
            
            
            
            
           
            
        }) { (error) in
            
        }
        
        
    }
    
    
    func callServer(bodyParam: [String: String]){
        
        
        
        if let subGroupId = subGroupData?.SubGroupId{
            
            var subGroupBody = bodyParam
            subGroupBody.updateValue(String(subGroupId), forKey: "SubGroupID")
            let createConversation = NewConversationApiInteraction()
            createConversation.delegate = self
            createConversation.createNewConversation(imageArray: self.selectedImages, bodyParam: subGroupBody, type: "create", groupId: String(subGroupId))
            
            
        }else{
            var groupBody = bodyParam
            groupBody.updateValue("0", forKey: "SubGroupID")
            let createConversation = NewConversationApiInteraction()
            createConversation.delegate = self
            createConversation.createNewConversation(imageArray: self.selectedImages, bodyParam: groupBody, type: "create", groupId: "0")
        }
        
    }

    
    @objc func handleCamera(){
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
         //   imageView.contentMode = .ScaleAspectFit
          //  imageView.image = pickedImage
            selectedImages.append(pickedImage)
            selectedImagesCollectionView.reloadData()
            
        }
        dismiss(animated: true, completion: nil)
        
    }
}


extension NewConversationController{
    
    func addKeyboardDelegate(){
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(NewConversationController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(NewConversationController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipeGesture.direction = .down
        
        view.addGestureRecognizer(swipeGesture)
        
    }
    
    @objc func handleSwipe(){
        
        chatCommentTextView.resignFirstResponder()
        
        
    }
    
//    @objc func keyboardWillShow(notification: NSNotification) {
//        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
//            
//            keyboardYOrigin = self.view.frame.origin.y
//            self.view.frame.origin.y -= keyboardSize.height 
//           
//        }
//    }
//    
//    @objc func keyboardWillHide(notification: NSNotification) {
//        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
//            
//                self.view.frame.origin.y  = keyboardYOrigin
//            
//        }
//    }
    
}


extension NewConversationController: UITextViewDelegate{
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if textView.text == "Start new conversation..."{
            textView.text = ""
        }
    }

    
    
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
           // keyboardHeight = keyboardRectangle.height
           
            sendViewConstraint?.constant = -(UIScreen.main.bounds.height - keyboardRectangle.origin.y)
        }
    }

    @objc func keyboardWillHide(_ notification: Notification) {
        sendViewConstraint?.constant = 0
    }
    
}


extension NewConversationController: NewConversationDelegate{
    func newConversationCreated(successData: String?, onError: String?) {
        
        view.removeActivityIndicator(activityIndicator: activityIndicator)
        if let error = onError{
            Alerts.shared.displaySimpleAlert(displayIn: self, title: "Warning", message: error)
        }else {
            if let successMessage = successData{
                Alerts.shared.displaySimpleAlert(displayIn: self, title: "Success", message: successMessage)
            }
            
        }
        
        
    }
    
    
}


extension NewConversationController{


    



}
