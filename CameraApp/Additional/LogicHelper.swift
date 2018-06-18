//
//  LogicHelper.swift
//  NewMontCalm
//
//  Created by Jeevan chandra on 14/12/17.
//  Copyright © 2017 Jeevan chandra. All rights reserved.
//

import Foundation
import UIKit

class LogicHelper{
    
    static let shared = LogicHelper()
    
    func returnDayDateYear(date: Date){
        
        let changeDate = addOneToDate(date: date)
        
        print(getDayName(date: changeDate))
        print(getYear(date: changeDate))
        print(getMonth(date: changeDate))
        print(getDate(date: changeDate))
        
    }
    
    func addOneToDate(date: Date) -> Date{
        
        var components = DateComponents()
        components.day = 1
        let calendar = Calendar(identifier: .gregorian)
        return calendar.date(byAdding: components, to: date)!
        
    }
    
    func getDayName(date: Date) -> String{
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EE"
        return dateFormatter.string(from: date)
        
    }
    
    func getYear(date: Date) -> String{
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY"
        return dateFormatter.string(from: date)
        
    }
    
    func getMonth(date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        return dateFormatter.string(from: date)
        
    }
    
    func getMonthShort(date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLL"
        return dateFormatter.string(from: date)
        
    }
    
    func getDate(date: Date) -> String{
        
        let calendar = Calendar.current
        return String(calendar.component(.day, from: date))
        
    }
    
    func convertDateToServerFormat(date: Date) -> String{
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
    
        
        
        print(formatter.string(from: date))
        return   formatter.string(from: date)
        
    }
    
    func convertDateToTitle(date: Date) -> String{
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yy/MM/dd"
        print(formatter.string(from: date))
        return   formatter.string(from: date)
        
    }
    
    
    func convertStringToDate(date: CLong) -> Date {
        
       // let dateFormatter = DateFormatter()
      
        
        let date = Date(timeIntervalSince1970: TimeInterval(date / 1000))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        let convertedUtcDate = dateFormatter.string(from: date)
        
        guard let utcDate = dateFormatter.date(from: convertedUtcDate) else{
            return date
        }
        
        return utcDate
        
        //Date(timeIntervalSince1970: TimeInterval(date / 1000))
        //dateFormatter.dateFormat = "MM-dd/yyyy HH:mm:ss"
        //return dateFormatter.date(from: date)!
    }
    
    
    func convertDateToTimeStamp(date: Date) -> CLong{
    
        // convert Date to TimeInterval (typealias for Double)
        
       let timeInterval = date.timeIntervalSince1970
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        
        let convertedUtcDate = dateFormatter.date(from: convertDateToServerFormat(date: date))

        guard let utcDate = convertedUtcDate else{
            return CLong(timeInterval)
        }
        
       
       return CLong(utcDate.timeIntervalSince1970)
    }

    
    
    
    func returnStandardCellSize() -> CGFloat{
        
        if UIScreen.main.bounds.width ==  375.0{
             return 282.0
        }else if UIScreen.main.bounds.width == 320.0{
            return 238.0
        }else if UIScreen.main.bounds.width == 414.0{
            return 313.0
        }
        
            return 238.0
        
    }


}
