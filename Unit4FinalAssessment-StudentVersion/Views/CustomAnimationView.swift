//
//  CustomAnimationView.swift
//  Unit4FinalAssessment-StudentVersion
//
//  Created by C4Q on 1/12/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class CustomAnimationView: UIView {
    lazy var imageView: UIImageView = {
        let imv = UIImageView()
        imv.contentMode = .scaleAspectFit
        imv.image = #imageLiteral(resourceName: "snowman")
        return imv
    }()
    lazy var pickerView: UIPickerView = {
        let picker = UIPickerView()
        return picker
    }()
    lazy var button: UIButton = {
        let butt = UIButton()
        butt.backgroundColor = .black
        return butt
    }()
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    private func commonInit() {
        backgroundColor = .white
        setUpViews()
    }
    private func setUpViews() {
        setupImageView()
        setupButton()
        setupPickerView()
    }
     func setupImageView() {
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -50).isActive = true
        imageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3).isActive = true
        imageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5).isActive = true
    }
    private func setupPickerView() {
        addSubview(pickerView)
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        pickerView.topAnchor.constraint(equalTo: centerYAnchor, constant: 30).isActive = true
        pickerView.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -18).isActive = true
        pickerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        pickerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 20).isActive = true
    }
    private func setupButton() {
        addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 18).isActive = true
    }
   

}
