//
//   createProjectController.swift
//  DemoApp
//
//  Created by Jeevan chandra on 13/04/18.
//  Copyright © 2018 Jeevan chandra. All rights reserved.
//

import UIKit

class EditProjectTaskController: UIViewController{


    var editProject: ProjectListModel?{
        didSet{
            prefillValues()
        }
    }
    
    var delegate: ProjectController?
    var startDate: Date?
    var endDate: Date?
    var projectAssignIds: String?
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addViews()
        setupNavigationController()
    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }



    
    func setupNavigationController(){
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tapGesture)

        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: #colorLiteral(red: 0.4470588235, green: 0.568627451, blue: 0.9568627451, alpha: 1)]

        if let _ = editProject{
            navigationItem.title = "Update Project"
        }else{
            navigationItem.title = "Create Project"
        }

    }
    
    lazy var projectNameTextField: UITextField = {
        let tf  = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Project Name"
        tf.borderStyle = .none
        tf.layer.backgroundColor = UIColor.white.cgColor
        tf.layer.masksToBounds = false
        tf.layer.shadowColor = UIColor.lightGray.cgColor
        tf.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        tf.layer.shadowOpacity = 1.0
        tf.layer.shadowRadius = 0.0
        tf.delegate = self
        return tf
    }()
    
    let profileNameLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Jeevan Chandra"
        lbl.textColor = .blue
        lbl.textAlignment = .center
        return lbl
    }()
    
    lazy var startDateButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("DD/MM/YYYY", for: .normal)
        btn.contentHorizontalAlignment = .left
        btn.layer.backgroundColor = UIColor.white.cgColor
        btn.layer.masksToBounds = false
        btn.imageView?.contentMode = .scaleAspectFit
        btn.layer.shadowColor = UIColor.lightGray.cgColor
        btn.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        btn.layer.shadowOpacity = 1.0
        btn.layer.shadowRadius = 0.0
        btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: UIScreen.main.bounds.height * 0.07 * 0.4 + 4, bottom: 0, right: 0)
        btn.addTarget(self, action: #selector(openCalendar(button:)), for: .touchUpInside)
        btn.setTitleColor(.black, for: .normal)
        btn.tag = 0
        return btn
    }()
    
    
    lazy var endDateButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("DD/MM/YYYY", for: .normal)
        btn.contentHorizontalAlignment = .left
        btn.imageView?.contentMode = .scaleAspectFit
        btn.layer.backgroundColor = UIColor.white.cgColor
        btn.layer.masksToBounds = false
        btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: UIScreen.main.bounds.height * 0.07 * 0.4 + 4, bottom: 0, right: 0)
        btn.layer.shadowColor = UIColor.lightGray.cgColor
        btn.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        btn.layer.shadowOpacity = 1.0
        btn.addTarget(self, action: #selector(openCalendar(button:)), for: .touchUpInside)
        btn.setTitleColor(.black, for: .normal)
        btn.layer.shadowRadius = 0.0
         btn.tag = 1
        return btn
    }()
    
    lazy var  projectAssignButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Select", for: .normal)
        btn.contentHorizontalAlignment = .left
        btn.layer.backgroundColor = UIColor.white.cgColor
        btn.layer.masksToBounds = false
        btn.layer.shadowColor = UIColor.lightGray.cgColor
        btn.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        btn.layer.shadowOpacity = 1.0
        btn.setTitleColor(.black, for: .normal)
        btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 16 + UIScreen.main.bounds.height * 0.07 * 0.4 + 8)
        btn.addTarget(self, action: #selector(hanldeProjectAssign), for: .touchUpInside)
        btn.layer.shadowRadius = 0.0
        return btn
    }()
    
    
    lazy var projectCurrencyButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("$", for: .normal)
        btn.contentHorizontalAlignment = .left
        btn.layer.backgroundColor = UIColor.white.cgColor
        btn.layer.masksToBounds = false
        btn.setTitleColor(.black, for: .normal)
        btn.layer.shadowColor = UIColor.lightGray.cgColor
        btn.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        btn.layer.shadowOpacity = 1.0
        btn.layer.shadowRadius = 0.0
        return btn
    }()

    
    
    lazy var projectBudgetButton: UITextField = {
        let tf  = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "$0.0"
        tf.borderStyle = .none
        tf.layer.backgroundColor = UIColor.white.cgColor
        tf.layer.masksToBounds = false
        tf.layer.shadowColor = UIColor.lightGray.cgColor
        tf.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        tf.layer.shadowOpacity = 1.0
        tf.keyboardType = .numberPad
        tf.layer.shadowRadius = 0.0
        tf.delegate = self
        return tf
    }()


    lazy var createProjectButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("CREATE PROJECT", for: .normal)
        btn.backgroundColor = #colorLiteral(red: 0.4470588235, green: 0.568627451, blue: 0.9568627451, alpha: 1)
        btn.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        btn.addTarget(self, action: #selector(handleSubmit), for: .touchUpInside)
        return btn
    }()

    let activityIndicator: UIActivityIndicatorView = {
        let ai = UIActivityIndicatorView()
        ai.activityIndicatorViewStyle = .white
        ai.translatesAutoresizingMaskIntoConstraints = false
        return ai
    }()
    
}


extension UILabel {
    func tempLabel(text: String) -> UILabel{
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = text
        lbl.textColor = #colorLiteral(red: 0.4470588235, green: 0.568627451, blue: 0.9568627451, alpha: 1)
        lbl.font = UIFont(name: lbl.font.fontName, size: 12)
        return lbl
    }

    func returnImage() -> UIImageView{
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = #imageLiteral(resourceName: "calendarImage")
        return iv
    }
}
