//
//  ProjectAssignPopUp.swift
//  CameraApp
//
//  Created by Jeevan chandra on 03/05/18.
//  Copyright © 2018 JEEVAN TIWARI. All rights reserved.
//



import UIKit



class ProjectAssignCustomPopUp: UIView {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.6)
        addViews()
        
    }
    
    
    override func draw(_ rect: CGRect) {
        whiteView.transform = CGAffineTransform(translationX: 0, y: UIScreen.main.bounds.height)
        
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseIn, animations: {
            self.whiteView.transform = .identity
        }, completion: nil)
        
    }
    
    
    func addViews(){
        
        
        addSubview(whiteView)
        
        whiteView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.6).isActive = true
        whiteView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9).isActive = true
        whiteView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        whiteView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        whiteView.addSubview(searchBar)
        
        whiteView.addSubview(submitButton)
        
        searchBar.anchorWithConstantsToTop(top: whiteView.topAnchor, left: whiteView.leftAnchor, bottom: nil, right: whiteView.rightAnchor, topConstant: 16, leftConstant: 16, bottomConstant: 16, rightConstant: 16)
        
        whiteView.addSubview(contentTable)
        contentTable.anchorWithConstantsToTop(top: searchBar.bottomAnchor, left: whiteView.leftAnchor, bottom: submitButton.topAnchor, right: whiteView.rightAnchor, topConstant: 0, leftConstant: 16, bottomConstant: 16, rightConstant: 16)
        
        addSubview(closeButton)
        
        
        
        
        closeButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        closeButton.topAnchor.constraint(equalTo: whiteView.bottomAnchor, constant: 16).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        submitButton.anchorWithConstantsToTop(top: nil, left: nil, bottom: whiteView.bottomAnchor, right: whiteView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 16, rightConstant: 16)
    }
    
    
    @objc func handleClose(){
        
        searchBar.text = ""
        
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseIn, animations: {
            self.whiteView.transform = CGAffineTransform(translationX: 0, y: UIScreen.main.bounds.height   )
            
        }) { (value) in
            self.whiteView.transform = .identity
            self.removeFromSuperview()
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.searchBarStyle = .minimal
        searchBar.tintColor = .black
        return searchBar
    }()
    
    lazy var contentTable: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.separatorStyle = .none
        tv.allowsMultipleSelection = true
        tv.rowHeight = UITableViewAutomaticDimension
        tv.register(EnhancmentRoomPopUpCell.self, forCellReuseIdentifier: "EnhancmentRoomPopUpCell")
        return tv
    }()
    
    lazy var closeButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(handleClose), for: .touchUpInside)
        btn.setImage(#imageLiteral(resourceName: "closeImage").withRenderingMode(.alwaysTemplate), for: .normal)
        btn.tintColor = .white
        return btn
    }()
    
    let whiteView: CardView = {
        let view = CardView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var submitButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints  = false
        btn.tintColor = #colorLiteral(red: 0.4470588235, green: 0.568627451, blue: 0.9568627451, alpha: 1)
        btn.setTitle("SUBMIT", for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        return btn
    }()
    
}
