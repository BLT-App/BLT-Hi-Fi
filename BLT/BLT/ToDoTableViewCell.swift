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
        
        classLabel.sizeThatFits(CGSize(width: classLabel.frame.size.width, height: 30))
        
        classLabel.layer.cornerRadius = 11.0
        classLabel.clipsToBounds = true
        
        itemView.layer.cornerRadius = 20.0
        itemView.layer.shadowColor = UIColor.gray.cgColor
        itemView.layer.shadowOpacity = 0.2
        itemView.layer.shadowOffset = CGSize(width: 0, height: 4)
        itemView.layer.shadowRadius = 5.0
        itemView.layer.masksToBounds = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setItem(item: ToDoItem) {
        classLabel.text = item.className
        assignmentLabel.text = item.title
        descLabel.text = item.description
        
        dueLabel.text = item.dueString
    }
}

class InsetLabel: UILabel {
    let topInset = CGFloat(3.5)
    let bottomInset = CGFloat(3.5)
    let leftInset = CGFloat(7)
    let rightInset = CGFloat(7)

    override func drawText(in rect: CGRect) {
        let insets: UIEdgeInsets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }

    override public var intrinsicContentSize: CGSize {
        var intrinsicSuperViewContentSize = super.intrinsicContentSize
        intrinsicSuperViewContentSize.height += topInset + bottomInset
        intrinsicSuperViewContentSize.width += leftInset + rightInset
        return intrinsicSuperViewContentSize
    }
}
