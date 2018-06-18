//
//  ViewProjectInDetailCell.swift
//  CameraApp
//
//  Created by JEEVAN TIWARI on 28/05/18.
//  Copyright © 2018 JEEVAN TIWARI. All rights reserved.
//

import UIKit


class ViewProjectDetailCell: UITableViewCell{
    
//    var parentInstance: ProjectControllerCollectionCell?
//    var projectData: ProjectListModel?{
//        didSet{
//            setup()
//        }
//    }
    var topLayout: NSLayoutConstraint!
    var bottomLayout: NSLayoutConstraint!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addViews()
        backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
    
    func addViews(){
        
        let cardView = CardView()
        cardView.backgroundColor = #colorLiteral(red: 0.4470588235, green: 0.568627451, blue: 0.9568627451, alpha: 1)
        addSubview(cardView)
        
        
        cardView.anchorWithConstantsToTop(top: nil, left: leftAnchor, bottom: nil
            , right: rightAnchor, topConstant: 16, leftConstant: 16, bottomConstant: 0, rightConstant: 16)
        
        topLayout = cardView.topAnchor.constraint(equalTo: topAnchor, constant: 0)
        topLayout.isActive = true
        
        bottomLayout = cardView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -32)
        bottomLayout.isActive = true
        
        cardView.addSubview(titleLabel)
        cardView.addSubview(startDateLabel)
        cardView.addSubview(endDateLabel)
        cardView.addSubview(createdByLabel)
        cardView.addSubview(editButton)
        
        
        titleLabel.anchorWithConstantsToTop(top: cardView.topAnchor, left: cardView.leftAnchor, bottom: nil, right: editButton.leftAnchor, topConstant: 16, leftConstant: 16, bottomConstant: 16, rightConstant: 4)
        
        startDateLabel.anchorWithConstantsToTop(top: titleLabel.bottomAnchor, left: cardView.leftAnchor, bottom: nil, right: cardView.rightAnchor, topConstant: 16, leftConstant: 16, bottomConstant: 16, rightConstant: 16)
        
        endDateLabel.anchorWithConstantsToTop(top: startDateLabel.bottomAnchor, left: cardView.leftAnchor, bottom: nil, right: cardView.rightAnchor, topConstant: 4, leftConstant: 16, bottomConstant: 16, rightConstant: 16)
        
        createdByLabel.anchorWithConstantsToTop(top: nil, left: nil, bottom: cardView.bottomAnchor, right: cardView.rightAnchor, topConstant: 16, leftConstant: 16, bottomConstant: 16, rightConstant: 16)
        
        editButton.anchorWithConstantsToTop(top: cardView.topAnchor, left: nil, bottom: nil, right: cardView.rightAnchor, topConstant: 16, leftConstant: 0, bottomConstant: 4, rightConstant: 16)
        
        editButton.heightAnchor.constraint(equalToConstant: 16).isActive = true
        editButton.widthAnchor.constraint(equalToConstant: 16).isActive = true
    }
    
//    func setup(){
//        titleLabel.text = projectData?.ProjectName
//        
//        if let startDate = projectData?.StartDate, let endDate = projectData?.EndDate{
//            
//            
//            let getStartDate = LogicHelper.shared.convertStringToDate(date: startDate)
//            let getEndDate = LogicHelper.shared.convertStringToDate(date: endDate)
//            
//            
//            
//            startDateLabel.text = "Start Date: \(LogicHelper.shared.getDate(date: getStartDate)) \(LogicHelper.shared.getMonthShort(date: getStartDate)) \(LogicHelper.shared.getYear(date: getStartDate))"
//            
//            endDateLabel.text = "End Date: \(LogicHelper.shared.getDate(date: getEndDate)) \(LogicHelper.shared.getMonthShort(date: getEndDate)) \(LogicHelper.shared.getYear(date: getEndDate))"
//            
//            
//        }
//        
//        if let createBy = projectData?.CreatedByName{
//            createdByLabel.text = "Created by: \(createBy)"
//        }
//        
//        if let userId = UserDefaults.standard.value(forKey: "userId") as? String, let secondUserId = projectData?.UserID{
//            
//            if userId == String(secondUserId){
//                editButton.isHidden = false
//            }else{
//                editButton.isHidden = true
//            }
//        }
//        
//    }
    
    @objc func handleProjectEdit(){
        //parentInstance?.handleProjectEdit(projectDataList: projectData)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        lbl.text = "THE ACCOUNTANT APP"
        return lbl
    }()
    
    let startDateLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        lbl.text = "Start Date: 18th March 2018"
        lbl.font = UIFont(name: lbl.font.fontName, size: 15)
        return lbl
    }()
    
    let endDateLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        lbl.text = "Start Date: 18th March 2018"
        lbl.font = UIFont(name: lbl.font.fontName, size: 15)
        return lbl
    }()
    
    let createdByLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        lbl.text = "Created by: Thierry Madvig"
        lbl.font = UIFont(name: lbl.font.fontName, size: 13)
        return lbl
    }()
    
    
    lazy var editButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(#imageLiteral(resourceName: "editImage").withRenderingMode(.alwaysTemplate), for: .normal)
        btn.addTarget(self, action: #selector(handleProjectEdit), for: .touchUpInside)
        btn.tintColor  = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        return btn
    }()
    
    
    
}
