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
    
    let sPath = "Settings.plist"
    let kPath = "Values.plist"
    var userSettings: [String] = ["Default"] {
        didSet {
            saveSettings()
        }
    }
    
    var valuesDict = [String : [Double]]() {
        didSet {
            saveValues()
        }
    }
    
    func documentDirectoty() -> URL {
      let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return path[0]
    }
    // get file path url
    func dataFilePath(pathName: String) -> URL {
        return documentDirectoty().appendingPathComponent(pathName)
        
    }
    func saveSettings() {
        //encode; write to data
        let encoder = PropertyListEncoder()
        do {
      let data = try encoder.encode(self.userSettings)
            let path = dataFilePath(pathName: sPath)
       try data.write(to: path , options: .atomic)
        } catch {
            print("Encoding userSettings error: \(error)")
        }
    }
    func saveValues() {
        let encoder = PropertyListEncoder()
        do {
       let data = try encoder.encode(self.valuesDict)
            let path = dataFilePath(pathName: kPath)
            try data.write(to: path, options: .atomic)
        } catch {
            print("Encoding valueDict error: \(error)")
        }
    }
    func loadSettings() {
        // decode; get data
        let decoder = PropertyListDecoder()
        let path = dataFilePath(pathName: sPath)
        do {
        let data = try Data(contentsOf: path)
       self.userSettings = try decoder.decode([String].self, from: data)
        } catch {
            print("Decoding userSettings error: \(error.localizedDescription)")
        }
    }
    func loadValues() {
        // decode; get data
        let decoder = PropertyListDecoder()
        let path = dataFilePath(pathName: kPath)
        do {
            let data = try Data(contentsOf: path)
            self.valuesDict = try decoder.decode([String : [Double]].self, from: data)
        } catch {
            print("Decoding userSettings error: \(error.localizedDescription)")
        }
    }
    
    func addToSetting(str: String) {
        userSettings.append(str)
    }
    func getSettings() -> [String] {
        return self.userSettings
    }
    func addToValueDict(from key: String, val0: Double, val1: Double, val2: Double, val3: Double, val4: Double, val5: Double) {
        
        self.valuesDict[key] = [val0, val1, val2, val3, val4, val5]
    }
    func getVals() -> [String : [Double]] {
        return self.valuesDict
    }
  
}
