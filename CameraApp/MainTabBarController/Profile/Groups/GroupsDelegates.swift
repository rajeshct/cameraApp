//
//  GroupsDelegates.swift
//  CameraApp
//
//  Created by JEEVAN TIWARI on 24/04/18.
//  Copyright © 2018 JEEVAN TIWARI. All rights reserved.
//

import UIKit

extension GroupController{
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return groupSectionData.count
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let groupChatObj = GroupChatController()
        groupChatObj.subGroupData = groupDataModel?[indexPath.section].SubGroup?[indexPath.item]
        navigationController?.pushViewController(groupChatObj, animated: true)
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) ->
        Int {
        
            return groupSectionData[section].collapsed ? 0 : groupSectionData[section].items.count
        
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as? CollapsibleTableViewHeader ?? CollapsibleTableViewHeader(reuseIdentifier: "header")
        
        header.titleLabel.text = groupSectionData[section].ProjectName
        header.arrowLabel.text = ">"
        header.setCollapsed(groupSectionData[section].collapsed)
        header.subGroupCount = groupSectionData[section].items.count
        header.section = section
        header.delegate = self
        if groupSectionData[section].items.count == 0 {
            header.totalGroups.isHidden = true
        }else{
            header.totalGroups.isHidden = false
        }
        
        
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if groupSectionData[section].items.count == 0 {
            return 49
        }
        
        return 49 + 49
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 49//UIScreen.main.bounds.height * 0.07
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupsCell", for: indexPath) as! GroupsCell
        cell.optionText.text = groupSectionData[indexPath.section].items[indexPath.item].SubGroupName
        return cell
    }
}


extension GroupController: GetGroupDelegate{
    func getGroupData(data: [GroupDataModel]?, error: String?) {
        
        view.removeActivityIndicator(activityIndicator: activityIndicator)
        
        if let getError = error{
                Alerts.shared.displaySimpleAlert(displayIn: self, title: "Warning", message: getError)
        }else{
            groupDataModel = data
            setData()
           // tableView.reloadData()
        }
        
        
        
    }
    
    func setData(){
        
        
        if let groupData = groupDataModel{
            
            for index in groupData{
                
                var sectionGroupData = [Item]()
                
                if let subGroupData = index.SubGroup{
                    
                    for subGroupIndex in subGroupData{
                        
                        let itemData = Item(CreateDate: subGroupIndex.CreateDate, GroupId: subGroupIndex.GroupId, ModifiedDate: subGroupIndex.ModifiedDate, SubGroupDescription: subGroupIndex.SubGroupDescription, SubGroupId: subGroupIndex.SubGroupId, SubGroupMembers: subGroupIndex.SubGroupMembers, SubGroupName: subGroupIndex.SubGroupName, UserId: subGroupIndex.UserId, status: subGroupIndex.status)
                        
                        sectionGroupData.append(itemData)
                    }
                }
                
                
                let sectionData = Section(ProjectID: index.ProjectID, ProjectName: index.ProjectName, StartDate: index.StartDate, EndDate: index.EndDate, ProjectAssignTo: index.ProjectAssignTo, ProjectBudGet: index.ProjectBudGet, ModifiedDate: index.ModifiedDate, Status: index.Status, UserID: index.UserID, CompanyId: index.CompanyId, Description: index.Description, CreatedByName: index.CreatedByName, CreateDate: index.CreateDate, items: sectionGroupData)
                
                
                groupSectionData.append(sectionData)
               
                
                
            }
        }
        
        tableView.reloadData()
        
        
    }
    
    
    
    
    func getGroupList(){
        view.showActivityIndicator(activityIndicator: activityIndicator)
        
        SaveUserDataOnLogin.shared.getUserDataFromPlist(completion: { (result) in
            
            if let companyId = result.result?.CompanyId{
                let groupList = GroupApiInterataction()
                groupList.delegate = self
                groupList.getGroupList(companyId: String(companyId))
            }
            
            
            
        }) { (error) in
            
        }
        
        
        
        
        
    }
    
    
    func getGroupAssignIds(){
        
        
        SaveUserDataOnLogin.shared.getUserDataFromPlist(completion: { (result) in
          
            if let companyId = result.result?.CompanyId{
                 let url = NetworkWebApisConstant.baseUrl + NetworkWebApisConstant.LoginController.getAssignIds + "/\(companyId)"
                
                Networking.shared.httpGenericGetRequest(url: url, bodyParameter: [:], header: url.getBodyHeader(), dataIn: { (assignIds: EmployeeAssignModel) in
                    
                    result.employees = assignIds.data
                    
                    SaveUserDataOnLogin.shared.saveDataToPList(userModel: result)
                    
                }, errorIn: { (error) in
                    
                    
                })
            }
            
           
            
            
        }) { (error) in
            
        }
        
        
        
        
    }
}
