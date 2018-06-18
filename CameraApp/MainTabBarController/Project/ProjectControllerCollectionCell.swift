//
//  ProjectControllerCollectionCell.swift
//  CameraApp
//
//  Created by JEEVAN TIWARI on 09/04/18.
//  Copyright © 2018 JEEVAN TIWARI. All rights reserved.
//

import UIKit
import UPCarouselFlowLayout

class ProjectControllerCollectionCell: UITableViewCell {
    
    var projectData: [ProjectListModel]?{
        didSet{
           projectCollectionView.reloadData()
        }
    }
    
    var projectControllerInstance: ProjectController?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addViews()
        selectionStyle =  .none
        
    }
    
    func addViews(){
        addSubview(projectCollectionView)
        projectCollectionView.anchorToTop(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    lazy var projectCollectionView: UICollectionView = {
        let layout = UPCarouselFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.spacingMode = .overlap(visibleOffset: 8)
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 32, height: 200)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(SelectedHotelCell.self, forCellWithReuseIdentifier: "SelectedHotelCell")
        cv.register(ProjectLoadMoreCell.self, forCellWithReuseIdentifier: "ProjectLoadMoreCell")
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.dataSource = self
        cv.delegate = self
        cv.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()
}


class ProjectDateCollectionCell: UITableViewCell {

    var delegate: ProjectController?
    var projectDates: [ProjectTaskDateListModel]?{
        didSet{
            setData()
        }
    }
    
    var allProjectsDelegate: ViewProjectInDetails?
    var currentProject = 0 
    var projectTaskDates: [ProjectTaskDateListModel]?{
        didSet{
            projectDateCollectionView.reloadData()
            if let projectTasks = projectTaskDates{
                if projectTasks.count > 0 {
                    collectionView(projectDateCollectionView, didSelectItemAt: IndexPath(item: 0, section: 0))
                    projectDateCollectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: .bottom)
                }
            }
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        if let project = projectDates{
            if project.count > 0 {
                collectionView(projectDateCollectionView, didSelectItemAt: IndexPath(item: 0, section: 0))
                projectDateCollectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: .bottom)
            }
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addViews()
        selectionStyle =  .none
    }


    func setData(){

        
        if let project = projectDates{
            let taskDates = project.sorted{
                $0.TaskDate ?? 0 < $1.TaskDate ?? 0
            }
            projectTaskDates = taskDates
        }
        
       
       
        if projectDates == nil {
            previousButton.isHidden = true
            nextButton.isHidden = true
        }


        if let projectDate = projectDates{
            
        
            
            if projectDate.count == 0 || projectDate.count < 5 {
                nextButton.isHidden = true
            }else{
                
                nextButton.isHidden = false
                
                
            }
        }
    }



    func addViews(){
        addSubview(projectDateCollectionView)
        addSubview(previousButton)
        addSubview(nextButton)
        
        projectDateCollectionView.anchorWithConstantsToTop(top: topAnchor, left: previousButton.rightAnchor, bottom: bottomAnchor, right: nextButton.leftAnchor, topConstant: 0, leftConstant: 8, bottomConstant: 0, rightConstant: 8)
        
        previousButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        previousButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
        previousButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2).isActive = true
        previousButton.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2).isActive = true
        
        nextButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        nextButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true
        nextButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2).isActive = true
        nextButton.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2).isActive = true
    }
    
    
    @objc func handleNext(){
        
        if let projectTasks = projectTaskDates{
            
            let endProject = projectTasks.last
            
            if let startDate = endProject?.TaskDate{
               
                delegate?.onPreviousNextButtonClicked(startingDating: "0" , endingDate: String(startDate))
            }
            
            
            
        }
        
    }
    
    @objc func handlePrevious(){
        
        if let projectTasks = projectTaskDates{
            
            let endProject = projectTasks.first
            
            if let startDate = endProject?.TaskDate{
                
                delegate?.onPreviousNextButtonClicked(startingDating: String(startDate) , endingDate: "0" )
                
            }
            
            
            
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var projectDateCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let placesScreen = UICollectionView(frame: .zero, collectionViewLayout: layout)
        placesScreen.translatesAutoresizingMaskIntoConstraints = false
        placesScreen.register(ProjectDateCell.self , forCellWithReuseIdentifier: "ProjectDateCell")
        placesScreen.delegate = self
        placesScreen.dataSource = self
        placesScreen.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        placesScreen.showsHorizontalScrollIndicator = false
        return placesScreen
    }()
    
    lazy var previousButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(#imageLiteral(resourceName: "leftImage").withRenderingMode(.alwaysOriginal), for: .normal)
        btn.addTarget(self, action: #selector(handlePrevious), for: .touchUpInside)
        return btn
    }()
    
    lazy var nextButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.isHidden = true
        btn.setImage(#imageLiteral(resourceName: "rightImage").withRenderingMode(.alwaysOriginal), for: .normal)
        btn.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        return btn
    }()
}





class ProjectDateCell: UICollectionViewCell{
    
    
    var date: ProjectTaskDateListModel?{
        didSet{
            if let projectDate = date?.TaskDate{
                
                let date = LogicHelper.shared.convertStringToDate(date: projectDate)
            
                
                dayNameLabel.text = LogicHelper.shared.getDayName(date: date)
                dateLabel.text = "\(LogicHelper.shared.getDate(date: date)) \(LogicHelper.shared.getMonth(date: date)) "
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
    }
    
    func addViews(){
        addSubview(dayNameLabel)
        dayNameLabel.anchorWithConstantsToTop(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 8, leftConstant: 8, bottomConstant: 8, rightConstant: 8)
        
        addSubview(dateLabel)
        dateLabel.anchorWithConstantsToTop(top: dayNameLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 8, leftConstant: 8, bottomConstant: 8, rightConstant: 8)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let dayNameLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .gray
        lbl.text = "Monday"
        lbl.textAlignment = .center
        lbl.font = UIFont(name: lbl.font.fontName, size: 13)
        return lbl
    }()
    
    let dateLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .gray
        lbl.text = "18 March"
        lbl.textAlignment = .center
        lbl.font = UIFont(name: lbl.font.fontName, size: 13)
        return lbl
    }()
}




class ProjectNotificationCell: UITableViewCell {
    
    var taskData: ProjectTaskModel?{
        didSet{
            
            var taskLabelText = ""
            
            if let taskText = taskData?.TaskText{
                taskLabelText = taskText
            }
            
            if let hoursText = taskData?.Hours{
                taskLabelText = taskLabelText + "(\(String(hoursText) ) hrs,"
            }
            
            if let minuteText = taskData?.Minutes{
                taskLabelText = taskLabelText + "\(minuteText) min)"
            }
            
            
             titleNameLabel.text = taskLabelText
            descriptionLabel.text = taskData?.Description
            
        }
    }
    
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addViews()
        selectionStyle =  .none
    }
    
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)

    }

    override func layoutSubviews() {
       // drawDottedLine(start: CGPoint(x: dotImageView.frame.origin.x, y: dotImageView.frame.origin.y), end: CGPoint(x: dotImageView.frame.maxX, y: dotImageView.frame.maxY))
    }
    
    func addViews(){
       
        
        let moreImageView = UIImageView().returnTempImageView(image: #imageLiteral(resourceName: "moreImage"))
        moreImageView.contentMode  = .scaleAspectFit
        
        addSubview(circleImageView)
        addSubview(titleNameLabel)
        addSubview(descriptionLabel)
        addSubview(moreImageView)
        addSubview(dotImageView)
        addSubview(deleteButton)
        
        
        circleImageView.anchorWithConstantsToTop(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 32, bottomConstant: 0, rightConstant: 0)
        circleImageView.heightAnchor.constraint(equalToConstant: 16).isActive = true
        circleImageView.widthAnchor.constraint(equalToConstant: 16).isActive = true
        
        
        dotImageView.anchorWithConstantsToTop(top: circleImageView.bottomAnchor, left: nil, bottom: descriptionLabel.bottomAnchor, right: nil, topConstant: 0, leftConstant: 32, bottomConstant: -16, rightConstant: 0)
        dotImageView.widthAnchor.constraint(equalToConstant: 1).isActive = true
        dotImageView.centerXAnchor.constraint(equalTo: circleImageView.centerXAnchor).isActive = true

        
        titleNameLabel.anchorWithConstantsToTop(top: topAnchor, left: circleImageView.rightAnchor, bottom: nil, right: deleteButton.leftAnchor, topConstant: 0, leftConstant: 16, bottomConstant: 0, rightConstant: 8)
        
        descriptionLabel.anchorWithConstantsToTop(top: titleNameLabel.bottomAnchor, left: circleImageView.rightAnchor, bottom: bottomAnchor, right: deleteButton.leftAnchor, topConstant: 4, leftConstant: 16, bottomConstant: 16, rightConstant: 8)
        
        moreImageView.anchorWithConstantsToTop(top: descriptionLabel.topAnchor, left: nil, bottom: nil, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 16)
        moreImageView.heightAnchor.constraint(equalToConstant: 16).isActive = true
        moreImageView.widthAnchor.constraint(equalToConstant: 16).isActive = true
        
        
        deleteButton.anchorWithConstantsToTop(top: titleNameLabel.topAnchor, left: nil, bottom: nil, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 16)
        deleteButton.heightAnchor.constraint(equalToConstant: 16).isActive = true
        deleteButton.widthAnchor.constraint(equalToConstant: 16).isActive = true
        
    }

//    func drawDottedLine(start p0: CGPoint, end p1: CGPoint) {
//
//
//
//        let shapeLayer = CAShapeLayer()
//        shapeLayer.strokeColor = UIColor.lightGray.cgColor
//        shapeLayer.lineWidth = 1
//        shapeLayer.lineDashPattern = [7, 3] // 7 is the length of dash, 3 is length of the gap.
//
//        let path = CGMutablePath()
//        path.addLines(between: [p0, p1])
//        shapeLayer.path = path
//        dotImageView.layer.addSublayer(shapeLayer)
//    }
    
    
    @objc func handleDelete(){
        
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    let titleNameLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor =  #colorLiteral(red: 0.4470588235, green: 0.568627451, blue: 0.9568627451, alpha: 1)
        lbl.text = "UI Designing(5 Hours)"
        lbl.numberOfLines = 0
        lbl.font = UIFont.boldSystemFont(ofSize: 15)
        return lbl
    }()
    
    let descriptionLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .gray
        lbl.text = "it is a long establised fact that a reader will be distracted by the readable content of a page."
        lbl.numberOfLines = 0
        lbl.font = UIFont(name: lbl.font.fontName, size: 15)
        return lbl
    }()
    
    lazy var deleteButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.addTarget(self, action: #selector(handleDelete), for: .touchUpInside)
        btn.setImage(#imageLiteral(resourceName: "deleteImage"), for: .normal)
        btn.tintColor = #colorLiteral(red: 0.4470588235, green: 0.568627451, blue: 0.9568627451, alpha: 1)
        return btn
    }()
    
//    let dotImageView: UIImageView = {
//        let iv = UIImageView()
//        iv.image = #imageLiteral(resourceName: "dotImage").withRenderingMode(.alwaysTemplate)
//        iv.tintColor = #colorLiteral(red: 0.4470588235, green: 0.568627451, blue: 0.9568627451, alpha: 1)
//        iv.translatesAutoresizingMaskIntoConstraints = false
//        iv.contentMode = .scaleAspectFill
//        return iv
//    }()

    let dotImageView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.4470588235, green: 0.568627451, blue: 0.9568627451, alpha: 1)
        return view
    }()
    
    
    let circleImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "circleImage").withRenderingMode(.alwaysTemplate)
        iv.tintColor = #colorLiteral(red: 0.4470588235, green: 0.568627451, blue: 0.9568627451, alpha: 1)
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        return iv
    }()

    
}


class ProjectLoadMoreCell: UICollectionViewCell{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
    }
    
    func addViews(){
        
        let cardView = CardView()
        cardView.backgroundColor = #colorLiteral(red: 0.4470588235, green: 0.568627451, blue: 0.9568627451, alpha: 1)
        addSubview(cardView)
        cardView.addSubview(titleText)
        
        cardView.anchorWithConstantsToTop(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 32, rightConstant: 0)
        
        titleText.centerXAnchor.constraint(equalTo: cardView.centerXAnchor).isActive = true
        titleText.centerYAnchor.constraint(equalTo: cardView.centerYAnchor).isActive = true
        titleText.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        titleText.rightAnchor.constraint(equalTo: rightAnchor, constant: 16).isActive = true
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let titleText: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        lbl.text = "Tap to view all project"
        lbl.textAlignment = .center
        return lbl
    }()
    
}


