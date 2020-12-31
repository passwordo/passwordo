//
//  NamePictureCell.swift
//  Passwordo
//
//  Created by Boris Goncharov on 12/17/20.
//  Copyright © 2020 Boris Goncharov. All rights reserved.
//

import UIKit

class NamePictureCell: UITableViewCell {
    
    @IBOutlet weak var nameTextField: UITextField?
    @IBOutlet weak var pictureImageView: UIImageView?
    
    let color = DefaultStyle()
    
    var item: CheckoutViewModelItem? {
        didSet {
            guard let item = item as? CheckoutViewModelNamePicture else { return }
            nameTextField?.text = item.name
            nameTextField?.isEnabled = false
            pictureImageView?.image = item.image
            backgroundColor = color.Style.color(mainColor: UIColor.AppColors.cellBackgroundColor, darkModeCorlor: UIColor.AppColors.cellBackgroundColorDarkMode)
            
            pictureImageView?.layer.cornerRadius = 8
        }
    }
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    
        
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        pictureImageView?.image = nil
    }
}
