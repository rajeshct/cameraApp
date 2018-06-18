//
//  ProjectPopUp.swift
//  CameraApp
//
//  Created by Jeevan chandra on 03/05/18.
//  Copyright © 2018 JEEVAN TIWARI. All rights reserved.
//

import UIKit

class SeenByPopUp: CustomPopUp{
   
    var projectData: [SeenByDataModel]?{
        didSet{
            projectSearchData = projectData
        }
    }

    
    
 
    var projectSearchData: [SeenByDataModel]?
   
    
    var groupId: Int?
    var commentId: Int?{
      
        didSet{
            getSeenByArray()
        }
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setup(){
        contentTable.delegate = self
        contentTable.dataSource = self
        searchBar.delegate = self
        contentTable.register(SeenByPopUpCell.self, forCellReuseIdentifier: "SeenByPopUpCell")
    }
    
    
    func getSeenByArray(){
        
        
        if let getGroupId = groupId{
            if let getCommentId = commentId{
                let seenByApi = SeenByApiInteraction()
                seenByApi.delegate  = self
                seenByApi.getSeenBy(commentId: String(getCommentId), groupId: String(getGroupId))
                
            }
            
        }else{
            
            if let getCommentId = commentId{
                let seenByApi = SeenByApiInteraction()
                seenByApi.delegate  = self
                seenByApi.getSeenBy(commentId: String(getCommentId), groupId: "0")
                
            }
        }
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}



extension SeenByPopUp: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return  projectSearchData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height * 0.07
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SeenByPopUpCell", for: indexPath) as! SeenByPopUpCell
        cell.projectData = projectSearchData?[indexPath.item]
        return cell
    }
    
    
}


extension SeenByPopUp: SeenByDelegate{
    
    func seenByDetails(data: SeenByCountModel?, error: String?) {
        projectData = data?.result
        contentTable.reloadData()
    }
    
    
    
}


extension SeenByPopUp: UISearchBarDelegate, UISearchDisplayDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        projectSearchData = searchText.isEmpty ? projectData : projectData?.filter({ (hotel) -> Bool in
            return hotel.FirstName?.range(of: searchText, options: .caseInsensitive) != nil
        })
        
        contentTable.reloadData()
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}



class SeenByPopUpCell: UITableViewCell{
    
    
    var projectData: SeenByDataModel?{
        didSet{
            if let userImage = projectData?.ImageUrl{
                userImageView.pin_updateWithProgress = true
                if let imageUrl = URL(string: NetworkWebApisConstant.baseUrl + userImage){
                    userImageView.pin_setImage(from: imageUrl)
                }
            }
            
            userName.text = userName.getFullName(firstName: projectData?.FirstName, lastName: projectData?.LastName)
            
        }
    }
    
    //MARK: Intialization of view
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addViews()
        selectionStyle = .none
    }
    
    func addViews(){
        addSubview(userName)
        addSubview(userImageView)
        
        userName.anchorWithConstantsToTop(top: topAnchor, left: userImageView.rightAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 8, leftConstant: 16, bottomConstant: 8, rightConstant: 16)
        
        userImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        userImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.8).isActive = true
        userImageView.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 0.8).isActive = true
        userImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let userName: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont(name: lbl.font.fontName, size: 15)
        return lbl
    }()
    
    let userImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.clipsToBounds = true
        iv.layer.cornerRadius = UIScreen.main.bounds.height * 0.07 * 0.8 / 2
        return iv
    }()
    
    
    
    
    
}






