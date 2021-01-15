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

public class DatabaseManager {
        
    static let fileURL = FileManager.default
        .containerURL(forSecurityApplicationGroupIdentifier: "group.com.bgoncharov.Passwordo")!
        .appendingPathComponent("Library/Caches/default.realm")
    
    static func generateKeyIfNeeded() -> Data? {
        var key = KeychainService.load(key: "key")
        if  ((key?.isEmpty) == true) {
            key = KeychainService.generateEncryptionKey()
        }
        return key
    }
    
    static func saveToDataBase(item: MPassword) {
        let key = generateKeyIfNeeded()
        let config = Realm.Configuration(fileURL: fileURL, encryptionKey: key, deleteRealmIfMigrationNeeded: true)
        let realm = try! Realm(configuration: config)
        
        try! realm.write {
            realm.add(item)
        }
    }
    
    static func deleteFromDataBase(item: MPassword) {
        let key = generateKeyIfNeeded()
        let config = Realm.Configuration(fileURL: fileURL, encryptionKey: key, deleteRealmIfMigrationNeeded: true)
        let realm = try! Realm(configuration: config)
        
        FilesHandling.deleteImage(withName: "\(item.imageURL).png")
        
        try! realm.write {
            realm.delete(item)
        }
    }
    
    static func all() -> Results<MPassword> {
        let key = generateKeyIfNeeded()
        let config = Realm.Configuration(fileURL: fileURL, encryptionKey: key, deleteRealmIfMigrationNeeded: true)
        let realm = try! Realm(configuration: config)
        
//        print(Realm.Configuration.defaultConfiguration.fileURL)
        print(fileURL)
        
        return realm.objects(MPassword.self).sorted(byKeyPath: "itemName", ascending: true)
    }
    
    static func allExtension() -> Results<MPassword> {
        let key = generateKeyIfNeeded()
        let config = Realm.Configuration(fileURL: fileURL, encryptionKey: key, deleteRealmIfMigrationNeeded: true)
        let realm = try! Realm(configuration: config)
        
        return realm.objects(MPassword.self).sorted(byKeyPath: "itemName", ascending: true)
    }
    
    static func search(searchText: String) -> Results<MPassword> {
        let key = generateKeyIfNeeded()
        let config = Realm.Configuration(fileURL: fileURL, encryptionKey: key, deleteRealmIfMigrationNeeded: true)
        let realm = try! Realm(configuration: config)
        return realm.objects(MPassword.self).filter("itemName CONTAINS[c] '\(searchText)' || userName CONTAINS[c] '\(searchText)' || id CONTAINS[c] '\(searchText)'")
    }
    
    static func updateItem(id: String, forKey: String , newValue: String) {
        let key = generateKeyIfNeeded()
        let config = Realm.Configuration(fileURL: fileURL, encryptionKey: key, deleteRealmIfMigrationNeeded: true)
        let realm = try! Realm(configuration: config)
        let item = realm.objects(MPassword.self).filter("id == '\(id)'").first
        try! realm.write {
            if forKey == "itemName" {
                item?.itemName = newValue
            }
            if forKey == "serviceURL" {
                item?.serviceURL = newValue
            }
            if forKey == "userName" {
                item?.userName = newValue
            }
            if forKey == "passwordString" {
                item?.passwordString = newValue
            }
        }
    }
}
