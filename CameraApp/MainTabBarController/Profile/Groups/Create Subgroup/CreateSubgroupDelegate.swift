//
//  CreateSubgroupDelegate.swift
//  CameraApp
//
//  Created by JEEVAN TIWARI on 6/10/18.
//  Copyright © 2018 JEEVAN TIWARI. All rights reserved.
//

import UIKit

extension CreateSubgroupController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employeeSearchList?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 49
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectAssignCell", for: indexPath) as! ProjectAssignCell
        cell.currencyLabel.text = UILabel().getFullName(firstName: employeeSearchList?[indexPath.item].FirstName, lastName: employeeSearchList?[indexPath.item].LastName)
        return cell
    }
}


extension CreateSubgroupController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as? ProjectAssignCell
        cell?.checkedImge.image = #imageLiteral(resourceName: "checkedImage").withRenderingMode(.alwaysTemplate)
        cell?.checkedImge.tintColor = #colorLiteral(red: 0.4470588235, green: 0.568627451, blue: 0.9568627451, alpha: 1)
        
        
        if let assignId = employeeList?[indexPath.item].ID{
            assignIds.updateValue(assignId, forKey: String(indexPath.item))
        }
        
        setInsearchEmployee()
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! ProjectAssignCell
        cell.checkedImge.image = #imageLiteral(resourceName: "UncheckImage").withRenderingMode(.alwaysTemplate)
        cell.checkedImge.tintColor = #colorLiteral(red: 0.4470588235, green: 0.568627451, blue: 0.9568627451, alpha: 1)
        assignIds.removeValue(forKey: String(indexPath.item))
        setInsearchEmployee()
        
    }
    
    
    func setInsearchEmployee(){
        
         var name = ""
        for (_, value) in assignIds{
            
           
            if let employeesList = employeeList{
                
                
                for index in employeesList{
                    
                    if index.ID == value{
                        
                        name = name + UILabel().getFullName(firstName: index.FirstName, lastName: index.LastName) + " ,"
                    }
                }
                
                
            }
            
            
           
            
        }
        
        if assignIds.count == 1 {
            name.removeLast()
            
        }
        
        
        
        searchNameTextField.text = name
        
    }
    
    
}


extension CreateSubgroupController: UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        if textField == searchNameTextField{
        
        
        if let assignText = textField.text{
            
            employeeSearchList = (textField.text?.isEmpty)! ? employeeList : employeeSearchList?.filter({ (hotel) -> Bool in
                return hotel.FirstName?.range(of: assignText, options: .caseInsensitive) != nil
            })
            
        }else{
            employeeSearchList = employeeList
        }
        
        
        
        createSubGroup.reloadData()
            
        }
        
        return true
        
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == groupNameTextField{
            searchNameTextField.becomeFirstResponder()
        }else{
            hideKeyboard()
        }
    
        return true
    }
    
   @objc func hideKeyboard(){
        searchNameTextField.resignFirstResponder()
        groupNameTextField.resignFirstResponder()
    }

}


extension CreateSubgroupController{
    
    func setValues(){
        subGroupName.text = groupData?.ProjectName
    }
    
    
    @objc func createSubGroupServer(){
        
        
        SaveUserDataOnLogin.shared.getUserDataFromPlist(completion: { (result) in
            
            
            var serverBody = [String: String]()
            
            if let subGroupName =  self.groupNameTextField.text{
                
                serverBody.updateValue(subGroupName, forKey: "SubGroupName")
            }
            
            
            if let userId = result.result?.ID{
                
                serverBody.updateValue(String(userId), forKey: "UserId")
                
            }
            
            
            if let groupId = self.groupData?.ProjectID{
                serverBody.updateValue(String(groupId), forKey: "GroupId")
            }
            
            serverBody.updateValue("", forKey: "SubGroupDescription")
            
            
            var subGroupMember = ""
            
            for (_, value) in self.assignIds{
                
                subGroupMember.append(String(value) + ",")
                
            }
            
            subGroupMember.removeLast()
            
            
            
            serverBody.updateValue(subGroupMember, forKey: "SubGroupMember")
            
            
            self.callServer(bodyParam: serverBody)
            
            
            
            
            
        }) { (error) in
            
        }
        
    
        
    }
    
    
    func callServer(bodyParam: [String: String]){
        
        
        let url = NetworkWebApisConstant.baseUrl + NetworkWebApisConstant.GroupsControllerApi.createSubGroup
        
        
        Networking.shared.httpGenericPostRequest(url: url, bodyParameter: bodyParam, header: url.getBodyHeader(), dataIn: { (response: CreateSubGroupModel) in
            
            if response.error == false{
                
                if let getMessage = response.message{
                     Alerts.shared.displaySimpleAlert(displayIn: self, title: "Sub Group Created", message: getMessage)
                }
               
                
            }else{
                
                if let getMessage = response.message{
                    Alerts.shared.displaySimpleAlert(displayIn: self, title: "Something went wrong", message: getMessage)
                }
                
            }
        }) { (error) in
            
        }
        
    }
    
}
