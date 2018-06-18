//
//  DataRestrictionCheck.swift
//  CameraApp
//
//  Created by JEEVAN TIWARI on 07/04/18.
//  Copyright © 2018 JEEVAN TIWARI. All rights reserved.
//

import UIKit

class DataRestrictionCheck{
    
    static let shared = DataRestrictionCheck()
    
    func checkEmptyTextField(textField: UITextField) -> Bool{
        
        if textField.text == ""{
            return true
        }
        
        return false
    }
    
}


