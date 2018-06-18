//
//  ProfileDelegates.swift
//  CameraApp
//
//  Created by JEEVAN TIWARI on 13/04/18.
//  Copyright © 2018 JEEVAN TIWARI. All rights reserved.
//

import UIKit

extension ProfileViewController{
    
    
    func setupNavigationController(){
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: #colorLiteral(red: 0.4470588235, green: 0.568627451, blue: 0.9568627451, alpha: 1)]
        navigationItem.title = "Profile"
        
        let editProfileButton = UIBarButtonItem(title: "Edit Profile", style: .plain, target: self, action: #selector(handleEditProfile))
        editProfileButton.tintColor = .gray
        navigationItem.rightBarButtonItem = editProfileButton
    }
    
}


extension ProfileViewController: UITableViewDelegate, UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.item {
        case 0:
            navigationController?.pushViewController(GroupController(), animated: true)
        case 1:
            print("")
        case 2:
            navigationController?.pushViewController(SettingsViewController(), animated: true)
        default:
            let appDomain = Bundle.main.bundleIdentifier!
            UserDefaults.standard.removePersistentDomain(forName: appDomain)
           present(LoginController(), animated: true, completion: nil)
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 49
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
   
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileOptionCell", for: indexPath) as! ProfileOptionCell
        cell.optionTextLbl.text = ["Groups","Notifications", "Settings", "Logout"][indexPath.item]
        cell.optionImageView.image = [ #imageLiteral(resourceName: "groupImage").withRenderingMode(.alwaysTemplate),UIImage(named: "notificationImage")?.withRenderingMode(.alwaysTemplate),#imageLiteral(resourceName: "profileSettingImage").withRenderingMode(.alwaysTemplate), #imageLiteral(resourceName: "logOutImage").withRenderingMode(.alwaysTemplate)][indexPath.item]
        cell.optionImageView.tintColor = #colorLiteral(red: 0.4156862745, green: 0.5215686275, blue: 0.9647058824, alpha: 1)
        
        if indexPath.item == 0 || indexPath.item == 1{
            cell.seperatorView.isHidden = false
        }else{
            cell.seperatorView.isHidden = true
        }
        
        if indexPath.item == 1{
            cell.blueNotficationCountView.isHidden = false
        }else{
            cell.blueNotficationCountView.isHidden = true
        }
        
        
        return cell
    }
}
