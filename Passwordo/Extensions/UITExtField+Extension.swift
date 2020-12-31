//
//  UITExtField+Extension.swift
//  Passwordo
//
//  Created by Boris Goncharov on 12/16/20.
//  Copyright © 2020 Boris Goncharov. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    
    static let color = DefaultStyle()
    
    func setIcon(_ image: UIImage) {
        let iconView = UIImageView(frame: CGRect(x: 20, y: -10, width: 48, height: 48))
        iconView.image = image
        iconView.layer.cornerRadius = 30
        let iconContainerView: UIView = UIView(frame: CGRect(x: 20, y: 0, width: 80, height: 30))
        iconContainerView.addSubview(iconView)
        leftView = iconContainerView
        leftViewMode = .always
    }
    
    func setTextInRow() {
        backgroundColor = UITextField.color.Style.color(mainColor: UIColor.AppColors.cellBackgroundColor, darkModeCorlor: UIColor.AppColors.cellBackgroundColorDarkMode)
        let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 20.0, height: 2.0))
        self.leftView = leftView
        leftViewMode = .always
    }
}

