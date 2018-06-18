//
//  ProjectPopUp.swift
//  CameraApp
//
//  Created by Jeevan chandra on 03/05/18.
//  Copyright © 2018 JEEVAN TIWARI. All rights reserved.
//

import UIKit

class ProjectPopUp: CustomPopUp{

    var projectData: [ProjectListModel]?{
        didSet{
            projectSearchData = projectData
        }
    }

    var projectSearchData: [ProjectListModel]?
    var delegate: PopUpSelectDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        translatesAutoresizingMaskIntoConstraints = false
    }

    func setup(){
        contentTable.delegate = self
        contentTable.dataSource = self
        searchBar.delegate = self
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}



extension ProjectPopUp: UITableViewDelegate, UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return projectSearchData?.count ?? 0
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height * 0.07
    }


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! EnhancmentRoomPopUpCell
        let projectId = projectSearchData?[indexPath.item].ProjectID
        delegate?.onClickCell(value: cell.currencyLabel.text, type: "projectList", projectId: projectId)
        handleClose()

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "EnhancmentRoomPopUpCell", for: indexPath) as! EnhancmentRoomPopUpCell
        cell.currencyLabel.text = projectSearchData?[indexPath.item].ProjectName
        return cell
    }


}


extension ProjectPopUp: UISearchBarDelegate, UISearchDisplayDelegate{

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        projectSearchData = searchText.isEmpty ? projectData : projectData?.filter({ (hotel) -> Bool in
            return hotel.ProjectName?.range(of: searchText, options: .caseInsensitive) != nil
        })

        contentTable.reloadData()

    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

