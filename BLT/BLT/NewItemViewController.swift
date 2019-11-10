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
        self.dismiss(animated: true)
    }
    
    @IBAction func addButton(_ sender: UIButton) {
        if let classTxt = classText.text, let titleTxt = titleText.text, let descTxt = descText.text {
            let newToDo = ToDoItem(className: classTxt, title: titleTxt, description: descTxt, dueDate: datePicker.date, completed: false)
            myToDoList.list.insert(newToDo, at: 0)
            self.dismiss(animated: true)
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
