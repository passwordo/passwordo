//
//  MPassword.swift
//  Passwordo
//
//  Created by Boris Goncharov on 7/12/20.
//  Copyright © 2020 Boris Goncharov. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class MPassword: Object {
    
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var itemName: String = ""
    
    @objc dynamic var userName: String = ""
    @objc dynamic var passwordString: String = ""
    @objc dynamic var serviceURL: String = ""
    @objc dynamic var imageURL: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    var image: UIImage {
            let scale = UIScreen.main.scale

            let frame = CGRect(x: 0, y: 0, width: 36 * scale, height: 36 * scale)

            let label = UILabel(frame: frame)
            label.textAlignment = .center
            label.backgroundColor = .lightGray
            label.textColor = .white
            label.font = UIFont.boldSystemFont(ofSize: 28 * scale)
            label.text = String(itemName[itemName.startIndex]).uppercased()

            UIGraphicsBeginImageContext(frame.size)
            let context = UIGraphicsGetCurrentContext()
            label.layer.render(in: context!)
            let image = UIGraphicsGetImageFromCurrentImageContext()!
            return UIImage(cgImage: image.cgImage!, scale: scale, orientation: .up)
        }
    
    convenience init(itemName: String, userName: String, password: String, serviceURL: String, imageURL: String) {
        self.init()
        self.itemName = itemName
        
        self.userName = userName
        self.passwordString = password
        self.serviceURL = serviceURL
        self.imageURL = imageURL
    }
}
