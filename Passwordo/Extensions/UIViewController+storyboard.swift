//
//  UIViewController+storyboard.swift
//  Passwordo
//
//  Created by Boris Goncharov on 12/26/20.
//  Copyright © 2020 Boris Goncharov. All rights reserved.
//

import UIKit

extension UIViewController {
    
    internal class func instantiateFromStoryboard(_ name: String? = nil) -> Self {
        return instantiateHelper(storyboardName: name)
    }

    private class func instantiateHelper<T>(storyboardName: String?) -> T {
        let className = String(describing: self)
        let storyboard = UIStoryboard(name: storyboardName ?? className, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: className) as! T
        return vc
    }
}
