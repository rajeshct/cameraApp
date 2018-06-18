//
//  SignupDelegate.swift
//  CameraApp
//
//  Created by JEEVAN TIWARI on 27/05/18.
//  Copyright © 2018 JEEVAN TIWARI. All rights reserved.
//

import UIKit
import PINRemoteImage


extension SignupController{
    
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        
        if targetContentOffset.pointee.y < scrollView.contentOffset.y {
            // it's going up
            signupCell.dismissKeyboard()
        } else {
            // it's going down
            signupCell.dismissKeyboard()
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       return signupCell
    }
    
    
    func setup(){
        tableView.register(SignupCell.self, forCellReuseIdentifier: "SignupCell")
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 1000
    }
    
}

extension SignupCell: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField {
        case userNameTextField:
            nameTextField.becomeFirstResponder()
        case nameTextField:
            emailTextField.becomeFirstResponder()
        case emailTextField:
            mobileNumberTextField.becomeFirstResponder()
        case mobileNumberTextField:
            passwordTextField.becomeFirstResponder()
        case passwordTextField:
            confirmPasswordTextField.becomeFirstResponder()
        default:
            dismissKeyboard()
        }
        
        return true
        
    }
    
    func dismissKeyboard(){
        userNameTextField.resignFirstResponder()
        nameTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        mobileNumberTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        confirmPasswordTextField.resignFirstResponder()
    }
    
}




extension SignupController{

    
    
    
    func setui(){
        
        if screenType  == SignUpEdit.EDIT{
            signupCell.signUpButton.setTitle("UPDATE PROFILE", for: .normal)
            navigationItem.title = "UPDATE PROFILE"
            setData()
        }else{
            signupCell.signUpButton.setTitle("SIGN UP", for: .normal)
            navigationItem.title = "SIGN UP"
        }
        
    }

    func setData(){

        SaveUserDataOnLogin.shared.getUserDataFromPlist(completion: { (result) in

            self.signupCell.userNameTextField.text = UILabel().getFullName(firstName: result.result?.FirstName, lastName: result.result?.LastName)
            self.signupCell.emailTextField.text = result.result?.Email
            self.signupCell.nameTextField.text = UILabel().getFullName(firstName: result.result?.FirstName, lastName: result.result?.LastName)
            self.signupCell.mobileNumberTextField.text = "xxxxxxxxxxx"
            self.signupCell.passwordTextField.text = "000000"
            self.signupCell.confirmPasswordTextField.text = "000000"

            if let userImage = result.result?.ImagePath {
                self.signupCell.profileImageButton.pin_updateWithProgress = true
                if let imageUrl = URL(string: NetworkWebApisConstant.baseUrl + userImage){

                    let profileImageView = UIImageView()
                    profileImageView.pin_setImage(from: imageUrl)

                    self.signupCell.profileImageButton.setImage(profileImageView.image?.withRenderingMode(.alwaysOriginal), for: .normal)
            
                }

            }


        }) { (error) in

        }
    }
    
    
}


extension SignupController{
    
    @objc func handleSignUp(){
        
        let (isEmpty, errorMessage) = checkEmpty()
        
        if isEmpty == true{
            Alerts.shared.displaySimpleAlert(displayIn: self, title: "Waring", message: errorMessage)
        }else{
            showActivityIndicator()
            handleEditSignUp()
        }
        
    }
    
    func checkEmpty() -> (Bool, String){
        
        var message = ""
        for view in signupCell.subviews{
            
            if view is UITextField{
                
                if let getTextField = view as? UITextField{
                    if let text = getTextField.text{
                        
                        if text == ""{
                            message.append(getTextField.placeholder!)
                        }
                    }
                }
                
            }
            
            
        }
        
        if message == ""{
            return (false, "")
        }
        
        return (true, message)
    }
    
    
    func hideActivityIndicator(){
        signupCell.activityIndicator.stopAnimating()
        signupCell.signUpButton.setTitle("UPDATE PROFILE", for: .normal)
        
    }
    
    func showActivityIndicator(){
        signupCell.activityIndicator.startAnimating()
        signupCell.signUpButton.setTitle("", for: .normal)
    }
    
    @objc func handleEditSignUp(){
        
        var bodyParam = [String: String]()
        
        SaveUserDataOnLogin.shared.getUserDataFromPlist(completion: { (result) in
            
            if let userId = result.result?.ID{
                bodyParam.updateValue(String(userId), forKey: "UserId")
            }
            
            if let userName = self.signupCell.userNameTextField.text{
                
                let fullName = userName
              
             
                let fullNameArr = fullName.split {$0 == " "}.map(String.init)
                let firstName: String = fullNameArr[0]
                let lastName: String? = fullNameArr.count > 1 ? fullNameArr[1] : nil
                
                
                if let getLastName = lastName{
                    bodyParam.updateValue(firstName, forKey: "FirstName")
                    bodyParam.updateValue(getLastName, forKey: "LastName")
                }
                
            }
            
            bodyParam.updateValue("", forKey: "MobileNo")
            bodyParam.updateValue("", forKey: "Password")
            bodyParam.updateValue("", forKey: "Email")
        
            let editProfile = SignUpApiInteraction()
            editProfile.delegate = self
            
            if let getProfileImage = self.signupCell.profileImageButton.image(for: .normal){
                editProfile.registerUser(bodyParam: bodyParam, images: [getProfileImage])
                
            }
            
           
            
        }) { (error) in
            
        }
        
        
    }
    
}


extension SignupController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    @objc func handleProfile(){

    let ac = UIAlertController(title: "Select to upload Image", message: "", preferredStyle: .actionSheet)

        let firstpOtion = UIAlertAction(title: "Gallery", style: .default) { (action) in
            self.handleGallery()
        }

        let secondOption = UIAlertAction(title: "Camera", style: .default) { (action) in
            self.handleCamera()
        }

        ac.addAction(firstpOtion)
        ac.addAction(secondOption)

        present(ac, animated: true, completion: nil)

    }


    @objc func handleGallery(){
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
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
            self.signupCell.profileImageButton.setImage(pickedImage.withRenderingMode(.alwaysOriginal), for: .normal)

        }
        dismiss(animated: true, completion: nil)

    }
}




extension SignupController: EditDelegate{
    
    
    func editProfile(loginData: LoginData?, error: String?) {
        
        
        hideActivityIndicator()
        
        
        
        if let getLoginData = loginData{
            
            
            if let getMessage = error{
                
                Alerts.shared.displaySimpleAlert(displayIn: self, title: "Profile edited", message: getMessage)
                
            }
            
            
            SaveUserDataOnLogin.shared.getUserDataFromPlist(completion: { (result) in
                
                let editLoginData = LoginResultsModel()
                editLoginData.employees = result.employees
                editLoginData.result = getLoginData
                
                
                SaveUserDataOnLogin.shared.saveDataToPList(userModel: editLoginData)
                
                
                
            }) { (error) in
                
            }
            
        }else{
            
            if let getError = error{
                
                Alerts.shared.displaySimpleAlert(displayIn: self, title: "Warning", message: getError)
            }
        }
        
        
    }
    
    
    
}
