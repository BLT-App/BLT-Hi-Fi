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
    
    init() {
        self.itemTypeList = []
    }
}
