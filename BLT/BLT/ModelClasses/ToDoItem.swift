//
//  ToDoItem.swift
//  BLT
//
//  Created by Jiahua Chen on 11/10/19.
//  Copyright © 2019 BLT App. All rights reserved.
//

import Foundation

class ToDoItem {
    var title: String
    var description: String
    var dueDate: Date
    var completed: boolean
    
    init(title: String, description: String,
         dueDate: Date, completed: Boolean) {
        self.title = title
        self.description = description
        self.dueDate = dueDate
        self.completed = completed
    }
}
