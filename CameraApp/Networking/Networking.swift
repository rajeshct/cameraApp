//
//  Networking.swift
//  CameraApp
//
//  Created by JEEVAN TIWARI on 07/04/18.
//  Copyright © 2018 JEEVAN TIWARI. All rights reserved.
//

import Foundation
import Alamofire

class  Networking{
    
    // Post Request
    
    static let shared = Networking()
    
    
    func httpGetRequest(url: String, bodyParameter: [String: String],header: [String: String], dataIn: @escaping(Data) -> Void, errorIn: @escaping(String) -> Void){
        

        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.httpBody, headers: header).responseJSON { response in
            
            if let JSON = response.result.value {
                
                print(JSON)
                if let getData = response.data{
                        dataIn(getData)
                }
                
                
            }else{
                if let unwrappedError = response.result.error?.localizedDescription{
                    errorIn(unwrappedError)
                }
                print("Request failed with error: ",response.result.error ?? "Description not available :(")
                
            }
        }
        
        
        
        
    }
    
    
    
    
    func httpPostRequest(url: String, bodyParameter: [String: String],header: [String: String], dataIn: @escaping(Data) -> Void, errorIn: @escaping(String) -> Void){
        
        
        
    
        Alamofire.request(url, method: .post, parameters: bodyParameter,encoding: JSONEncoding.default, headers: header).responseJSON {
            response in
            switch response.result {
            case .success:
                print(response)
                
                if let getData = response.data{
                    dataIn(getData)
                }
               
                break
            case .failure(let error):
                
                errorIn(error.localizedDescription)
            }
        }
        
        
    }
    
    
    func requestWith(url: String, headers: HTTPHeaders, parameters: [String : Any],imageArray: [UIImage], onCompletion: @escaping (Data) -> Void, onError: @escaping(String) -> Void){
        
        
        
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            for (key, value) in parameters {
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
            }
            
            for index in 0..<imageArray.count{
               multipartFormData.append(imageArray[index].jpeg!, withName: "file", fileName: "image\(index).jpg", mimeType: "image\(index)/jpg")
                
              //  multipartFormData.append(imageArray[index].png!, withName: "file", fileName: "file", mimeType: "image/png")

                
            }
            
            
            print("The form data is ", dump(multipartFormData))
            
            //            if let data = imageData{
            //                multipartFormData.append(data, withName: "image", fileName: "image.png", mimeType: "image/png")
            //            }
            
        }, usingThreshold: UInt64.init(), to: url, method: .post, headers: headers) { (result) in
            switch result{
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    print("Succesfully uploaded")
                    print(response)
                    if let err = response.error{
                        //  onError?(err)
                        onError(err.localizedDescription)
                        return
                    }
                    
                    if let successData = response.data{
                            onCompletion(successData)
                    }
                    
                    //onCompletion?(nil)
                }
            case .failure(let error):
                print("Error in upload: \(error.localizedDescription)")
                onError(error.localizedDescription)
                //onError?(error)
            }
        }
    }
    
    
    
    
    func httpGenericGetRequest<T: Decodable>(url: String, bodyParameter: [String: String],header: [String: String], dataIn: @escaping(T) -> Void, errorIn: @escaping(String) -> Void){
        
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.httpBody, headers: header).responseJSON { response in
            
            if let JSON = response.result.value {
                
                print(JSON)
                if let getData = response.data{
                    
                    
                    do{
                        let jsonData = try JSONDecoder().decode(T.self, from: getData)
                        dataIn(jsonData)
                    }catch let jsonError{
                       errorIn(jsonError.localizedDescription)
                    }
                    
                    
                    
                    //dataIn(getData)
                }
                
                
            }else{
                if let unwrappedError = response.result.error?.localizedDescription{
                    errorIn(unwrappedError)
                }
                print("Request failed with error: ",response.result.error ?? "Description not available :(")
                
            }
        }
        
        
        
        
    }
    
    
    
    func httpGenericPostRequest<T: Decodable>(url: String, bodyParameter: [String: String],header: [String: String], dataIn: @escaping(T) -> Void, errorIn: @escaping(String) -> Void){
        
        
        
        
        Alamofire.request(url, method: .post, parameters: bodyParameter,encoding: JSONEncoding.default, headers: header).responseJSON {
            response in
            switch response.result {
            case .success:
                print(response)
               
                
                    if let getData = response.data{
                        
                        
                        do{
                            let jsonData = try JSONDecoder().decode(T.self, from: getData)
                            dataIn(jsonData)
                        }catch let jsonError{
                            errorIn(jsonError.localizedDescription)
                        }
                        
                        
                        
                        //dataIn(getData)
                    }
               
                
                break
            case .failure(let error):
                
                errorIn(error.localizedDescription)
            }
        }
        
        
    }
   
    
    
    
}


extension UIImage {
    var jpeg: Data? {
        
        return UIImageJPEGRepresentation(self, 1)   // QUALITY min = 0 / max = 1
    }
    var png: Data? {
        return UIImagePNGRepresentation(self)
    }
}

