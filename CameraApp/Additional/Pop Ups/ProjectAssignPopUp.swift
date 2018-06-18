//
//  ProjectAssignPopUp.swift
//  CameraApp
//
//  Created by Jeevan chandra on 03/05/18.
//  Copyright © 2018 JEEVAN TIWARI. All rights reserved.
//

import UIKit

class ProjectAssignPopUp: ProjectAssignCustomPopUp{

    var projectData: [LoginData]?{
        didSet{
            projectSearchData = projectData
        }
    }
    
    var preSelectedRows: String?
    
    
    var projeactAssign = [String: Int]()
    var projectAssignName = [String: String]()
    var projectSearchData: [LoginData]?
    
    var delegate: ProjectAssignDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        translatesAutoresizingMaskIntoConstraints = false
        
        
    }
    
    
    override func draw(_ rect: CGRect) {
        if let projectAssigns = preSelectedRows{
            selectedAssignId()
        }
    }

    func setup(){
        contentTable.delegate = self
        contentTable.dataSource = self
        searchBar.delegate = self
        contentTable.allowsMultipleSelection = true
        contentTable.register(ProjectAssignCell.self, forCellReuseIdentifier: "ProjectAssignCell")
        submitButton.addTarget(self, action: #selector(handleSubmit), for: .touchUpInside)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}



extension ProjectAssignPopUp: UITableViewDelegate, UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return projectSearchData?.count ?? 0
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height * 0.07
    }


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as? ProjectAssignCell
        let assignId = projectSearchData?[indexPath.item].ID
        let name = getFullName(firstName: projectSearchData?[indexPath.item].FirstName, lastName: projectSearchData?[indexPath.item].LastName)
        addAssignId(index: indexPath.item, value: assignId, name: name)
        cell?.checkedImge.image = #imageLiteral(resourceName: "checkedImage").withRenderingMode(.alwaysTemplate)
        cell?.checkedImge.tintColor = #colorLiteral(red: 0.4470588235, green: 0.568627451, blue: 0.9568627451, alpha: 1)
        

    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! ProjectAssignCell
        cell.checkedImge.image = #imageLiteral(resourceName: "UncheckImage").withRenderingMode(.alwaysTemplate)
        cell.checkedImge.tintColor = #colorLiteral(red: 0.4470588235, green: 0.568627451, blue: 0.9568627451, alpha: 1)
        removeAssignId(index: indexPath.item)
        
    }
    
    func removeAssignId(index: Int){
        
        projeactAssign.removeValue(forKey: String(index))
        projectAssignName.removeValue(forKey: String(index))
    }
    
    func addAssignId(index: Int, value: Int?, name: String?){
        if let assignId = value,let getName = name{
             projeactAssign.updateValue(assignId, forKey: String(index))
            projectAssignName.updateValue(getName, forKey: String(index))
        }
       
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectAssignCell", for: indexPath) as! ProjectAssignCell
        cell.currencyLabel.text = getFullName(firstName: projectSearchData?[indexPath.item].FirstName, lastName: projectSearchData?[indexPath.item].LastName)
        cellSelection(cell: cell)
        return cell
    }
    
    func cellSelection(cell: ProjectAssignCell){
        if cell.isSelected{
            cell.checkedImge.image = #imageLiteral(resourceName: "checkedImage").withRenderingMode(.alwaysTemplate)
            cell.checkedImge.tintColor = #colorLiteral(red: 0.4470588235, green: 0.568627451, blue: 0.9568627451, alpha: 1)
        }else{
            cell.checkedImge.image = #imageLiteral(resourceName: "UncheckImage").withRenderingMode(.alwaysTemplate)
            cell.checkedImge.tintColor = #colorLiteral(red: 0.4470588235, green: 0.568627451, blue: 0.9568627451, alpha: 1)
        }
    }

    
    func getFullName(firstName: String?, lastName: String?) -> String{
        var fullName = ""
        
        if let first = firstName{
            fullName = fullName + first
        }
        
        if let second = lastName{
            fullName = fullName  + " " + second
        }
        
        return fullName
    }
    
    
    func selectedAssignId(){
        
        if let projectAssigns = projectData{
            
            for index in 0..<projectAssigns.count{
                
                if let projectAssignId = projectAssigns[index].ID,let  preSelectedAssignId = preSelectedRows{
                    
                    if preSelectedAssignId.localizedCaseInsensitiveContains(String(projectAssignId)){
                        
                        //tableView(contentTable, didSelectRowAt: IndexPath(item: index, section: 0))
                        contentTable.selectRow(at: IndexPath(item: index, section: 0), animated: false, scrollPosition: .bottom)
                        
                        projeactAssign.updateValue(projectAssignId, forKey: String(index))
                        projectAssignName.updateValue(getFullName(firstName: projectAssigns[index].FirstName, lastName: projectAssigns[index].LastName), forKey: String(index))
                    }
                    
                    
                }
                
            }
        }
        
        
    }

}


extension ProjectAssignPopUp: UISearchBarDelegate, UISearchDisplayDelegate{

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        projectSearchData = searchText.isEmpty ? projectData : projectData?.filter({ (hotel) -> Bool in
            return hotel.FirstName?.range(of: searchText, options: .caseInsensitive) != nil
        })

        contentTable.reloadData()

    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    
    @objc func handleSubmit(){
        var projectAssignNames = ""
        var projectAssignIds = ""
     
        for (_, value) in projectAssignName{
            projectAssignNames = projectAssignNames + value + ","
        }
        
        for (_, value) in projeactAssign{
            projectAssignIds = projectAssignIds + String(value) + ","
        }
        
        if projectAssignNames != ""{
            projectAssignNames.removeLast()
        }
        
        if projectAssignIds != ""{
            projectAssignIds.removeLast()
        }
        
      
        
        
        delegate?.onClickCell(value: projectAssignNames, assignId: projectAssignIds)
        handleClose()
    }
    
    
}




class ProjectAssignCell: UITableViewCell{
    
    
    
    //MARK: Intialization of view
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addViews()
        selectionStyle = .none
    }
    
    func addViews(){
        addSubview(currencyLabel)
        addSubview(checkedImge)
        
        
        checkedImge.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        checkedImge.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        checkedImge.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4).isActive = true
        checkedImge.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4).isActive = true
    
        
        currencyLabel.anchorWithConstantsToTop(top: topAnchor, left: checkedImge.rightAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 8, leftConstant: 8, bottomConstant: 8, rightConstant: 16)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let currencyLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont(name: lbl.font.fontName, size: 15)
        return lbl
    }()
    
    
    let checkedImge: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = #imageLiteral(resourceName: "UncheckImage").withRenderingMode(.alwaysTemplate)
        iv.tintColor = #colorLiteral(red: 0.4470588235, green: 0.568627451, blue: 0.9568627451, alpha: 1)
        return iv
    }()
    
    
    
}

