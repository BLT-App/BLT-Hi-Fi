//
//  ListViewController.swift
//  BLT
//
//  Created by Jiahua Chen on 11/10/19.
//  Copyright © 2019 BLT App. All rights reserved.
//

import UIKit

var myToDoList: ToDoList = ToDoList()

class ListViewController: UIViewController {
    
    var deleteListIndexPath: IndexPath? = nil

    @IBOutlet weak var addTaskButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        /// Debug only!
        
        myToDoList = createExampleList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if (myToDoList.list.count != tableView.numberOfRows(inSection: 0)) {
            insertNewTask()
        }
    }
    
    func insertNewTask() {
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.beginUpdates()
        tableView.insertRows(at: [indexPath], with: .right)
        tableView.endUpdates()
    }
    
    /// Creates example content for the ToDoList
    func createExampleList() -> ToDoList {
        let tempList = ToDoList()
        
        tempList.list.append(ToDoItem(className: "Math", title: "Complete Calculus Homework", description: "Discover Calculus pg. 103 - 120", dueDate: Date(), completed: false))
        tempList.list.append(ToDoItem(className: "English", title: "Read Dalloway", description: "Page 48 - 64", dueDate: Date(), completed: false))
        tempList.list.append(ToDoItem(className: "Computer Science", title: "Complete Lo-Fi Prototype", description: "Use Invision and upload to Canvas", dueDate: Date(), completed: false))
        tempList.list.append(ToDoItem(className: "Supreme Court", title: "Brief Rucho", description: "Read Rucho v United States and write brief", dueDate: Date(), completed: false))
        tempList.list.append(ToDoItem(className: "Photo", title: "Print photos", description: "Print and mount pieces from last week", dueDate: Date(), completed: false))
        tempList.list.append(ToDoItem(className: "Econ", title: "Read Unit 7", description: "Read Unit 7 and respond to prompt online", dueDate: Date(), completed: false))
        tempList.list.append(ToDoItem(className: "Philosophy", title: "Paine", description: "Read Paine's Common Sense from Philosophy reader", dueDate: Date(), completed: false))
        
        return tempList
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myToDoList.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let toDoItem = myToDoList.list[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath) as! ToDoTableViewCell
        
        cell.setItem(item: toDoItem)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteListIndexPath = indexPath
            let itemToDelete = myToDoList.list[indexPath.row]
            confirmDelete(itemToDelete)
        }
    }
    
    func confirmDelete(_ itemToDelete: ToDoItem) {
        let alert = UIAlertController(title: "Delete To-Do Item", message: "Are you sure you want to delete the item \(itemToDelete.title)?", preferredStyle: .actionSheet)
        let DeleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: handleDeleteItem)
        let CancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: cancelDeleteItem)
        
        alert.addAction(DeleteAction)
        alert.addAction(CancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func handleDeleteItem(alertAction: UIAlertAction!) {
        if let indexPath = deleteListIndexPath {
            myToDoList.list.remove(at: indexPath.row)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .left)
            tableView.endUpdates()
            
            deleteListIndexPath = nil
        }
    }
    
    func cancelDeleteItem(alertAction: UIAlertAction!) {
        deleteListIndexPath = nil
    }
}
