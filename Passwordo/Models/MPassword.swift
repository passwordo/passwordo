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
    var serviceURL: String
    var imageURL: String?
    
    init(itemName: String, userName: String, password: String, serviceURL: String, imageURL: String) {
        self.itemName = itemName
        self.userName = userName
        self.password = password
        self.serviceURL = serviceURL
        self.imageURL = imageURL
    }
}
