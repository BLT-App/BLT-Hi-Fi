//
//  NewItemViewController.swift
//  BLT
//
//  Created by Jiahua Chen on 11/10/19.
//  Copyright © 2019 BLT App. All rights reserved.
//

import UIKit
import DropDown

class NewItemViewController: UIViewController {

    /// Text field for the name of the class.
    @IBOutlet weak var classText: UITextField!
    
    /// Text field for the title of the ToDoItem
    @IBOutlet weak var titleText: UITextField!
    
    /// Text field for the description of the ToDoitem
    @IBOutlet weak var descText: UITextField!
    
    /// Date picker for the due date.
    @IBOutlet weak var datePicker: UIDatePicker!
    
    /// Exiting button.
    @IBOutlet weak var exitButton: UIButton!
    
    let dropDown: DropDown = DropDown()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        exitButton.layer.cornerRadius = 15.0
        exitButton.layer.shadowColor = UIColor.blue.cgColor
        exitButton.layer.shadowOpacity = 0.2
        exitButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        exitButton.layer.shadowRadius = 5.0
        exitButton.layer.masksToBounds = false
        
        dropDown.anchorView = classText
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
        dropDown.dataSource = ["Science", "Math", "English", "Econ"]
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.classText.text = item
        }
    }
    
    /// Exits the modal view/screen. 
    @IBAction func exitButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    /// Checks if the titles are correct, then adds it to the list.
    @IBAction func addButton(_ sender: UIButton) {
        if let classTxt = classText.text, let titleTxt = titleText.text, let descTxt = descText.text {
            // Debug for clearing/resetting entire list.
            if (titleTxt == "clear_entire_list") {
                myToDoList.list = []
                myToDoList.storeList()
            } else if (classTxt != "" && titleTxt != "") {
                let newToDo = ToDoItem(className: classTxt, title: titleTxt, description: descTxt, dueDate: datePicker.date, completed: false)
                myToDoList.list.insert(newToDo, at: 0)
                myToDoList.storeList()
                
                
                //If Users Have it Set, Sort List By Due Date
                if globalData.wantsListByDate {
                    myToDoList.sortList()
                }
            }
            self.dismiss(animated: true, completion: nil)
            
        }
    }
    
    @IBAction func showDropDown(_ sender: Any) {
        dropDown.show()
    }
    
    @IBAction func hideDropDown(_ sender: UITextField) {
        dropDown.hide()
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
