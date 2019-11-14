//
//  ToDoItem.swift
//  BLT
//
//  Created by Jiahua Chen on 11/10/19.
//  Copyright © 2019 BLT App. All rights reserved.
//

import Foundation

class ToDoItem: Codable {
    var className: String
    var title: String
    var description: String
    var dueDate: Date
    var dueCounter: Int {
        let calendar = NSCalendar.current
        let dueDay = calendar.startOfDay(for: dueDate)
        let nowDay = calendar.startOfDay(for: Date())
        let inBetween = calendar.dateComponents([.day], from: nowDay, to: dueDay).day
        return inBetween!
    }
    
    var dueString: String {
        if (dueCounter == 0) {
            return "Due today"
        } else if (dueCounter < 0) {
            return "Due \(abs(dueCounter)) days ago"
        } else {
            return "Due in \(dueCounter) days"
        }
    }

    var completed: Bool
    
    init(from: Decodable, className: String, title: String, description: String,
         dueDate: Date, completed: Bool) {
        self.className = className
        self.title = title
        self.description = description
        self.dueDate = dueDate
        self.completed = completed
    }
    
    init(className: String, title: String, description: String,
         dueDate: Date, completed: Bool) {
        self.className = className
        self.title = title
        self.description = description
        self.dueDate = dueDate
        self.completed = completed
    }
}

extension ToDoItem: Comparable {
    static func < (lhs: ToDoItem, rhs: ToDoItem) -> Bool {
        return lhs.dueCounter < rhs.dueCounter
    }
    
    static func == (lhs: ToDoItem, rhs: ToDoItem) -> Bool {
        return lhs.dueCounter == rhs.dueCounter
    }
}
