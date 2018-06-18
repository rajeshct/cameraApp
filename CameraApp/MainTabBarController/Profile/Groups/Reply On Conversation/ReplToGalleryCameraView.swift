//
//  ReplToGalleryCameraView.swift
//  CameraApp
//
//  Created by Jeevan chandra on 30/05/18.
//  Copyright © 2018 JEEVAN TIWARI. All rights reserved.
//

import UIKit

class ReplyToGalleryCameraView: UIView{

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        translatesAutoresizingMaskIntoConstraints = false
        addViews()
    }

    func addViews(){
        addSubview(camerButton)
        addSubview(galleryButton)

        camerButton.anchorToTop(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil)
        camerButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5).isActive = true

        galleryButton.anchorToTop(top: topAnchor, left: camerButton.rightAnchor, bottom: bottomAnchor, right: rightAnchor)

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    lazy var camerButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(#imageLiteral(resourceName: "cameraImageblack").withRenderingMode(.alwaysOriginal), for: .normal)
        btn.backgroundColor = .lightGray
        return btn
    }()

    lazy var galleryButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(#imageLiteral(resourceName: "galleryImage").withRenderingMode(.alwaysOriginal), for: .normal)
        btn.backgroundColor = .lightGray
        return btn
    }()


}
