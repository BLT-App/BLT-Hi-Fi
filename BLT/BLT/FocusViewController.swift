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
    
    @IBAction func completeTaskPress(_ sender: UIButton) {
        myToDoList.list[currentTaskNum].completed = true
        setCurrentTask()
    }
    
    @IBAction func endFocusModeHit(_ sender: UIButton) {
        showTabBar()
        self.tabBarController?.selectedIndex = 0
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
