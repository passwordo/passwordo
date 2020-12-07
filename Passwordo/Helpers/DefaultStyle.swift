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
        
        public static var text: UIColor = {
            if #available(iOS 13, *) {
                return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
                    if UITraitCollection.userInterfaceStyle == .dark {
                        /// Return the color for Dark Mode
                        return UIColor.white
                    } else {
                        /// Return the color for Light Mode
                        return UIColor.black
                    }
                }
            } else {
                /// Return a fallback color for iOS 12 and lower.
                return UIColor.black
            }
        }()
    
    public static var smallText: UIColor = {
        if #available(iOS 13, *) {
            return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
                if UITraitCollection.userInterfaceStyle == .dark {
                    /// Return the color for Dark Mode
                    return UIColor.lightGray
                } else {
                    /// Return the color for Light Mode
                    return UIColor.darkGray
                }
            }
        } else {
            /// Return a fallback color for iOS 12 and lower.
            return UIColor.darkGray
        }
    }()
        
    }
