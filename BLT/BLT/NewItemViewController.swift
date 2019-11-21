//
//  NewItemViewController.swift
//  BLT
//
//  Created by Jiahua Chen on 11/10/19.
//  Copyright © 2019 BLT App. All rights reserved.
//

import UIKit
import iOSDropDown

class NewItemViewController: UIViewController, UITextFieldDelegate  {

    /// textfield with drop down add on
    @IBOutlet weak var classText: DropDown!
    
    /// Text field for the title of the ToDoItem
    @IBOutlet weak var titleText: UITextField!
    
    /// Text field for the description of the ToDoitem
    @IBOutlet weak var descText: UITextField!
    
    /// Date picker for the due date.
    @IBOutlet weak var datePicker: UIDatePicker!
    
    // variable used for obtaining value in drop down menu
    var selected: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        globalData.retrieveUserData()
        
        // sets up the menu with options from userData
        classText.optionArray = globalData.subjectList
        
        //obtains the string value of the selected item in the menu
        classText.didSelect { (Selected, index, id) in (self.selected = Selected)
            
        }
        
    }

    /// Exits the modal view/screen. 
    @IBAction func exitButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    /// Checks if the titles are correct, then adds it to the list.
    //let classTxt = classText.text
    @IBAction func addButton(_ sender: UIButton) {
        if let titleTxt = titleText.text, let descTxt = descText.text {
            // Debug for clearing/resetting entire list.
            if (titleTxt == "clear_entire_list") {
                myToDoList.list = []
                myToDoList.storeList()
                
            }
            else if (titleTxt != "" && descTxt != "") {
                let newToDo = ToDoItem(className: selected, title: titleTxt, description: descTxt, dueDate: datePicker.date, completed: false)
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
    
    //Tell Text Fields To Close On Hitting Enter
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        if textField == self.classText {
//            self.titleText.becomeFirstResponder()
//        }
        if textField == self.titleText {
            self.descText.becomeFirstResponder()
        } else {
            self.view.endEditing(true)
        }
        return false
    }

}
