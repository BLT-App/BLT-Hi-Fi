//
//  ItemViewController.swift
//  BLT
//
//  Created by Jiahua Chen on 11/18/19.
//  Copyright © 2019 BLT App. All rights reserved.
//

import UIKit

class ItemViewController: UIViewController {
    
    var delegate: UIViewController?
    var targetIndex: Int?

    @IBOutlet weak var exitButton: UIButton!
    @IBOutlet weak var classNameField: UITextField!
    @IBOutlet weak var assignmentField: UITextField!
    
    @IBOutlet weak var descriptionField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        exitButton.layer.cornerRadius = 15.0
        exitButton.layer.shadowColor = UIColor.blue.cgColor
        exitButton.layer.shadowOpacity = 0.2
        exitButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        exitButton.layer.shadowRadius = 5.0
        exitButton.layer.masksToBounds = false

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadPage()
    }
    
    func loadPage() {
        if let thisIndex = targetIndex {
            let thisToDo = myToDoList.list[thisIndex]
            classNameField.text = thisToDo.className
            assignmentField.text = thisToDo.title
            descriptionField.text = thisToDo.description
            
        }
    }
    
    
    
    
    @IBAction func backButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
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
