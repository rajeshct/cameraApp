//
//  CreateSubgroupViews.swift
//  CameraApp
//
//  Created by JEEVAN TIWARI on 6/10/18.
//  Copyright © 2018 JEEVAN TIWARI. All rights reserved.
//

import UIKit

extension CreateSubgroupController{
    
    func addViews(){
        
        
        let groupNameLabel = UILabel().tempLabel(text: "Subgroup Name")
        let addMembersLabel = UILabel().tempLabel(text: "Add Members")
        
        
        
        let cardView = CardView()
        cardView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        view.addSubview(cardView)
        view.addSubview(createSubGroup)
        view.addSubview(createButton)
        
        
        
        cardView.addSubview(subGroupName)
        cardView.addSubview(groupNameLabel)
        cardView.addSubview(addMembersLabel)
        cardView.addSubview(groupNameTextField)
        cardView.addSubview(searchNameTextField)
        cardView.addSubview(createSubGroup)
        
        
        if #available(iOS 11.0, *){
            
            createButton.anchorToTop(top: nil, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor)
            
            
        }else{
            createButton.anchorToTop(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        }
        
        createButton.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.07).isActive = true
        
        cardView.anchorWithConstantsToTop(top: view.topAnchor, left: view.leftAnchor, bottom: createButton.topAnchor, right: view.rightAnchor, topConstant: 16, leftConstant: 16, bottomConstant: -10, rightConstant: 16)
        
        
        
        subGroupName.anchorWithConstantsToTop(top: cardView.topAnchor, left: cardView.leftAnchor, bottom: nil, right: cardView.rightAnchor, topConstant: 16, leftConstant: 16, bottomConstant: 16, rightConstant: 16)
        
        
        groupNameLabel.anchorWithConstantsToTop(top: subGroupName.bottomAnchor, left: cardView.leftAnchor, bottom: nil, right: cardView.rightAnchor, topConstant: 16, leftConstant: 16, bottomConstant: 16, rightConstant: 16)
        
        
        groupNameTextField.anchorWithConstantsToTop(top: groupNameLabel.bottomAnchor, left: cardView.leftAnchor, bottom: nil, right: cardView.rightAnchor, topConstant: 8, leftConstant: 16, bottomConstant: 16, rightConstant: 16)
        
        
        addMembersLabel.anchorWithConstantsToTop(top: groupNameTextField.bottomAnchor, left: cardView.leftAnchor, bottom: nil, right: cardView.rightAnchor, topConstant: 16, leftConstant: 16, bottomConstant: 16, rightConstant: 16)
        
        
         searchNameTextField.anchorWithConstantsToTop(top: addMembersLabel.bottomAnchor, left: cardView.leftAnchor, bottom: nil, right: cardView.rightAnchor, topConstant: 8, leftConstant: 16, bottomConstant: 16, rightConstant: 16)
        
        
        createSubGroup.anchorWithConstantsToTop(top: searchNameTextField.bottomAnchor, left: cardView.leftAnchor, bottom: createButton.topAnchor, right: cardView.rightAnchor, topConstant: 16, leftConstant: 0, bottomConstant: 16, rightConstant: 0)
        
        
        
    }
    
    func setupController(){
        
        navigationItem.title  = "Create Subgroup"
        
        SaveUserDataOnLogin.shared.getUserDataFromPlist(completion: { (result) in
            
            self.employeeList = result.employees
            self.createSubGroup.reloadData()
            
        }) { (error) in
            
        }
        
    }
}
