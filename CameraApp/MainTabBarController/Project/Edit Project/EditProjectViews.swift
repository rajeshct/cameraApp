//
//  EditProjectViews.swift
//  CameraApp
//
//  Created by Jeevan chandra on 03/05/18.
//  Copyright © 2018 JEEVAN TIWARI. All rights reserved.
//

import UIKit

extension EditProjectTaskController{


    func addViews(){


        let dropDownImageView = UIImageView().returnTempImageView(image: #imageLiteral(resourceName: "dropDown").withRenderingMode(.alwaysTemplate))
        dropDownImageView.tintColor = .gray
        
        let currencyDropDownImageView = UIImageView().returnTempImageView(image: #imageLiteral(resourceName: "dropDown").withRenderingMode(.alwaysTemplate))
        currencyDropDownImageView.tintColor = .gray

        let startDateLbl = UILabel().tempLabel(text: "Start Date")
        let endDateLbl = UILabel().tempLabel(text: "End Date")
        let projectAssignLbl = UILabel().tempLabel(text: "Project Assign to")
        let projectBudgetLbl = UILabel().tempLabel(text: "Project Budget")
        let cardView = CardView()
        let startDateCalendarImage = UILabel().returnImage()
        let endDateCalendarImage = UILabel().returnImage()

        cardView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)

        view.addSubview(cardView)
        view.addSubview(projectNameTextField)
        view.addSubview(startDateLbl)
        view.addSubview(endDateLbl)
        view.addSubview(startDateButton)
        startDateButton.addSubview(startDateCalendarImage)

        
        
        view.addSubview(endDateButton)
        endDateButton.addSubview(endDateCalendarImage)
        view.addSubview(projectAssignLbl)
        view.addSubview(projectAssignButton)

        view.addSubview(projectBudgetLbl)
        view.addSubview(projectBudgetButton)
        view.addSubview(createProjectButton)

        projectAssignButton.addSubview(dropDownImageView)
        createProjectButton.addSubview(activityIndicator)

        view.addSubview(projectCurrencyButton)
        projectCurrencyButton.addSubview(currencyDropDownImageView)

        cardView.anchorWithConstantsToTop(top: view.topAnchor, left: view.leftAnchor, bottom: projectBudgetButton.bottomAnchor, right: view.rightAnchor, topConstant: 16, leftConstant: 16, bottomConstant: -16, rightConstant: 16)

        projectNameTextField.anchorWithConstantsToTop(top: cardView.topAnchor, left: cardView.leftAnchor, bottom: nil, right: cardView.rightAnchor, topConstant: 16, leftConstant: 16, bottomConstant: 32, rightConstant: 16)
        projectNameTextField.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.07).isActive = true

        startDateLbl.anchorWithConstantsToTop(top: projectNameTextField.bottomAnchor, left: cardView.leftAnchor, bottom: nil, right: nil, topConstant: 8, leftConstant: 16, bottomConstant: 16, rightConstant: 16)

        startDateButton.anchorWithConstantsToTop(top: startDateLbl.bottomAnchor, left: cardView.leftAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 16, bottomConstant: 16, rightConstant: 16)
        startDateButton.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.07).isActive = true
        startDateButton.widthAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width - 72)/2 ).isActive = true


        endDateLbl.anchorWithConstantsToTop(top: projectNameTextField.bottomAnchor, left: endDateButton.leftAnchor, bottom: nil, right: nil, topConstant: 8, leftConstant: 0, bottomConstant: 16, rightConstant: 16)


        endDateButton.anchorWithConstantsToTop(top: endDateLbl.bottomAnchor, left: startDateButton.rightAnchor, bottom: nil, right: cardView.rightAnchor, topConstant: 0, leftConstant: 8, bottomConstant: 0, rightConstant: 16)
        endDateButton.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.07).isActive = true


        projectAssignLbl.anchorWithConstantsToTop(top: endDateButton.bottomAnchor, left: cardView.leftAnchor, bottom: nil, right: nil, topConstant: 8, leftConstant: 16, bottomConstant: 16, rightConstant: 16)

        projectAssignButton.anchorWithConstantsToTop(top: projectAssignLbl.bottomAnchor, left: cardView.leftAnchor, bottom: nil, right: cardView.rightAnchor, topConstant: 0, leftConstant: 16, bottomConstant: 0, rightConstant: 16)
        projectAssignButton.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.07).isActive = true

        projectBudgetLbl.anchorWithConstantsToTop(top: projectAssignButton.bottomAnchor, left: cardView.leftAnchor, bottom: nil, right: nil, topConstant: 8, leftConstant: 16, bottomConstant: 16, rightConstant: 16)

        
        projectCurrencyButton.anchorWithConstantsToTop(top: projectBudgetLbl.bottomAnchor, left:  cardView.leftAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 16, bottomConstant: 0, rightConstant: 16)
        projectCurrencyButton.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.07).isActive = true
        projectCurrencyButton.widthAnchor.constraint(equalTo: cardView.widthAnchor, multiplier: 0.2).isActive = true
        
        
        
        currencyDropDownImageView.rightAnchor.constraint(equalTo: projectCurrencyButton.rightAnchor, constant: -8).isActive = true
        currencyDropDownImageView.centerYAnchor.constraint(equalTo: projectCurrencyButton.centerYAnchor).isActive = true
        currencyDropDownImageView.heightAnchor.constraint(equalTo: projectCurrencyButton.heightAnchor, multiplier: 0.25).isActive = true
        currencyDropDownImageView.widthAnchor.constraint(equalTo: projectCurrencyButton.heightAnchor, multiplier: 0.25).isActive = true
        
        
        
       
        projectBudgetButton.anchorWithConstantsToTop(top: projectBudgetLbl.bottomAnchor, left: projectCurrencyButton.rightAnchor, bottom: nil, right: cardView.rightAnchor, topConstant: 0, leftConstant: 8, bottomConstant: 0, rightConstant: 16)
        projectBudgetButton.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.07).isActive = true
        
        
        
        


        startDateCalendarImage.centerYAnchor.constraint(equalTo: startDateButton.centerYAnchor).isActive = true
        startDateCalendarImage.heightAnchor.constraint(equalTo: startDateButton.heightAnchor, multiplier: 0.4).isActive = true
        startDateCalendarImage.widthAnchor.constraint(equalTo: startDateButton.heightAnchor, multiplier: 0.4).isActive = true
        startDateCalendarImage.leftAnchor.constraint(equalTo: startDateButton.leftAnchor, constant: 0).isActive = true



        endDateCalendarImage.centerYAnchor.constraint(equalTo: startDateButton.centerYAnchor).isActive = true
        endDateCalendarImage.heightAnchor.constraint(equalTo: startDateButton.heightAnchor, multiplier: 0.4).isActive = true
        endDateCalendarImage.widthAnchor.constraint(equalTo: startDateButton.heightAnchor, multiplier: 0.4).isActive = true
        endDateCalendarImage.leftAnchor.constraint(equalTo: endDateButton.leftAnchor, constant: 0).isActive = true



        createProjectButton.anchorToTop(top: nil, left: view.leftAnchor, bottom: nil, right: view.rightAnchor)
        createProjectButton.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.07).isActive = true
        if #available(iOS 11.0, *){
            createProjectButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        }else{
            createProjectButton.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        }


        activityIndicator.centerXAnchor.constraint(equalTo: createProjectButton.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: createProjectButton.centerYAnchor).isActive = true


        dropDownImageView.rightAnchor.constraint(equalTo: projectAssignButton.rightAnchor, constant: -8).isActive = true
        dropDownImageView.centerYAnchor.constraint(equalTo: projectAssignButton.centerYAnchor).isActive = true
        dropDownImageView.heightAnchor.constraint(equalTo: projectAssignButton.heightAnchor, multiplier: 0.25).isActive = true
        dropDownImageView.widthAnchor.constraint(equalTo: projectAssignButton.heightAnchor, multiplier: 0.25).isActive = true




    }
    
}
