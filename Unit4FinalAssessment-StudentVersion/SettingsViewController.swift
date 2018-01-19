//
//  SettingsViewController.swift
//  Unit4FinalAssessment-StudentVersion
//
//  Created by C4Q  on 1/11/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

enum PropertyName: String {
    case widthMultiplier = "Width Multiplier"
    // Add other PropertyName Cases
    case heightMultipiler = "Height Multiplier"
    case horizontalOffset = "Horizontal Offset"
    case verticalOffset = "Vertical Offset"
    case numberOfFlips = "Number of Flips"
    case duration = "Duration"
}

struct AnimationProperty {
    let name: PropertyName
    let stepperMin: Double
    let stepperMax: Double
    let stepperIncrement: Double
    let startingStepperVal: Double
    var value: Double
    var tag: Int
}

class SettingsViewController: UIViewController {

    //TO DO: Add more properties
//    var stepVals: [[Double]] = [[0, 0], [0, 0],[0]] {
//        didSet {
//            self.tableView.reloadData()
//        }
//    }
   
    var properties: [[AnimationProperty]] =
    [
        [AnimationProperty(name: .widthMultiplier, stepperMin: 0.1, stepperMax: 1.8, stepperIncrement: 0.1, startingStepperVal: 1.0, value: 1.0, tag: 1),
         AnimationProperty(name: .heightMultipiler, stepperMin: 0.1, stepperMax: 1.8, stepperIncrement: 0.1, startingStepperVal: 1.0, value: 1.0, tag: 2)],
        [AnimationProperty(name: .horizontalOffset, stepperMin: -100, stepperMax: 80.0, stepperIncrement: 1.0, startingStepperVal: 0.0, value: 0.0, tag: 3),
         AnimationProperty(name: .verticalOffset, stepperMin: -100, stepperMax: 80.0, stepperIncrement: 1.0, startingStepperVal: 0.0, value: 0.0, tag: 4)],
        [AnimationProperty(name: .numberOfFlips, stepperMin: 1, stepperMax: 20, stepperIncrement: 1.0, startingStepperVal: 1.0, value: 1.0, tag: 5),
         AnimationProperty(name: .duration, stepperMin: 0.1, stepperMax: 10, stepperIncrement: 0.5, startingStepperVal: 1.0, value: 1.0, tag: 6)
            ]
        ]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        navigationItem.title = "Settings"
       navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(addSetting))
        layoutTableView()
    }
    
    @objc func addSetting() {
        let alert = UIAlertController(title: "Add Setting", message: "enter a name for your setting", preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        let textField = alert.textFields![0]
        textField.delegate = self
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
     
        let okAction = UIAlertAction(title: "OK", style: .default, handler: {(UIAlertAction) in
            guard textField.text != nil, textField.text != "" else {return}
            Model.manager.addToSetting(str: textField.text!)
            self.addValueToDefault(keyStr: textField.text!)
            print("================")
            print("add \(textField.text!) to setting")
        })
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
     
    }
    func addValueToDefault(keyStr: String) {
//        for i in 0..<properties.count {
//            for j in 0..<properties[i].count {
//      UserDefaults.standard.setValue(properties[i][j].value, forKey: keyStr + properties[i][j].name.rawValue)
//        print(keyStr + properties[i][j].name.rawValue)
//        }
//    }
      Model.manager.addToValueDict(from: keyStr, val0: properties[0][0].value, val1: properties[0][1].value, val2: properties[1][0].value, val3: properties[1][1].value, val4: properties[2][0].value, val5: properties[2][1].value)
        
    }
    
    @objc func stepperValueChanged(_ sender: UIStepper) {
        switch sender.tag {
        case 1:
            properties[0][0].value = sender.value
        case 2:
             properties[0][1].value = sender.value
        case 3:
             properties[1][0].value = sender.value
        case 4:
             properties[1][1].value = sender.value
        case 5:
             properties[2][0].value = sender.value
        case 6:
             properties[2][1].value = sender.value
        default:
            break
        }
        tableView.reloadData()
      
    }
    
    func layoutTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
    
    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.dataSource = self
        tv.delegate = self
        //Register your subclass
        tv.register(TableViewCell.self, forCellReuseIdentifier: "settingCell")
        return tv
    }()
}
extension SettingsViewController: UITextFieldDelegate {
    
}

extension SettingsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return properties.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //TO DO: Implement your Custom Cell that has a stepper
        let property = properties[indexPath.section][indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingCell", for: indexPath) as! TableViewCell
      //  cell.configureCell(from: property)
        cell.stepper.minimumValue = property.stepperMin
        cell.stepper.maximumValue = property.stepperMax
        cell.stepper.value = property.value
        cell.stepper.stepValue = property.stepperIncrement
        cell.stepper.tag = property.tag
        
        cell.label.text = "\(property.name.rawValue):  \(cell.stepper.value)"
        cell.stepper.addTarget(self, action: #selector(stepperValueChanged), for: .valueChanged)
        cell.stepper.isEnabled = true
        
     //   properties[indexPath.section][indexPath.row].value = cell.stepper.value
      //  cell.label.text = "\(property.name.rawValue): \(cell.stepper.value)"
        
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return properties[section].count
    }
}

extension SettingsViewController: UITableViewDelegate {
   
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Size Settings"
        case 1:
            return "Position Settings"
        default:
            return "Other Settings"
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}











