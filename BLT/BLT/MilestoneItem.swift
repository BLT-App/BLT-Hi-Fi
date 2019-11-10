//
//  MilestoneItem.swift
//  BLT
//
//  Created by Jiahua Chen on 11/10/19.
//  Copyright © 2019 BLT App. All rights reserved.
//

import Foundation

class MilestoneItem: ToDoItem {
    var milestones: [Milestone]
    
    init(className: String, title: String, description: String,
         dueDate: Date, completed: Bool, milestones: [Milestone]) {
        
        self.milestones = milestones
        super.init(className: className, title: title, description: description,
                   dueDate: dueDate, completed: completed)
        
    }
}
