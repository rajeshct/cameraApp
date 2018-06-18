//
//  CalendarView.swift
//  SkyLabs
//
//  Created by JEEVAN TIWARI on 02/10/17.
//  Copyright © 2017 Jeevan chandra. All rights reserved.
//

import UIKit
import JTAppleCalendar

enum DefaultSelectedDate{
    case STARTDATE
    case ENDDATE
}

class CalendarView: UIView {
    
    var projectStartingDate: Date?
    var projectEndingDate: Date?
    var movingViewLeftAnchor: NSLayoutConstraint?
    var defaultValue: DefaultSelectedDate?
    var startDate: Date?
    var endDate: Date?
    var delegate: CalendarDatesDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5043610873)
    }
    
    override func draw(_ rect: CGRect) {
        addViews()
        cardView.transform = CGAffineTransform(translationX: 0, y: UIScreen.main.bounds.height)
        defaultValue = DefaultSelectedDate.STARTDATE
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseIn, animations: {
            self.cardView.transform = .identity
        }, completion: nil)
        
        startDate = Date()
        endDate = Date()
        
        
        if let startDate = projectStartingDate{
            calendarCollectionView.selectDates([startDate])
        }else{
            calendarCollectionView.selectDates([Date()])
        }
        
    }
    
    func addViews(){
        
        addSubview(cardView)
        cardView.addSubview(startDateButton)
        cardView.addSubview(endDateButton)
        cardView.addSubview(movingView)
        cardView.addSubview(calendarCollectionView)
        cardView.addSubview(okButton)
        addSubview(closeButton)
        addSubview(dateLabel)
        
        
        cardView.anchorWithConstantsToTop(top: nil, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 16, leftConstant: 16, bottomConstant: 16, rightConstant: 16)
        
        cardView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        cardView.heightAnchor.constraint(equalToConstant: 430).isActive = true
        
        
        startDateButton.anchorToTop(top: cardView.topAnchor, left: cardView.leftAnchor, bottom: nil, right: nil)
        startDateButton.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.06).isActive = true
        startDateButton.widthAnchor.constraint(equalTo: widthAnchor , multiplier: 0.5).isActive = true
        
        endDateButton.anchorToTop(top: cardView.topAnchor, left: startDateButton.rightAnchor, bottom: nil, right: cardView.rightAnchor)
        endDateButton.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.06).isActive = true
        
        movingView.anchorToTop(top: nil, left: startDateButton.leftAnchor, bottom: startDateButton.bottomAnchor, right: nil)
        
        movingViewLeftAnchor = movingView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16)
        movingViewLeftAnchor?.isActive = true
        
        movingView.widthAnchor.constraint(equalTo: cardView.widthAnchor, multiplier: 0.5).isActive = true
        movingView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        
        okButton.anchorWithConstantsToTop(top: nil, left: nil, bottom: cardView.bottomAnchor, right: cardView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 16, rightConstant: 16)
        
        
        
        calendarCollectionView.anchorWithConstantsToTop(top: startDateButton.bottomAnchor, left: cardView.leftAnchor, bottom: okButton.topAnchor, right: cardView.rightAnchor, topConstant: 8, leftConstant: 16, bottomConstant: 8, rightConstant: 16)
        
        
        closeButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        closeButton.topAnchor.constraint(equalTo: cardView.bottomAnchor, constant: 16).isActive = true
        
        
        dateLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        dateLabel.bottomAnchor.constraint(equalTo: cardView.topAnchor, constant: -16).isActive = true
        
    }
    
    
    
   
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var startDateButton: UIButton = {
            let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("START DATE", for: .normal)
        btn.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        btn.addTarget(self, action: #selector(handleStartDate), for: .touchUpInside)
        return btn
    }()
    
    lazy var endDateButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("END DATE", for: .normal)
         btn.addTarget(self, action: #selector(handleEndDate), for: .touchUpInside)
        btn.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        return btn
    }()
    
    lazy var okButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("OK", for: .normal)
        btn.addTarget(self, action: #selector(handleOk), for: .touchUpInside)
        btn.setTitleColor(#colorLiteral(red: 0.4470588235, green: 0.568627451, blue: 0.9568627451, alpha: 1), for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        return btn
    }()
    
    let movingView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.4470588235, green: 0.568627451, blue: 0.9568627451, alpha: 1)
        return view
    }()
    
    let cardView: CardView = {
        let cv = CardView()
        cv.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        return cv
    }()
    
    lazy var calendarCollectionView: JTAppleCalendarView = {
        let cv = JTAppleCalendarView()
        cv.calendarDataSource = self
        cv.calendarDelegate = self
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.minimumInteritemSpacing = 0
        cv.minimumLineSpacing = 0
        cv.scrollDirection = .horizontal
        cv.isPagingEnabled = true
        cv.backgroundColor = .white
        cv.isUserInteractionEnabled = true
        cv.register(CalendarViewCell.self, forCellWithReuseIdentifier: "CalendarViewCell")
        cv.register(CalendarViewHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "CalendarViewHeader")
        
        //cv.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 5)
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()
    
    lazy var closeButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(#imageLiteral(resourceName: "closeImage").withRenderingMode(.alwaysTemplate), for: .normal)
        btn.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        btn.addTarget(self, action: #selector(handleClose), for: .touchUpInside)
        return btn
    }()
    
    let dateLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.boldSystemFont(ofSize: 17)
        lbl.textAlignment = .center
        lbl.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        return lbl
    }()
}
