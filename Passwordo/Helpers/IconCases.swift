//
//  IconCases.swift
//  Passwordo
//
//  Created by Boris Goncharov on 1/4/21.
//  Copyright © 2021 Boris Goncharov. All rights reserved.
//

import Foundation


enum IconCases: String {
    case vk = "vk"
    case apple = "apple"
    case google = "google"
    case amazon = "amazon"
    case dribbble = "dribbble"
    case nasa = "nasa"
    case netflix = "netflix"
    case samsung = "samsung"
    
    func returnDirection() -> String {
        return self.rawValue
    }
}
