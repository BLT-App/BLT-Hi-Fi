//
//  UserData.swift
//  BLT
//
//  Created by Jiahua Chen on 11/10/19.
//  Copyright © 2019 BLT App. All rights reserved.
//

import Foundation

class UserData {
    
    var subjectList: [String]
    var wantsListByDate: Bool
    
    func addSubject(name: String) {
        self.subjectList.append(name)
    }
    
    func saveUserData() {
        let documentsDirectory =
            FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let archiveURL = documentsDirectory.appendingPathComponent("list_test").appendingPathExtension("plist")
        
        let propertyListEncoder = PropertyListEncoder()
        let encodedList = try? propertyListEncoder.encode("")
        try? encodedList?.write(to: archiveURL,
            options: .noFileProtection)
        
        
    }
    
    func retrieveUserData() {
        
    }
    
    init() {
        subjectList = [""]
        wantsListByDate = true
    }
}
