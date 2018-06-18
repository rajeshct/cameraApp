//
//  CreateSubgroupCell.swift
//  CameraApp
//
//  Created by JEEVAN TIWARI on 6/10/18.
//  Copyright © 2018 JEEVAN TIWARI. All rights reserved.
//

import UIKit


class CreateSubgroupCell: UITableViewCell{
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class CreateSubGroupModel: Decodable{
    
    var status: Bool?
    var message: String?
    var error: Bool?
}
