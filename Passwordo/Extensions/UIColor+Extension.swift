//
//  AppColors.swift
//  Passwordo
//
//  Created by Boris Goncharov on 12/14/20.
//  Copyright © 2020 Boris Goncharov. All rights reserved.
//

import UIKit

extension UIColor {
  struct AppColors {
    static var text: UIColor  { return UIColor.black }
    static var textDarkMode: UIColor { return UIColor.white}
    
    static var smallText: UIColor  { return UIColor.lightGray }
    static var smallTextDarkMode: UIColor { return UIColor.darkGray }
    
    static var cellBackgroundColor: UIColor  { return UIColor.white }
    static var cellBackgroundColorDarkMode: UIColor { return #colorLiteral(red: 0.1098039216, green: 0.1098039216, blue: 0.1176470588, alpha: 1) }
    
    static var sectionHeaderBackground: UIColor  { return #colorLiteral(red: 0.9529411765, green: 0.9490196078, blue: 0.968627451, alpha: 1) }
    static var sectionHeaderBackgroundDarkMode: UIColor { return UIColor.black }
    
    static var mainBackground: UIColor  { return #colorLiteral(red: 0.9529411765, green: 0.9490196078, blue: 0.968627451, alpha: 1) }
    static var mainBackgroundDarkMode: UIColor { return UIColor.black }
    
  }
}
