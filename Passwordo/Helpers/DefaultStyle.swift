//
//  Colors.swift
//  Passwordo
//
//  Created by Boris Goncharov on 12/4/20.
//  Copyright © 2020 Boris Goncharov. All rights reserved.
//

import UIKit

class DefaultStyle {
    
    public let Style = DefaultStyle.self

    public static func setColor (mainColor: UIColor, darkModeCorlor: UIColor) -> UIColor {
        if #available(iOS 13, *) {
            return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
                if UITraitCollection.userInterfaceStyle == .dark {
                    /// Return the color for Dark Mode
                    return darkModeCorlor
                } else {
                    /// Return the color for Light Mode
                    return mainColor
                }
            }
        } else {
            /// Return a fallback color for iOS 12 and lower.
            return mainColor
        }
    }
}
