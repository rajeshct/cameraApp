//
//  AddTimeViews.swift
//  CameraApp
//
//  Created by JEEVAN TIWARI on 08/04/18.
//  Copyright © 2018 JEEVAN TIWARI. All rights reserved.
//

import UIKit


extension AddTimeController{
    
    
    func initialization(){

        taskView.buttonName.text = "Task"
        taskView.descriptionText.placeholder = "Write task"
        durationInHoursView.buttonName.text = "Duration"
        durationInMinutesView.buttonName.text = ""
        descriptionView.buttonName.text = "Description"
        
        taskDate.buttonName.text = "Task date"
        taskDate.dropDownImageView.image = #imageLiteral(resourceName: "calendarImage")
        taskDate.selectButton.setTitle("DD/MM/YY", for: .normal)
        durationInMinutesView.selectButton.setTitle("Select Mins", for: .normal)
        durationInHoursView.selectButton.setTitle("Select Hrs", for: .normal)
        
        
        if let projectList = projectTask{
            if let projectHours = projectList.Hours{
                durationInHoursView.selectButton.setTitle(String(projectHours), for: .normal)
            }
            
            if let projectMinutes = projectList.Minutes{
                durationInMinutesView.selectButton.setTitle(String(projectMinutes), for: .normal)
            }
        }
        
        if let projectName = projectDetails{
            projectView.selectButton.setTitle(projectName.ProjectName, for: .normal)
        }
        
        if let createdDate = projectTask?.CreateDate{
            
            taskCreatedDate = createdDate
            let date = LogicHelper.shared.convertStringToDate(date: createdDate)
            taskDate.selectButton.setTitle(LogicHelper.shared.convertDateToServerFormat(date: date), for: .normal)
        }
       
        
        descriptionView.selectButton.setTitle("Write Description", for: .normal)
        
        projectView.descriptionText.isHidden = true
        taskView.selectButton.isHidden = true
        durationInHoursView.descriptionText.isHidden = true
        durationInMinutesView.descriptionText.isHidden = true
        descriptionView.selectButton.isHidden = true
        
        taskView.descriptionText.delegate = self
        descriptionView.descriptionText.delegate = self
        
        
        taskDate.descriptionText.isHidden = true
        
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tapGesture)
        
        
        projectView.selectButton.addTarget(self, action: #selector(handleProjectSelection), for: .touchUpInside)
        
        durationInHoursView.selectButton.addTarget(self, action: #selector(handleHours), for: .touchUpInside)
        
        durationInMinutesView.selectButton.addTarget(self, action: #selector(handleMinute), for: .touchUpInside)
        
        taskDate.selectButton.addTarget(self, action: #selector(handleTaskdate), for: .touchUpInside)
        
        
    }
    
    @objc func handleTap(){
        taskView.descriptionText.resignFirstResponder()
        descriptionView.descriptionText.resignFirstResponder()
    }
    
    
    func addViews(){
        
        
        
        let cardView = CardView()
        cardView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        
        view.addSubview(cardView)
        view.addSubview(projectView)
        view.addSubview(taskView)
        view.addSubview(durationInHoursView)
        view.addSubview(durationInMinutesView)
        view.addSubview(descriptionView)
        view.addSubview(saveButton)
        view.addSubview(taskDate)
        saveButton.addSubview(activityIndicator)
        
        
        
        cardView.anchorWithConstantsToTop(top: view.topAnchor, left: view.leftAnchor, bottom: descriptionView.bottomAnchor, right: view.rightAnchor, topConstant: 16, leftConstant: 24, bottomConstant: -16, rightConstant: 24)
      //  cardView.heightAnchor.constraint(equalToConstant: (UIScreen.main.bounds.height * 0.055 + 17) * 5 + 16).isActive = true
        
        
        projectView.anchorWithConstantsToTop(top: cardView.topAnchor, left: cardView.leftAnchor, bottom: nil, right: cardView.rightAnchor, topConstant: 16, leftConstant: 0, bottomConstant: 0, rightConstant: 0 )
       // projectView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.055 + 17).isActive = true
        
        
        
        
       
        
        taskView.anchorWithConstantsToTop(top: projectView.bottomAnchor, left: cardView.leftAnchor, bottom: nil, right: cardView.rightAnchor, topConstant: 16, leftConstant: 0, bottomConstant: 0, rightConstant: 0 )
      //  taskView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.055 + 17).isActive = true
        
         taskDate.anchorWithConstantsToTop(top: taskView.bottomAnchor, left: cardView.leftAnchor, bottom: nil, right: cardView.rightAnchor, topConstant: 16, leftConstant: 0, bottomConstant: 0, rightConstant: 0 )
        
        durationInHoursView.anchorWithConstantsToTop(top: taskDate.bottomAnchor, left: cardView.leftAnchor, bottom: descriptionView.topAnchor, right: nil, topConstant: 16, leftConstant: 0, bottomConstant: 16, rightConstant: 0 )
        
         durationInHoursView.widthAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width - 48) / 2 ).isActive = true
      //  durationInHoursView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.055 + 17).isActive = true
       
        
        durationInMinutesView.anchorWithConstantsToTop(top: taskView.bottomAnchor, left: durationInHoursView.rightAnchor, bottom: nil, right: cardView.rightAnchor, topConstant: 16, leftConstant: 0, bottomConstant: 0, rightConstant: 0 )
       // durationInMinutesView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.055 + 17).isActive = true
        
      
        descriptionView.anchorWithConstantsToTop(top: durationInMinutesView.bottomAnchor, left: cardView.leftAnchor, bottom: nil, right: cardView.rightAnchor, topConstant: 16, leftConstant: 0, bottomConstant: 0, rightConstant: 0 )
      //  descriptionView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.055 + 17).isActive = true
        
        
        
        saveButton.anchorToTop(top: nil, left: view.leftAnchor, bottom: nil, right: view.rightAnchor)
        saveButton.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.07).isActive = true
        if #available(iOS 11.0, *){
            saveButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        }else{
             saveButton.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        }


        activityIndicator.centerXAnchor.constraint(equalTo: saveButton.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: saveButton.centerYAnchor).isActive = true
        
    }
}
