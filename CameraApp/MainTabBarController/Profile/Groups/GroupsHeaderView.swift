//
//  CollapsibleTableViewHeader.swift
//  ios-swift-collapsible-table-section
//
//  Created by Yong Su on 5/30/16.
//  Copyright © 2016 Yong Su. All rights reserved.
//

import UIKit

protocol CollapsibleTableViewHeaderDelegate {
    func toggleSection(_ header: CollapsibleTableViewHeader, section: Int)
    func groupTapped(item: Int)
}

class CollapsibleTableViewHeader: UITableViewHeaderFooterView {
    
    var delegate: CollapsibleTableViewHeaderDelegate?
    var section: Int = 0
    
    let titleLabel = UILabel()
    let arrowLabel = UILabel()
    
    var subGroupCount: Int?{
        didSet{
            setCount()
        }
    }
    
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        // Content View
        contentView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        let marginGuide = contentView.layoutMarginsGuide
        
        // Arrow label
        contentView.addSubview(rightView)
        contentView.addSubview(titleLabel)
        rightView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
        rightView.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor).isActive = true
        rightView.heightAnchor.constraint(equalToConstant: 49 * 0.4).isActive = true
        rightView.widthAnchor.constraint(equalToConstant: 49 * 0.4).isActive = true
        
        // Title label
        
        titleLabel.textColor = UIColor.black
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
       // titleLabel.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 49).isActive = true
        
        contentView.addSubview(totalGroups)
        totalGroups.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
       // totalGroups.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        // titleLabel.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
        totalGroups.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        totalGroups.heightAnchor.constraint(equalToConstant: 49).isActive = true
        
        
        //
        // Call tapHeader when tapping on this header
        //
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(headerTapped(_:))))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //
    // Trigger toggle section when tapping on the header
    //
    
    @objc func headerTapped(_ gestureRecognizer: UIButton) {
        
        delegate?.groupTapped(item: section)
    }
    
    
    
    
    @objc func tapHeader(_ gestureRecognizer: UIButton) {
        guard let cell = self as? CollapsibleTableViewHeader else {
            return
        }
        
        delegate?.toggleSection(self, section: cell.section)
    }
    
    func setCollapsed(_ collapsed: Bool) {
        //
        // Animate the arrow rotation (see Extensions.swf)
        //
        arrowLabel.rotate(collapsed ? 0.0 : .pi / 2)
    }
    
    
    func setCount(){
        
        if let getCount = subGroupCount{
            
            if getCount == 1{
                totalGroups.setTitle("\(getCount) Sub Group", for: .normal)
            }else{
                totalGroups.setTitle("\(getCount) Sub Groups", for: .normal)
            }
        }
    }
    
    let rightView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = #imageLiteral(resourceName: "moreImage").withRenderingMode(.alwaysTemplate)
        iv.contentMode = .scaleAspectFit
        iv.tintColor = #colorLiteral(red: 0.4470588235, green: 0.568627451, blue: 0.9568627451, alpha: 1)
        return iv
    }()
    
    
    lazy var totalGroups: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("1 Sub Group ^", for: .normal)
        btn.tintColor = #colorLiteral(red: 0.4470588235, green: 0.568627451, blue: 0.9568627451, alpha: 1)
        btn.addTarget(self, action: #selector(tapHeader(_:)), for: .touchUpInside)
        return btn
    }()
    
    
}
