//
//  ToDoTableViewCell.swift
//  BLT
//
//  Created by Jiahua Chen on 11/10/19.
//  Copyright © 2019 BLT App. All rights reserved.
//

import UIKit

class ToDoTableViewCell: UITableViewCell {

    @IBOutlet weak var classLabel: UILabel!
    @IBOutlet weak var assignmentLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var dueLabel: UILabel!
    
    @IBOutlet weak var itemView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        classLabel.layer.cornerRadius = 10.0
        classLabel.clipsToBounds = true
        
        itemView.layer.cornerRadius = 20.0
        itemView.layer.shadowColor = UIColor.gray.cgColor
        itemView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        itemView.layer.shadowRadius = 4.0
        itemView.layer.shadowOpacity = 0.6
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setItem(item: ToDoItem) {
        classLabel.text = item.className
        assignmentLabel.text = item.title
        descLabel.text = item.description
        dueLabel.text = item.dueDate.description
    }
}
