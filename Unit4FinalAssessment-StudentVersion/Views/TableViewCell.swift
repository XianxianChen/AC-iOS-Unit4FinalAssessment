//
//  TableViewCell.swift
//  Unit4FinalAssessment-StudentVersion
//
//  Created by C4Q on 1/12/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    var currentProperty: AnimationProperty!
    
    lazy var label: UILabel = {
        let lab = UILabel()
        return lab
    }()
    lazy var stepper: UIStepper = {
        let step = UIStepper()
        return step
    }()
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: "settingCell")
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
        setupLabel()
        setupStepper()
    }
    private func setupLabel() {
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5).isActive = true
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    private func setupStepper() {
        addSubview(stepper)
        stepper.translatesAutoresizingMaskIntoConstraints = false
        stepper.trailingAnchor.constraint(equalTo:trailingAnchor).isActive = true
         stepper.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    func configureCell(from property: AnimationProperty) {
        self.currentProperty = property
         self.currentProperty.value = stepper.value
        stepper.minimumValue = property.stepperMin
        stepper.maximumValue = property.stepperMax
        stepper.value = property.startingStepperVal
        stepper.stepValue = property.stepperIncrement
        
        label.text = "\(currentProperty.name.rawValue):  \(stepper.value)"
        stepper.addTarget(self, action: #selector(stepperValueChanged), for: .valueChanged)
    }
    
    @objc func stepperValueChanged(_ sender: UIStepper) {
        
        label.text = "\(currentProperty.name.rawValue): \(stepper.value)"
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

