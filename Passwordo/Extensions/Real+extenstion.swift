//
//  Real+extenstion.swift
//  Passwordo
//
//  Created by Boris Goncharov on 12/28/20.
//  Copyright © 2020 Boris Goncharov. All rights reserved.
//

import UIKit
import RealmSwift

extension Realm {
    
    static func forAppGroup() throws -> Realm {
        let fileURL = FileManager.default
            .containerURL(forSecurityApplicationGroupIdentifier: "com.bgoncharov.Passwordo")!
            .appendingPathComponent("Library/Caches/default.realm")
        
        let configuration = Realm.Configuration(fileURL: fileURL)
        
        return try Realm(configuration: configuration)
    }
    
}
