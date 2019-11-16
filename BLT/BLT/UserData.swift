//
//  UserData.swift
//  BLT
//
//  Created by Jiahua Chen on 11/10/19.
//  Copyright © 2019 BLT App. All rights reserved.
//

import Foundation

class UserData {
    
    var itemTypeList: [String]
    
    func addItemType(type: String) {
        itemTypeList.append(type)
    }
    
    func itemTypeListToString()-> String{
        var val: String = ""
        for i in itemTypeList {
            val = val + i
        }
        return val
    }
    func SaveList()
    {
        let documentsDirectory =
            FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let archiveURL = documentsDirectory.appendingPathComponent("list_test").appendingPathExtension("plist")
        
        let propertyListEncoder = PropertyListEncoder()
        let encodedList = try? propertyListEncoder.encode(itemTypeList)
        try? encodedList?.write(to: archiveURL,
            options: .noFileProtection)
        
        
    }
    
    init() {
        self.itemTypeList = []
    }
}
