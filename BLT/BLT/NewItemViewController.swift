//
//  NewItemViewController.swift
//  BLT
//
//  Created by Jiahua Chen on 11/10/19.
//  Copyright © 2019 BLT App. All rights reserved.
//

import UIKit

class NewItemViewController: UIViewController {

    @IBOutlet weak var classText: UITextField!
    
    @IBOutlet weak var titleText: UITextField!
    
    @IBOutlet weak var descText: UITextField!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func exitButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addButton(_ sender: UIButton) {
        if let classTxt = classText.text, let titleTxt = titleText.text, let descTxt = descText.text {
            if (titleTxt == "clear_entire_list") {
                myToDoList.list = []
                myToDoList.storeList()
            } else if (classTxt != "" && titleTxt != "") {
                let newToDo = ToDoItem(className: classTxt, title: titleTxt, description: descTxt, dueDate: datePicker.date, completed: false)
                myToDoList.list.insert(newToDo, at: 0)
                myToDoList.storeList()
//                Commented out sortList as it reorders all pages on home screen. Should have a specific prompt to sort list instead.
//                myToDoList.sortList()
            }
            self.dismiss(animated: true, completion: nil)
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
