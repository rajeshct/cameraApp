//
//  CalendarViewHeader.swift
//  CameraApp
//
//  Created by JEEVAN TIWARI on 25/04/18.
//  Copyright © 2018 JEEVAN TIWARI. All rights reserved.
//

import UIKit
import JTAppleCalendar


class CalendarViewHeader: JTAppleCollectionReusableView{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
    }
    
    func addViews(){
        addSubview(monthLabel)
        monthLabel.anchorToTop(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let monthLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "<  January  >"
        lbl.font = UIFont.boldSystemFont(ofSize: 17)
        lbl.textAlignment = .center
        return lbl
    }()
    
}
