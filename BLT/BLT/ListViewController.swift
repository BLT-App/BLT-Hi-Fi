//
//  ListViewController.swift
//  BLT
//
//  Created by Jiahua Chen on 11/10/19.
//  Copyright © 2019 BLT App. All rights reserved.
//

import UIKit

/// Global ToDoList variable. 
var myToDoList: ToDoList = ToDoList()
var globalData = UserData()

class ListViewController: UIViewController {
    @IBOutlet weak var addTaskButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var waterView: UIView!
    @IBOutlet weak var tableContainerView: UIView!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var addButton: UIButton!
    var wave: SPWaterProgressIndicatorView = SPWaterProgressIndicatorView()
    
    var deleteListIndexPath: IndexPath? = nil
    
    var selectedIndex: Int = -1

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        createWave()
        
        // Programmatically sets up rounded views.
        roundContainerView(cornerRadius: 40, view: tableContainerView, shadowView: shadowView)
        addShadow(view: shadowView, color: UIColor.gray.cgColor, opacity: 0.2, radius: 10, offset: CGSize(width: 0, height: 5))
        addShadow(view: addButton, color: UIColor.blue.cgColor, opacity: 0.1, radius: 5, offset: .zero)
        
        // Loads list from filesystem
        myToDoList.retrieveList()
        
        // This creates an example list if there is nothing on the list. Debug only.
        if myToDoList.list.count == 0 {
            myToDoList.createExampleList()
        }
        
        globalData.updateCourses(fromList: myToDoList)
        
        // Sets wave completion percentage, debug only.
        wave.completionInPercent = 30
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if (myToDoList.list.count != tableView.numberOfRows(inSection: 0)) {
            insertNewTask()
        }
    }
    
    func update() {
        tableView.reloadData()
    }
    
    /**
     Creates shadows for a view.
     - parameters:
        - view: The view to add a shadow to.
        - color: The color of the shadow.
        - opacity: The opacity of the shadow.
        - radius: The radius of the shadow.
        - offset: The offset of the shadow.
     */
    func addShadow(view: UIView, color: CGColor, opacity: Float, radius: CGFloat, offset: CGSize) {
        view.layer.shadowColor = color
        view.layer.shadowOpacity = opacity
        view.layer.shadowOffset = offset
        view.layer.shadowRadius = radius
        view.layer.masksToBounds = false
    }
    
    /// Sets up wave view in the background.
    func createWave() {
        wave = SPWaterProgressIndicatorView(frame: waterView.bounds)
        wave.center = waterView.center
        wave.alpha = 0.4
        waterView.addSubview(wave)
        
//        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.regular)
//        let blurEffectView = UIVisualEffectView(effect: blurEffect)
//        blurEffectView.frame = waterView.bounds
//        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        waterView.addSubview(blurEffectView)
    }
    
    /**
     Creates a rounded container view.
     - parameters:
        - cornerRadius: The corner radius of the rounded container.
        - view: The UIView to round.
        - shadowView: The accompanying shadowView of the main view to round.
     */
    func roundContainerView(cornerRadius: Double, view: UIView, shadowView: UIView) {
        let path = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = view.bounds
        maskLayer.path = path.cgPath
        view.layer.mask = maskLayer
        
        shadowView.layer.cornerRadius = CGFloat(cornerRadius)
        shadowView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    }
    
    /// Updates and animates the insertion of a new task.
    func insertNewTask() {
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.beginUpdates()
        tableView.insertRows(at: [indexPath], with: .right)
        tableView.endUpdates()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "itemViewSegue" {
            if let destination = segue.destination as? ItemViewController {
                destination.delegate = self
                if selectedIndex != -1 {
                    destination.targetIndex = selectedIndex
                }
            }
        }
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        performSegue(withIdentifier: "itemViewSegue", sender: self)
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedItem = myToDoList.list[sourceIndexPath.row]
        myToDoList.list.remove(at: sourceIndexPath.row)
        myToDoList.list.insert(movedItem, at: destinationIndexPath.row)
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let configuration = UISwipeActionsConfiguration(actions: [contextualCompletedAction(forRowAtIndexPath: indexPath)])
        return configuration
    }
    
    func contextualCompletedAction(forRowAtIndexPath indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .normal, title: "Complete") { (contextAction: UIContextualAction, sourceView: UIView, completionHandler: (Bool) -> Void) in
            myToDoList.list.remove(at: indexPath.row)
            myToDoList.storeList()
            self.tableView.beginUpdates()
            self.tableView.deleteRows(at: [indexPath], with: .top)
            self.tableView.endUpdates()
            self.tableView.reloadData()
            completionHandler(true)
        }
        action.backgroundColor = .blue
        return action
    }
    
    /**
     Prompts a confirmation for a deletion of a ToDoItem.
     - parameters:
        - itemToDelete: The ToDoItem that is going to be deleted.
     */
    func confirmDelete(_ itemToDelete: ToDoItem) {
        let alert = UIAlertController(title: "Delete To-Do Item", message: "Are you sure you want to delete the item \(itemToDelete.title)?", preferredStyle: .actionSheet)
        let DeleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: handleDeleteItem)
        let CancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: cancelDeleteItem)
        
        alert.addAction(DeleteAction)
        alert.addAction(CancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    /**
     Handles the deletion of an item.
     */
    func handleDeleteItem(alertAction: UIAlertAction!) {
        if let indexPath = deleteListIndexPath {
            myToDoList.list.remove(at: indexPath.row)
            myToDoList.storeList()
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .left)
            tableView.endUpdates()
            
            deleteListIndexPath = nil
        }
    }
    
    /**
     Cancels the deletion of an item.
     */
    func cancelDeleteItem(alertAction: UIAlertAction!) {
        deleteListIndexPath = nil
    }
}
