//
//  SettingsViewController.swift
//  BLT
//
//  Created by DLG on 11/11/19.
//  Copyright © 2019 BLT App. All rights reserved.
//

import UIKit

var globalData = UserData()

class SettingsViewController: UIViewController {
    
    
    @IBOutlet weak var testLabel: UILabel!
    @IBOutlet weak var itemTypeEntry: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    @IBAction func enterItemType(_ sender: UIButton) {
        if (itemTypeEntry.text == nil) {
            globalData.addItemType(type: itemTypeEntry.text!)
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
