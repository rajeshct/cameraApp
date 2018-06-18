//
//  CustomViews.swift
//  CameraApp
//
//  Created by JEEVAN TIWARI on 07/04/18.
//  Copyright © 2018 JEEVAN TIWARI. All rights reserved.
//

import UIKit


extension  UIView{
    
    func returnTempView(backgroundColor: UIColor) -> UIView{
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = backgroundColor
        return view
    }
    

}


extension UITextField{
    
    
    func addEffects(){
        
        placeholder = "Password"
        layer.cornerRadius = 10
        layer.masksToBounds = false
        layer.shadowRadius = 3.0
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowOpacity = 1.0
        backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        let leftViews = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.height * 0.07 * 0.4 + 32, height: 0))
        leftViewMode = .always
        isSecureTextEntry = true
        leftView = leftViews
        
        
    }
    
}




extension UILabel {
    
    func returnTempLabel(text: String) -> UILabel{
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = text
        lbl.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        lbl.textAlignment = .center
        return lbl
    }
    
    func getFullName(firstName: String?, lastName: String?) -> String{
        
        var fullName = ""
        
        if let first = firstName{
                fullName = fullName + first + " "
        }
        
        if let last = lastName{
                fullName = fullName + last
        }
        
        
        
        return  fullName 
    }
    
    
    func getConversation(userName1: String?, userName2: String?,firstName: String?, lastName: String?) -> NSAttributedString{
        
        
        
        var fullName = NSMutableAttributedString()
        
        if let first = firstName, let userName = userName1{
            
            fullName.append(NSAttributedString(string: userName + ": ", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 15)]))
            
            
            fullName.append(NSAttributedString(string: first + "\n", attributes: [NSAttributedStringKey.font: UIFont(name: UILabel().font.fontName, size: 13)]))
        
        }
        
        if let last = lastName, let userName =  userName2{
            
            fullName.append(NSAttributedString(string: userName + ":", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 15)]))
            
            fullName.append(NSAttributedString(string: last , attributes: [NSAttributedStringKey.font: UIFont(name: UILabel().font.fontName, size: 13)]))
            
        }
        
        
        
        return  fullName
    }
}

extension UIImageView {
    
    func returnTempImageView(image: UIImage) -> UIImageView{
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = image
        return iv
        
    }
    
    
}

extension UIButton{
    
    func addCornerRadius(btn: UIButton){
        let rectShape = CAShapeLayer()
        rectShape.bounds = btn.frame
        rectShape.position = btn.center
        rectShape.path = UIBezierPath(roundedRect: btn.bounds, byRoundingCorners: [.bottomLeft , .bottomRight ], cornerRadii: CGSize(width: 10, height: 10)).cgPath
        
        btn.layer.backgroundColor = #colorLiteral(red: 0.9294117647, green: 0.9411764706, blue: 0.9568627451, alpha: 1).cgColor
        //Here I'm masking the textView's layer with rectShape layer
        btn.layer.mask = rectShape
    }
}

extension UIView{
    
    func showActivityIndicator(activityIndicator: ActivityIndicatorView){
        
        if let window = UIApplication.shared.keyWindow{
            activityIndicator.activityIndicator.startAnimating()
            window.addSubview(activityIndicator)
            activityIndicator.anchorToTop(top: window.topAnchor, left: window.leftAnchor, bottom: window.bottomAnchor, right: window.rightAnchor)
        }
    }
    
    func removeActivityIndicator(activityIndicator: ActivityIndicatorView){
        activityIndicator.close()
    }
    
    func rotate(_ toValue: CGFloat, duration: CFTimeInterval = 0.2) {
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        
        animation.toValue = toValue
        animation.duration = duration
        animation.isRemovedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        
        self.layer.add(animation, forKey: nil)
    }
    
    
    
}


extension String{
    
    func getHeader() -> [String: String]{
        
        guard let token = UserDefaults.standard.value(forKey: "token") as? String else{
            return ["":""]
        }
        

        let header = [
            "Content-Type":"application/x-www-form-urlencoded",
            "token": token,
            "client" : "android"
        ]
        
        
        return header
        
        
    }
    
    func getBodyHeader() -> [String: String]{
        
        guard let token = UserDefaults.standard.value(forKey: "token") as? String else{
            return ["":""]
        }
        
        
        let header = [
            "Content-Type":"application/json",
            "token": token,
            "client" : "android"
        ]
        
    
        
        return header
        
        
    }
    
    
    func getMultiPartHeader() -> [String: String]{
        
        guard let token = UserDefaults.standard.value(forKey: "token") as? String else{
            return ["":""]
        }
        

        
        let header = [
        "token": token,
        "client" : "android",
        "Content-type": "multipart/form-data"
        ]
        
        return header
        
        
    }
    
    
    
    
}

