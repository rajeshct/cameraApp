//
//  Networking.swift
//  CameraApp
//
//  Created by JEEVAN TIWARI on 07/04/18.
//  Copyright © 2018 JEEVAN TIWARI. All rights reserved.
//

import Foundation


class  Networking{
    
    // Post Request
    
    static let shared = Networking()
    
    func httpPostRequest(url: URL, bodyParameter: Data, errorIn: @escaping(String) -> Void, dataIn: @escaping(Data) -> Void){
        
        var urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 300)
        urlRequest.httpBody = bodyParameter
            urlRequest.httpMethod = "POST"
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            
            if let httpData = data{
                dataIn(httpData)
            }
            
            if let httpError = error{
                print(httpError)
                errorIn("")
            }
            
            
        }.resume()
        
        
    }
    
    
}
