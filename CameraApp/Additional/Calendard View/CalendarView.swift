//
//  CalendarView.swift
//  SkyLabs
//
//  Created by JEEVAN TIWARI on 02/10/17.
//  Copyright © 2017 Jeevan chandra. All rights reserved.
//

import UIKit
import JTAppleCalendar


class CalendarView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        
    }
    
    func addViews(){
        
        addSubview(cardView)
        addSubview(startDateButton)
        addSubview(endDateButton)
        addSubview(movingView)
        
        
        cardView.anchorWithConstantsToTop(top: nil, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 16, leftConstant: 16, bottomConstant: 16, rightConstant: 16)
        
        cardView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        cardView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        
        startDateButton.anchorToTop(top: cardView.topAnchor, left: cardView.leftAnchor, bottom: nil, right: nil)
        startDateButton.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.07).isActive = true
        startDateButton.widthAnchor.constraint(equalTo: widthAnchor , multiplier: 0.5).isActive = true
        
        endDateButton.anchorToTop(top: cardView.topAnchor, left: startDateButton.rightAnchor, bottom: nil, right: cardView.rightAnchor)
        endDateButton.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.07).isActive = true
        
        movingView.anchorToTop(top: nil, left: startDateButton.leftAnchor, bottom: startDateButton.bottomAnchor, right: nil)
        movingView.widthAnchor.constraint(equalTo: cardView.widthAnchor, multiplier: 0.5).isActive = true
        movingView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        
        
    }
    
    
    
   
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let startDateButton: UIButton = {
            let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("START DATE", for: .normal)
        btn.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        return btn
    }()
    
    let endDateButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("START DATE", for: .normal)
        btn.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
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
}
