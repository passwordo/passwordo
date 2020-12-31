//
//  DataModelDelegate.swift
//  Passwordo
//
//  Created by Boris Goncharov on 12/17/20.
//  Copyright © 2020 Boris Goncharov. All rights reserved.
//

import Foundation

protocol DataModelDelegate: class {
    func didRecieveDataUpdate(data: MPassword)
}
