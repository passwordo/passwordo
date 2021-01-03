//
//  ItemTableViewCell.swift
//  Passwordo
//
//  Created by Boris Goncharov on 11/24/20.
//  Copyright © 2020 Boris Goncharov. All rights reserved.
//

import UIKit
import FavIcon

class ItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemDetailLabel: UILabel!
    var itemId: String!
    
    let color = DefaultStyle()
    let mainVC = MainVC()

    public func setup() {
        textLabel?.textColor = color.Style.color(mainColor: UIColor.AppColors.text , darkModeCorlor: UIColor.AppColors.textDarkMode)
        detailTextLabel?.textColor = color.Style.color(mainColor: UIColor.AppColors.smallText , darkModeCorlor: UIColor.AppColors.smallTextDarkMode)
        backgroundColor = color.Style.color(mainColor: UIColor.AppColors.cellBackgroundColor , darkModeCorlor: UIColor.AppColors.cellBackgroundColorDarkMode)
    }

    
    func setupCell(item: MPassword) {
        itemNameLabel?.text = item.itemName
        itemDetailLabel?.text = item.userName
        itemImage?.layer.cornerRadius = 6
        itemImage?.layer.masksToBounds = true
        
        var id = item.serviceURL
        let vowels: Set<Character> = ["/", "\\", ":", ";"]
        id.removeAll(where: { vowels.contains($0) })
        itemImage?.image = FilesHandling.getImage(withName: item.imageURL)
        self.itemId = item.id
    }
}
