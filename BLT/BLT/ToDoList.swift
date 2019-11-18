//
//  ToDoList.swift
//  BLT
//
//  Created by Jiahua Chen on 11/10/19.
//  Copyright © 2019 BLT App. All rights reserved.
//

import Foundation

/**
 A class that represents entire lists of to-do. This is what is stored into storage by the system.
 */
class ToDoList: Codable {
    /// The list of to-do items. 
    var list: [ToDoItem]
    
    /// Initializer from decodable.
    init(from:Decodable) {
        self.list = []
    }
    
    /// Initializer.
    init() {
        self.list = []
    }
    
    /// Adds example tasks to the to do list, for example funcionality.
    func createExampleList() {
        self.list.append(ToDoItem(className: "Math", title: "Complete Calculus Homework", description: "Discover Calculus pg. 103 - 120", dueDate: Date(), completed: false))
        self.list.append(ToDoItem(className: "English", title: "Read Dalloway", description: "Page 48 - 64", dueDate: Date(), completed: false))
        self.list.append(ToDoItem(className: "Computer Science", title: "Complete Lo-Fi Prototype", description: "Use Invision and upload to Canvas", dueDate: Date(), completed: false))
        self.list.append(ToDoItem(className: "Supreme Court", title: "Brief Rucho", description: "Read Rucho v United States and write brief", dueDate: Date(), completed: false))
        self.list.append(ToDoItem(className: "Photo", title: "Print photos", description: "Print and mount pieces from last week", dueDate: Date(), completed: false))
        self.list.append(ToDoItem(className: "Econ", title: "Read Unit 7", description: "Read Unit 7 and respond to prompt online", dueDate: Date(), completed: false))
        self.list.append(ToDoItem(className: "Philosophy", title: "Paine", description: "Read Paine's Common Sense from Philosophy reader", dueDate: Date(), completed: false))
    }
    
    /// Stores the ToDoList into local storage.
    func storeList() {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let archiveURL = documentsDirectory.appendingPathComponent("todolist").appendingPathExtension("plist")
        let propertyListEncoder = PropertyListEncoder()
        
        let encodedNote = try? propertyListEncoder.encode(self)
        try? encodedNote?.write(to: archiveURL, options: .noFileProtection)
    }
    
    /// Retrieves the ToDoList from local storage.
    func retrieveList() {
        let propertyListDecoder = PropertyListDecoder()
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let archiveURL = documentsDirectory.appendingPathComponent("todolist").appendingPathExtension("plist")
        if let retrievedNoteData = try? Data(contentsOf: archiveURL), let decodedToDoList = try? propertyListDecoder.decode(ToDoList.self, from: retrievedNoteData) {
            self.list = decodedToDoList.list
        }
    }
    
    /// Sorts the ToDoList.
    func sortList() {
        list = list.sorted()
    }
}
