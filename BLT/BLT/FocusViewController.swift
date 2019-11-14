//
//  SettingsViewController.swift
//  BLT
//
//  Created by LorentzenN on 11/10/19.
//  Copyright © 2019 BLT App. All rights reserved.
//

import UIKit

class FocusViewController: UIViewController {
    
    var currentTask : ToDoItem = ToDoItem(className: "", title: "", description: "", dueDate: Date(), completed: true)
    var currentTaskNum : Int = 0

    @IBOutlet weak var lblCurrentTask: UILabel!
    
    @IBOutlet weak var btnCompleteTask: UIButton!
    
    @IBOutlet weak var endFocusModeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Sets up curves
        btnCompleteTask.layer.cornerRadius = 25.0
        btnCompleteTask.layer.shadowColor = UIColor.blue.cgColor
        btnCompleteTask.layer.shadowOpacity = 0.2
        btnCompleteTask.layer.shadowOffset = CGSize(width: 0, height: 0)
        btnCompleteTask.layer.shadowRadius = 5.0
        btnCompleteTask.layer.masksToBounds = false
        
        endFocusModeButton.layer.cornerRadius = 18.0
        endFocusModeButton.layer.shadowColor = UIColor.red.cgColor
        endFocusModeButton.layer.shadowOpacity = 0.2
        endFocusModeButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        endFocusModeButton.layer.shadowRadius = 5.0
        endFocusModeButton.layer.masksToBounds = false

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        hideTabBar()
    }
    
    /// Hides or shows the Tab Bar controller
    func hideTabBar() {
        var frame = self.tabBarController?.tabBar.frame
        let height = (frame?.size.height)!
        frame?.origin.y = self.view.frame.size.height + height
        UIView.animate(withDuration: 0.5, animations: {
            self.tabBarController?.tabBar.frame = frame!
        })
    }

    func showTabBar() {
        var frame = self.tabBarController?.tabBar.frame
        let height = (frame?.size.height)!
        frame?.origin.y = self.view.frame.size.height - height
        UIView.animate(withDuration: 0.5, animations: {
            self.tabBarController?.tabBar.frame = frame!
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setCurrentTask()
    }
    
    func setCurrentTask() {
        var notFoundNextItem : Bool = true
        if(myToDoList.list.count > 0) {
            for itemNum in 0 ..< myToDoList.list.count {
                if (notFoundNextItem) {
                    if !(myToDoList.list[itemNum].completed){
                        currentTaskNum = itemNum
                        notFoundNextItem = false
                    }
                }
            }
            if !notFoundNextItem {
                currentTask = myToDoList.list[currentTaskNum]
                lblCurrentTask.text = currentTask.title
            } else {
                lblCurrentTask.text = "No Items Left Todo"
                btnCompleteTask.isEnabled = false
                btnCompleteTask.isHidden = true
            }
        }
        else {
            lblCurrentTask.text = "No Items In Todo List"
            btnCompleteTask.isEnabled = false
            btnCompleteTask.isHidden = true
        }
    }
    
    @IBAction func completeTaskPress(_ sender: UIButton) {
        myToDoList.list[currentTaskNum].completed = true
        setCurrentTask()
    }
    
    @IBAction func endFocusModeHit(_ sender: UIButton) {
        showTabBar()
        self.tabBarController?.selectedIndex = 0
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
