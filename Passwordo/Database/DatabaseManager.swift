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
    
    func saveToDataBase(item: MPassword) {
        let realm: Realm = try! Realm()
        
        try! realm.write {
            realm.add(item)
        }
//       print(Realm.Configuration.defaultConfiguration.fileURL)
    }
    
    func all() -> Results<MPassword> {
        let realm: Realm = try! Realm()
        return realm.objects(MPassword.self).sorted(byKeyPath: "itemName", ascending: true)
    }

}
