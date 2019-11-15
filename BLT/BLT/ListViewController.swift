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
    @IBOutlet weak var waterView: UIView!
    @IBOutlet weak var tableContainerView: UIView!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var addButton: UIButton!
    var wave: SPWaterProgressIndicatorView = SPWaterProgressIndicatorView()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        wave = SPWaterProgressIndicatorView(frame: waterView.bounds)
        wave.center = waterView.center
//        wave.alpha = 0.5
        waterView.addSubview(wave)
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = waterView.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        waterView.addSubview(blurEffectView)
        roundContainerView(cornerRadius: 40, view: tableContainerView, shadowView: shadowView)
        addShadow(view: shadowView, color: UIColor.gray.cgColor, opacity: 0.2, radius: 10, offset: CGSize(width: 0, height: 5))
        addShadow(view: addButton, color: UIColor.blue.cgColor, opacity: 0.1, radius: 5, offset: .zero)

        /// Debug only!
        myToDoList = createExampleList()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if (myToDoList.list.count != tableView.numberOfRows(inSection: 0)) {
            insertNewTask()
        }
    }

    func addShadow(view: UIView, color: CGColor, opacity: Float, radius: CGFloat, offset: CGSize) {
        view.layer.shadowColor = color
        view.layer.shadowOpacity = opacity
        view.layer.shadowOffset = offset
        view.layer.shadowRadius = radius
        view.layer.masksToBounds = false
    }

    func roundContainerView(cornerRadius: Double, view: UIView, shadowView: UIView) {
        let path = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = view.bounds
        maskLayer.path = path.cgPath
        view.layer.mask = maskLayer

        shadowView.layer.cornerRadius = CGFloat(cornerRadius)
        shadowView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    }

    func insertNewTask() {
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.beginUpdates()
        tableView.insertRows(at: [indexPath], with: .right)
        tableView.endUpdates()
    }

    /// Creates example content for the ToDoList


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
            myToDoList.storeList()
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
