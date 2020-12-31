//
//  Cache.swift
//  Passwordo
//
//  Created by Boris Goncharov on 12/11/20.
//  Copyright © 2020 Boris Goncharov. All rights reserved.
//

import Foundation
import UIKit

class Cache {
    
    static let fileURL = FileManager.default
        .containerURL(forSecurityApplicationGroupIdentifier: "group.com.bgoncharov.Passwordo")!
        .appendingPathComponent("Library/Caches/")
    
    class func saveToCache(image: UIImage, imageID: String) -> Bool {
        guard let data = image.jpegData(compressionQuality: 1) ?? image.pngData() else {
            return false
        }
//        guard let directory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) as NSURL else {
//            return false
//        }
        do {
            try data.write(to: fileURL.appendingPathComponent("\(imageID).png"))
            return true
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
    
    class func getImageFromCache(named: String) -> UIImage? {
//        if let dir = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) {
//
//            print(URL(fileURLWithPath: fileURL.absoluteString).appendingPathComponent(named).path)
            
        return UIImage(contentsOfFile: URL(fileURLWithPath: fileURL.absoluteString).appendingPathComponent(named).path)
//        }
//        return nil
    }
    
    class func deleteFromCache(name: String) -> Bool {
        let filemanager = FileManager.default
//        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask,true)[0] as NSString
        let destination = fileURL.appendingPathComponent(name)
        do {
            try filemanager.removeItem(at: destination)
            return true
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
    
}
