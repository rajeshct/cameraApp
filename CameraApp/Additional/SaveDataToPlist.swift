//
//  SaveUserDataOnRegister.swift
//  NewMontCalm
//
//  Created by Jeevan chandra on 13/12/17.
//  Copyright © 2017 Jeevan chandra. All rights reserved.
//

import Foundation


class SaveUserDataOnLogin{
    
    static let shared = SaveUserDataOnLogin()
    
    func saveDataToPList(userModel: LoginResultsModel?){
        
        let encoder = PropertyListEncoder()
        encoder.outputFormat = .xml
        
        do {
            let data = try encoder.encode(userModel)
            try data.write(to: URL(fileURLWithPath: dataFilePath()))
            
        } catch {
            // Handle error
            print(error)
        }
        
        
    }
    
    func getUserDataFromPlist(completion: @escaping(LoginResultsModel) -> Void, error: @escaping(String) -> Void ){
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: dataFilePath()))
            let decoder = PropertyListDecoder()
            let settings = try decoder.decode(LoginResultsModel.self, from: data)
            completion(settings)
        } catch {
            // Handle error
            print(error)
        }
    }
    
    func documentsDirectory()->String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory,
                                                        .userDomainMask, true)
        let documentsDirectory = paths.first!
        return documentsDirectory
    }
    
    func dataFilePath ()->String{
        return self.documentsDirectory().appendingFormat("/userList.plist")
    }
    
}


