//
//  Model.swift
//  Unit4FinalAssessment-StudentVersion
//
//  Created by C4Q on 1/12/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import Foundation
class Model {
    private init() {}
    static let manager = Model()
    
    var userSettings: [String] = ["Default"]
    var valuesDict = [String : [Double]]()
    func addToSetting(str: String) {
        userSettings.append(str)
    }
    func getSettings() -> [String] {
        return self.userSettings
    }
    func addToValueDict(from key: String, val0: Double, val1: Double, val2: Double, val3: Double, val4: Double) {
        
        self.valuesDict[key] = [val0, val1, val2, val3, val4]
    }
    func getVals() -> [String : [Double]] {
        return self.valuesDict
    }
  
}
