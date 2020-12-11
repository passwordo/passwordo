//
//  KeychainService.swift
//  Passwordo
//
//  Created by Boris Goncharov on 12/11/20.
//  Copyright © 2020 Boris Goncharov. All rights reserved.
//

import Foundation
import Security
import CryptoKit

class KeychainService: NSObject {
    
    class func generateEncryptionKey() -> Data {
        let key = Curve25519.KeyAgreement.PrivateKey()
        let publicKey = key.rawRepresentation
        KeychainService.save(key: "key", data: publicKey)
        print(publicKey)
        return publicKey
    }
    
    class func save(key: String, data: Data) -> OSStatus {
            let query = [
                kSecClass as String       : kSecClassGenericPassword as String,
                kSecAttrAccount as String : key,
                kSecValueData as String   : data ] as [String : Any]

            SecItemDelete(query as CFDictionary)

            return SecItemAdd(query as CFDictionary, nil)
        }
    
    class func load(key: String) -> Data? {
            let query = [
                kSecClass as String       : kSecClassGenericPassword,
                kSecAttrAccount as String : key,
                kSecReturnData as String  : kCFBooleanTrue!,
                kSecMatchLimit as String  : kSecMatchLimitOne ] as [String : Any]

            var dataTypeRef: AnyObject? = nil

            let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)

            if status == noErr {
                return dataTypeRef as! Data?
            } else {
                return nil
            }
        }
    
}
