//
//  ItemTableViewCell.swift
//  Passwordo
//
//  Created by Boris Goncharov on 11/24/20.
//  Copyright © 2020 Boris Goncharov. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell {
    
    let color = DefaultStyle()
    
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemLoginLabel: UILabel!
    
    public func setup() {
        itemNameLabel.textColor = color.Style.text
        itemLoginLabel.textColor = color.Style.smallText
    }
    
}
