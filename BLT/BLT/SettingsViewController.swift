//
//  SettingsViewController.swift
//  BLT
//
//  Created by DLG on 11/11/19.
//  Copyright © 2019 BLT App. All rights reserved.
//

import UIKit

var globalData = UserData()

class SettingsViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var btnProfile: UIButton!
    @IBOutlet weak var btnList: UIButton!
    @IBOutlet weak var currentMenuTable: UITableView!
    
    var currentMenu: String = "profile"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        currentMenu = "profile"
        loadCurrentMenu()
    }
    
    func loadCurrentMenu() {
        if(currentMenu == "profile") {
            loadProfileMenu()
        }
        if(currentMenu == "list") {
            loadListMenu()
        }
    }
    
    func loadProfileMenu() {
        btnProfile.isSelected = true
        print("Profile Menu Set")
        currentMenuTable.numberOfRows(inSection: 0)
    }
    
    func loadListMenu() {
        btnList.isSelected = true
        print("List Menu Set")
    }
    
    @IBAction func profileChosen(_ sender: UIButton) {
        currentMenu = "profile"
        loadCurrentMenu()
    }
    @IBAction func listChosen(_ sender: UIButton) {
        currentMenu = "list"
        loadCurrentMenu()
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Ask for a cell of the appropriate type.
        let cell = tableView.dequeueReusableCell(withIdentifier: "basicStyleCell", for: indexPath)
        
        // Configure the cell’s contents with the row and section number.
        // The Basic cell style guarantees a label view is present in textLabel.
        cell.textLabel!.text = "Row \(indexPath.row)"
        return cell
    }
    
}
