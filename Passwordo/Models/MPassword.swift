//
//  MPassword.swift
//  Passwordo
//
//  Created by Boris Goncharov on 7/12/20.
//  Copyright © 2020 Boris Goncharov. All rights reserved.
//

import Foundation
import UIKit

struct MPassword {
    var itemName: String
    var userName: String
    var password: String
    var serviceURL: UIImage?
    
    init(itemName: String, userName: String, password: String, serviceURL: UIImage) {
        self.itemName = itemName
        self.userName = userName
        self.password = password
        self.serviceURL = serviceURL
    }
}
