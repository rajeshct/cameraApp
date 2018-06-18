//
//  ViewAllProjectsControlelr.swift
//  CameraApp
//
//  Created by JEEVAN TIWARI on 20/05/18.
//  Copyright © 2018 JEEVAN TIWARI. All rights reserved.
//

import UIKit
import UPCarouselFlowLayout

class ViewAllProjectsController: UIViewController{
    
    var projectData: [ProjectListModel]?{
        didSet{
            projectSearchData = projectData
        }
    }
    
    var projectSearchData: [ProjectListModel]?
    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        navigationItem.titleView = searchBar
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
        navigationItem.title = ""

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        searchBar.removeFromSuperview()
        tabBarController?.tabBar.isHidden = false
    }
    
    
    func addViews(){
        view.addSubview(projectsCollectionView)
        
        if #available(iOS 11.0, *){
            //  projectsCollectionView.anchorToTop(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
            
            
            projectsCollectionView.anchorWithConstantsToTop(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 16, leftConstant: 0, bottomConstant: 0, rightConstant: 0)
        }else{
            projectsCollectionView.anchorWithConstantsToTop(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 16, leftConstant: 0, bottomConstant: 0, rightConstant: 0)
        }
        
    }
    
    lazy var projectsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 32, height: 200)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.delegate = self
        cv.dataSource = self
        cv.showsHorizontalScrollIndicator = false
        cv.register(SelectedHotelCell.self, forCellWithReuseIdentifier: "SelectedHotelCell")
        cv.backgroundColor = .white
        return cv
    }()
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        //  searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.delegate = self
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "Search project by name"
        searchBar.tintColor = .black
        return searchBar
    }()
    
    
}
