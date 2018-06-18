//
//  ViewController.swift
//  DemoApp
//
//  Created by Jeevan chandra on 13/04/18.
//  Copyright © 2018 Jeevan chandra. All rights reserved.
//

import UIKit
import PINRemoteImage
import PINCache


class ProfileViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        setupNavigationController()
        addViews()
    
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "Profile"
        tabBarController?.tabBar.isHidden = false
        prefillValues()
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = false
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationItem.title = ""
       // tabBarController?.tabBar.isHidden = true
    }
    
    
    
    func addViews(){
        
        view.addSubview(profileImageView)
        view.addSubview(profileNameLbl)
        view.addSubview(profileOptionTableView)
        
        profileImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 16).isActive = true
        profileImageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3).isActive = true
        profileImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3).isActive = true
        profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        
        profileNameLbl.anchorWithConstantsToTop(top: profileImageView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 16, leftConstant: 16, bottomConstant: 16, rightConstant: 16)
        
        
        profileOptionTableView.anchorWithConstantsToTop(top: profileNameLbl.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 24, leftConstant: 0, bottomConstant: 16, rightConstant: 0)
        
        
        
    }
    
    func prefillValues(){
        
        SaveUserDataOnLogin.shared.getUserDataFromPlist(completion: { (result) in
            
            self.profileNameLbl.text = self.profileNameLbl.getFullName(firstName: result.result?.FirstName, lastName: result.result?.LastName)
            
            if let userImage = result.result?.ImagePath {
                self.profileImageView.pin_updateWithProgress = true
                if let imageUrl = URL(string: NetworkWebApisConstant.baseUrl + userImage){
                    

                    
                    let cacheKey = PINRemoteImageManager.shared().cacheKey(for: imageUrl, processorKey: nil)
                    PINRemoteImageManager.shared().cache.removeObject(forKey: cacheKey)
                    self.profileImageView.pin_setImage(from: imageUrl)
                }
                
            }else{
                self.profileImageView.image =  #imageLiteral(resourceName: "userPlaceHolderImage")
            }
            
            
        }) { (error) in
            
        }
    }
    
   
    
    
    @objc func handleEditProfile(){
        let editProfile = SignupController()
        editProfile.screenType = SignUpEdit.EDIT
        navigationController?.pushViewController(editProfile, animated: true)
    }
    
    
    let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = #imageLiteral(resourceName: "userPlaceHolderImage")
        iv.layer.cornerRadius = UIScreen.main.bounds.width * 0.3 / 2
        iv.clipsToBounds = true
        return iv
    }()
    
    let profileNameLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Jeevan Chandra"
        lbl.textColor = #colorLiteral(red: 0.4470588235, green: 0.568627451, blue: 0.9568627451, alpha: 1)
        lbl.textAlignment = .center
        return lbl
    }()
    
    lazy var profileOptionTableView: UITableView = {
        let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.register(ProfileOptionCell.self, forCellReuseIdentifier: "ProfileOptionCell")
        tv.isScrollEnabled = false
        tv.tableFooterView = UIView()
       // tv.separatorStyle = .none
        return tv
    }()
    
    
}


