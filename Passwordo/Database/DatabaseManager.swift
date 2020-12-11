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
    
    private func generateKeyIfNeeded() -> Data? {
        var key = KeychainService.load(key: "key")
        if  ((key?.isEmpty) != false) {
            key = KeychainService.generateEncryptionKey()
        }
        return key
    }
    
    func saveToDataBase(item: MPassword) {
        let key = generateKeyIfNeeded()
        let config = Realm.Configuration(encryptionKey: key)
        let realm = try! Realm(configuration: config)

        try! realm.write {
            realm.add(item)
        }
//       print(Realm.Configuration.defaultConfiguration.fileURL)
    }
    
    func all() -> Results<MPassword> {
        let key = generateKeyIfNeeded()
        let config = Realm.Configuration(encryptionKey: key)
        let realm = try! Realm(configuration: config)
        return realm.objects(MPassword.self).sorted(byKeyPath: "itemName", ascending: true)
    }
    
    func search(searchText: String) -> Results<MPassword> {
        let key = generateKeyIfNeeded()
        let config = Realm.Configuration(encryptionKey: key)
        let realm = try! Realm(configuration: config)
        return realm.objects(MPassword.self).filter("itemName CONTAINS[c] '\(searchText)' || userName CONTAINS[c] '\(searchText)'")
    }

}
