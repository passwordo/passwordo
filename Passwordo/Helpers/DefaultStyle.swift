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
    
    
    public static var cellBackgroundColor: UIColor = {
        if #available(iOS 13, *) {
            return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
                if UITraitCollection.userInterfaceStyle == .dark {
                    /// Return the color for Dark Mode
                    return #colorLiteral(red: 0.1510637071, green: 0.1510637071, blue: 0.1510637071, alpha: 1)
                } else {
                    /// Return the color for Light Mode
                    return UIColor.white
                }
            }
        } else {
            /// Return a fallback color for iOS 12 and lower.
            return UIColor.darkGray
        }
    }()
        
    }
