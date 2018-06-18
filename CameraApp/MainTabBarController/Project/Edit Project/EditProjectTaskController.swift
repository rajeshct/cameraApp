//
//   createProjectController.swift
//  DemoApp
//
//  Created by Jeevan chandra on 13/04/18.
//  Copyright © 2018 Jeevan chandra. All rights reserved.
//

import UIKit

class EditProjectTaskController: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addViews()
        setupNavigationController()
    }
    
    func addViews(){
        
        
        let startDateLbl = UILabel().tempLabel(text: "Start Date")
        let endDateLbl = UILabel().tempLabel(text: "End Date")
        let projectAssignLbl = UILabel().tempLabel(text: "Project Assign to")
        let projectBudgetLbl = UILabel().tempLabel(text: "Project Budget")
        let cardView = CardView()
        cardView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        view.addSubview(cardView)
        view.addSubview(projectNameTextField)
        view.addSubview(startDateLbl)
        view.addSubview(endDateLbl)
        view.addSubview(startDateButton)
        view.addSubview(endDateButton)
        
        view.addSubview(projectAssignLbl)
        view.addSubview(projectAssignButton)
        
        view.addSubview(projectBudgetLbl)
        view.addSubview(projectBudgetButton)
        
        
        
        
        
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
        
        projectBudgetButton.anchorWithConstantsToTop(top: projectBudgetLbl.bottomAnchor, left: cardView.leftAnchor, bottom: nil, right: cardView.rightAnchor, topConstant: 0, leftConstant: 16, bottomConstant: 0, rightConstant: 16)
        projectBudgetButton.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.07).isActive = true
        
        
        
        
        
    }
    
    func setupNavigationController(){
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: #colorLiteral(red: 0.4470588235, green: 0.568627451, blue: 0.9568627451, alpha: 1)]
        navigationItem.title = "Profile"
    }
    
    let projectNameTextField: UITextField = {
        let tf  = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Project Name"
        tf.borderStyle = .none
        tf.layer.backgroundColor = UIColor.white.cgColor
        tf.layer.masksToBounds = false
        tf.layer.shadowColor = UIColor.lightGray.cgColor
        tf.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        tf.layer.shadowOpacity = 1.0
        tf.layer.shadowRadius = 0.0
        return tf
    }()
    
    let profileNameLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Jeevan Chandra"
        lbl.textColor = .blue
        lbl.textAlignment = .center
        return lbl
    }()
    
    let startDateButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("DD/MM/YYYY", for: .normal)
        btn.contentHorizontalAlignment = .left
        btn.layer.backgroundColor = UIColor.white.cgColor
        btn.layer.masksToBounds = false
        btn.imageView?.contentMode = .scaleAspectFit
        btn.layer.shadowColor = UIColor.lightGray.cgColor
        btn.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        btn.layer.shadowOpacity = 1.0
        btn.layer.shadowRadius = 0.0
        return btn
    }()
    
    
    let endDateButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("DD/MM/YYYY", for: .normal)
        btn.contentHorizontalAlignment = .left
        btn.imageView?.contentMode = .scaleAspectFit
        btn.layer.backgroundColor = UIColor.white.cgColor
        btn.layer.masksToBounds = false
        btn.layer.shadowColor = UIColor.lightGray.cgColor
        btn.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        btn.layer.shadowOpacity = 1.0
        btn.layer.shadowRadius = 0.0
        return btn
    }()
    
    let projectAssignButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Select", for: .normal)
        btn.contentHorizontalAlignment = .left
        btn.layer.backgroundColor = UIColor.white.cgColor
        btn.layer.masksToBounds = false
        btn.layer.shadowColor = UIColor.lightGray.cgColor
        btn.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        btn.layer.shadowOpacity = 1.0
        btn.layer.shadowRadius = 0.0
        return btn
    }()
    
    
    
    let projectBudgetButton: UITextField = {
        let tf  = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "$0.0"
        tf.borderStyle = .none
        tf.layer.backgroundColor = UIColor.white.cgColor
        tf.layer.masksToBounds = false
        tf.layer.shadowColor = UIColor.lightGray.cgColor
        tf.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        tf.layer.shadowOpacity = 1.0
        tf.layer.shadowRadius = 0.0
        return tf
    }()
    
}


extension UILabel {
    func tempLabel(text: String) -> UILabel{
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = text
        lbl.font = UIFont(name: lbl.font.fontName, size: 12)
        return lbl
    }
}
