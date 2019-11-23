//
//  UserData.swift
//  BLT
//
//  Created by Jiahua Chen on 11/10/19.
//  Copyright © 2019 BLT App. All rights reserved.
//

import Foundation

/**
 A class that stores user data. 
 */
class UserData: Codable {
    
    var subjectList: [String]
    var wantsListByDate: Bool
    var firstName: String
    var lastName: String
    
    func addSubject(name: String) {
        self.subjectList.append(name)
        saveUserData()
    }
    
    func saveUserData() {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let archiveURL = documentsDirectory.appendingPathComponent("userSettings").appendingPathExtension("plist")
        let propertyListEncoder = PropertyListEncoder()
        let encodedNote = try? propertyListEncoder.encode(self)
        try? encodedNote?.write(to: archiveURL, options: .noFileProtection)
    }
    
    func retrieveUserData() {
        let propertyListDecoder = PropertyListDecoder()
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let archiveURL = documentsDirectory.appendingPathComponent("userSettings").appendingPathExtension("plist")
        if let retrievedNoteData = try? Data(contentsOf: archiveURL), let decodedUserData = try? propertyListDecoder.decode(UserData.self, from: retrievedNoteData) {
            self.subjectList = decodedUserData.subjectList
            self.firstName = decodedUserData.firstName
            self.lastName = decodedUserData.lastName
            self.wantsListByDate = decodedUserData.wantsListByDate
        }
    }
    
    init() {
        subjectList = []
        wantsListByDate = true
        firstName = ""
        lastName = ""
        retrieveUserData()
        if subjectList.count == 0 {
            subjectList = ["Science", "Math", "Computer Science"]
        }
        

    }
}
