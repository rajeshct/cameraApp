//
//  ViewAllProjectsDelegate.swift
//  CameraApp
//
//  Created by JEEVAN TIWARI on 20/05/18.
//  Copyright © 2018 JEEVAN TIWARI. All rights reserved.
//

import UIKit

extension ViewAllProjectsController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewProjectInDetail = ViewProjectInDetails()
        viewProjectInDetail.projectData = projectData?[indexPath.item]
        navigationController?.pushViewController(viewProjectInDetail, animated: true)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return projectSearchData?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectedHotelCell", for: indexPath) as! SelectedHotelCell
        cell.projectData = projectSearchData?[indexPath.item]
        return cell
    }
    
}


extension ViewAllProjectsController: UISearchBarDelegate, UISearchDisplayDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        projectSearchData = searchText.isEmpty ? projectData : projectData?.filter({ (hotel) -> Bool in
            return hotel.ProjectName?.range(of: searchText, options: .caseInsensitive) != nil
        })
        
        projectsCollectionView.reloadData()
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        SaveUserDataOnLogin.shared.getUserDataFromPlist(completion: { (result) in
            
            if let companyId = result.result?.CompanyId, let projectName = self.searchBar.text{
                
                let viewAllProject = ViewAllProjectApiInteraction()
                viewAllProject.delegate  = self
                viewAllProject.getAllProjectList(companyId: String(companyId), projectName: projectName)
                
            }
            
        }) { (error) in
            
        }
        
        
        
        
    }
}

extension ViewAllProjectsController: AllprojectsDelegate{
    
    func allProjects(data: [ProjectListModel]?, error: String?) {
        
        projectData = data
        projectsCollectionView.reloadData()
    }
    
}
