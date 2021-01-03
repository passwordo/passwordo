//
//  Cache.swift
//  Passwordo
//
//  Created by Boris Goncharov on 12/11/20.
//  Copyright © 2020 Boris Goncharov. All rights reserved.
//

import Foundation
import UIKit

class FilesHandling {
    
    static let fileURL = FileManager.default
        .containerURL(forSecurityApplicationGroupIdentifier: "group.com.bgoncharov.Passwordo")!
        .appendingPathComponent("Library/Caches/")
    
    class func saveImage(image: UIImage, withName: String) {
        guard let data = image.jpegData(compressionQuality: 1) ?? image.pngData() else {
            return
        }
        do {
            try data.write(to: fileURL.appendingPathComponent("\(withName).png"))
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    class func getImage(withName: String) -> UIImage? {
            return UIImage(contentsOfFile: URL(fileURLWithPath: fileURL.absoluteString).appendingPathComponent(withName).path)
    }
    
    class func deleteImage(withName: String) {
        let filemanager = FileManager.default
        let destination = fileURL.appendingPathComponent(withName)
        do {
            try filemanager.removeItem(at: destination)
        } catch {
            print(error.localizedDescription)
        }
    }
}
