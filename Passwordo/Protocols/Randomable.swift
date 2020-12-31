//
//  Randomable.swift
//  Passwordo
//
//  Created by Boris Goncharov on 12/24/20.
//  Copyright © 2020 Boris Goncharov. All rights reserved.
//

import Foundation
import UIKit

protocol Randomable {
    
}

extension Randomable where Self: UIViewController {
    func randomString(length: Int) -> String {
      let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
      return String((0..<length).map{ _ in letters.randomElement()! })
    }
}
