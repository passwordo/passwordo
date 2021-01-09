//
//  Button.swift
//  Passwordo
//
//  Created by Boris Goncharov on 1/7/21.
//  Copyright © 2021 Boris Goncharov. All rights reserved.
//

import UIKit

@IBDesignable
public class Button: UIButton {
    @IBInspectable public var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }
    @IBInspectable public var borderWidth:CGFloat = 0 {
        didSet {
        layer.borderWidth = borderWidth
        }
    }
    @IBInspectable public var cornerRadius:CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
}
