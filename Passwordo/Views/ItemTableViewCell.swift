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

    public func setup() {
        textLabel?.textColor = color.Style.text
        detailTextLabel?.textColor = color.Style.smallText
        
        backgroundColor = color.Style.cellBackgroundColor
    }
    
}
