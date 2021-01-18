//
//  CredentialTableViewCell.swift
//  AutoFill_Extension
//
//  Created by Boris Goncharov on 12/29/20.
//  Copyright © 2020 Boris Goncharov. All rights reserved.
//

import Foundation
import UIKit

class CredentialTableViewCell: UITableViewCell {
    
    @IBOutlet weak var itemImage: UIImageView!
    
    @IBOutlet weak var itemFerstLabel: UILabel!
    
    @IBOutlet weak var itemSecondLabel: UILabel!
    
    func setupCell(item: MPassword) {
        itemFerstLabel?.text = item.itemName
        itemSecondLabel?.text = "\(item.serviceURL) - \(item.userName)"
        itemImage?.layer.cornerRadius = 6
        itemImage?.layer.masksToBounds = true

        itemImage?.image = FilesHandling.getImage(withName: item.imageURL)
    }
    
}
