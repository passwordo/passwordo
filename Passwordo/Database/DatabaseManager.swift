//
//  DatabaseManager.swift
//  Passwordo
//
//  Created by Boris Goncharov on 12/6/20.
//  Copyright © 2020 Boris Goncharov. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

class DatabaseManager {
    
    let pass = MPassword(itemName: "Facebook", userName: "username", password: "123456", serviceURL: "https://fb.com", imageURL: "fb")
    
    let realm = try! Realm()
    
    func saveToDataBase(item: MPassword) {
        
        try! realm.write {
            realm.add(item)
        }
      // print(Realm.Configuration.defaultConfiguration.fileURL)
    }

}
