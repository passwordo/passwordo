//
//  IconCases.swift
//  Passwordo
//
//  Created by Boris Goncharov on 1/4/21.
//  Copyright © 2021 Boris Goncharov. All rights reserved.
//

import Foundation


enum WebSite: String {
    case vk = "vk"
    case apple = "apple"
    case google = "google"
    case amazon = "amazon"
    
    func printDirection() -> String {
        return self.rawValue
    }
}
