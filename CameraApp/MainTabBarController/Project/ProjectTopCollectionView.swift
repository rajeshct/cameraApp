//
//  SelectedHotelCollectionView.swift
//  NewMontCalm
//
//  Created by Jeevan chandra on 04/08/17.
//  Copyright © 2017 Jeevan chandra. All rights reserved.
//

import UIKit

extension ProjectControllerCollectionCell: UICollectionViewDataSource, UICollectionViewDelegate{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
        if let count = projectData?.count{
            if count > 5{
                return 6
            }else{
                return count
            }
        }
        return  0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        if indexPath.item == 5{
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProjectLoadMoreCell", for: indexPath)  as! ProjectLoadMoreCell
            return cell
        }
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectedHotelCell", for: indexPath)  as! SelectedHotelCell
        cell.parentInstance = projectControllerInstance
        cell.projectData = projectData?[indexPath.item]
        
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == 5{
            projectControllerInstance?.loadMoreProjects()
            
        }
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
       
        print("Iphone ", targetContentOffset.pointee.x , UIScreen.main.bounds.width)
        
        
        
        let cellNumber = Int(Int(targetContentOffset.pointee.x) / Int(LogicHelper.shared.returnStandardCellSize()))
        
        
        if let projects = projectData{
            
            if cellNumber < projects.count{
                
                if let projectId = projectData?[cellNumber].ProjectID{
                    
                    projectControllerInstance?.onScrollProject(dateArray: projectData?[cellNumber].projectTasks, index: projectId)
                    projectControllerInstance?.onScrollProjectTask(list: projectData?[cellNumber].projectTasks)
                }
                
            }
        }
        
        
        
        
    }
       
}



class SelectedHotelCollectionView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate{
    
    var projectControllerInstance: ProjectController?
    
    var projectData: [ProjectListModel]?{
        
        didSet{
            self.reloadData()
        }
    }
    
    var newPage1 = 0
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return  projectData?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectedHotelCell", for: indexPath)  as! SelectedHotelCell
//        cell.parentInstance = self
       cell.projectData = projectData?[indexPath.item]

        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 64 , height: 200 - 32)//(UIScreen.main.bounds.width - 32) * 9 / 16 - 32)
    }
    
    
    
    
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let pageWidth = Float(UIScreen.main.bounds.width - 64 + 10 )                                                    //Float(itemWidth + itemSpacing)
        let targetXContentOffset = Float(targetContentOffset.pointee.x)
        let contentWidth = Float(self.contentSize.width)                                                                           //Float(collectionView!.contentSize.width  )
        var newPage = Float(newPage1)
        
        if velocity.x == 0 {
            newPage = floor( (targetXContentOffset - Float(pageWidth) / 2) / Float(pageWidth)) + 1.0
            
            print("if x == 0 ", newPage)
        } else {
            newPage = Float(velocity.x > 0 ? newPage1 + 1 : newPage1 - 1)
            if newPage < 0 {
                newPage = 0
            }
            if (newPage > contentWidth / pageWidth) {
                newPage = ceil(contentWidth / pageWidth) - 1.0
            }
        }
        
        
        // parentController?.handleCoordinateChanges(index: newPage1)
        newPage1 = Int(newPage)
      //  parentInstance?.handleMapAdjustment(hotelValue: newPage1)
        
        print("Value is", newPage1)
        
        
        if let projects = projectData{
            
            if newPage1 < projects.count{
                
                if let projectId = projectData?[newPage1].ProjectID{
                  
                    projectControllerInstance?.onScrollProject(dateArray: projectData?[newPage1].projectTasks, index: projectId)
                    projectControllerInstance?.onScrollProjectTask(list: projectData?[newPage1].projectTasks)
                }
                
            }
        }
        
        let point = CGPoint (x: CGFloat(newPage * pageWidth), y: targetContentOffset.pointee.y)
        targetContentOffset.pointee = point



        // animation

        let index = IndexPath(item: newPage1, section: 0)
        let mainCell = self.cellForItem(at: index) as? SelectedHotelCell


        UIView.animate(withDuration: 0.4, animations: {
            mainCell?.topLayout.constant = 0
            mainCell?.bottomLayout.constant = -32
            self.layoutIfNeeded()
        })



        if newPage1 == 0 || newPage1 == projectData?.count ?? 0 || newPage1 == (projectData?.count)! + 1  {
            if newPage1 == 0{
                let index = IndexPath(item: newPage1 + 1, section: 0)
                let cell = self.cellForItem(at: index) as? SelectedHotelCell

                UIView.animate(withDuration: 0.4, animations: {
                    cell?.topLayout.constant = 32
                    cell?.bottomLayout.constant = 0
                    self.layoutIfNeeded()
                })


            }else if newPage1 == 9{
                let index = IndexPath(item: newPage1 - 1, section: 0)
                let cell = self.cellForItem(at: index) as? SelectedHotelCell
                UIView.animate(withDuration: 0.4, animations: {
                    cell?.topLayout.constant = 32
                    cell?.bottomLayout.constant = 0
                    self.layoutIfNeeded()

                })

            }else{
                let index = IndexPath(item: newPage1 - 1, section: 0)
                let mainCell = self.cellForItem(at: index) as? SelectedHotelCell
                UIView.animate(withDuration: 0.4, animations: {
                    mainCell?.topLayout.constant = 0
                    mainCell?.bottomLayout.constant = -32
                    self.layoutIfNeeded()
                })

            }
        }else {
            let index = IndexPath(item: newPage1 + 1, section: 0)
            let index1 = IndexPath(item: newPage1 - 1, section: 0)
            let cell = self.cellForItem(at: index) as? SelectedHotelCell
            let cell1 = self.cellForItem(at: index1) as? SelectedHotelCell

            UIView.animate(withDuration: 0.4, animations: {
                cell?.topLayout.constant = 32
                cell1?.topLayout.constant = 32

                cell1?.bottomLayout.constant = 0
                cell?.bottomLayout.constant = 0
                self.layoutIfNeeded()
            })


        }
    
        
        
    }
    
    
    
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        setup()
    
    }
    
    
    func handleProjectEdit(projectDataList: ProjectListModel?){
        projectControllerInstance?.handleProjectEdit(projectDataList: projectDataList)
    }
    
    
    
    func setup(){
        //self.isScrollEnabled = false
        self.showsHorizontalScrollIndicator = false
        self.decelerationRate = UIScrollViewDecelerationRateFast
        translatesAutoresizingMaskIntoConstraints = false
        self.register(SelectedHotelCell.self, forCellWithReuseIdentifier: "SelectedHotelCell")
        // self.isPagingEnabled = true
        backgroundColor = .clear
        delegate = self
        dataSource = self
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class SelectedHotelCell: UICollectionViewCell{
    
    var parentInstance: ProjectController?
    var projectData: ProjectListModel?{
        didSet{
            setup()
        }
    }
    var topLayout: NSLayoutConstraint!
    var bottomLayout: NSLayoutConstraint!

    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
       
    }
    
    func addViews(){
        
        let cardView = CardView()
        cardView.backgroundColor = #colorLiteral(red: 0.4470588235, green: 0.568627451, blue: 0.9568627451, alpha: 1)
        addSubview(cardView)


        cardView.anchorWithConstantsToTop(top: nil, left: leftAnchor, bottom: nil
            , right: rightAnchor, topConstant: 16, leftConstant: 0, bottomConstant: 0, rightConstant: 0)

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

    func setup(){
        titleLabel.text = projectData?.ProjectName

        if let startDate = projectData?.StartDate, let endDate = projectData?.EndDate{


            let getStartDate = LogicHelper.shared.convertStringToDate(date: startDate)
            let getEndDate = LogicHelper.shared.convertStringToDate(date: endDate)



            startDateLabel.text = "Start Date: \(LogicHelper.shared.getDate(date: getStartDate)) \(LogicHelper.shared.getMonthShort(date: getStartDate)) \(LogicHelper.shared.getYear(date: getStartDate))"

            endDateLabel.text = "End Date: \(LogicHelper.shared.getDate(date: getEndDate)) \(LogicHelper.shared.getMonthShort(date: getEndDate)) \(LogicHelper.shared.getYear(date: getEndDate))"


        }

        if let createBy = projectData?.CreatedByName{
            createdByLabel.text = "Created by: \(createBy)"
        }

        if let userId = UserDefaults.standard.value(forKey: "userId") as? String, let secondUserId = projectData?.UserID{

            if userId == String(secondUserId){
                editButton.isHidden = false
            }else{
                editButton.isHidden = true
            }
        }

    }
    
    @objc func handleProjectEdit(){
        parentInstance?.handleProjectEdit(projectDataList: projectData)
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

