//
//  Faviconable.swift
//  Passwordo
//
//  Created by Boris Goncharov on 12/12/20.
//  Copyright © 2020 Boris Goncharov. All rights reserved.
//

import Foundation
import UIKit
import FavIcon
import Network

protocol Faviconable {
    
}

extension Faviconable where Self: UIResponder {
    
    func downloadFaviconForUrl(for url: String, with itemName: String, imageName: String, complition: @escaping () -> Void) {

        var saveImg: UIImage?
        
        var id = itemName
        let vowels: Set<Character> = ["/", "\\", ":", ";"]
        id.removeAll(where: { vowels.contains($0)})
        
        if urlIsValid(urlString: url) && internetIsEnable() {
            do {
                try FavIcon.downloadPreferred(url, width: 256, height: 256) { [self] result in
                    if case let .success(image) = result {
                        
                        saveImg = image
                        
                        FilesHandling.saveImage(image: saveImg!, withName: imageName)
                        complition()
                    } else if case .failure(_) = result {
                        generateImageForItem(itemName: itemName, with: imageName)
                        complition()
                    }
                    
                }
            } catch {
                if !itemName.isEmpty {
                    generateImageForItem(itemName: itemName, with: imageName)
                } else {
                    FilesHandling.saveImage(image: UIImage(named: "noimage")!, withName: imageName)
                }
                complition()
            }
        } else {
            if !itemName.isEmpty {
                generateImageForItem(itemName: itemName, with: imageName)
            } else {
                FilesHandling.saveImage(image: UIImage(named: "noimage")!, withName: imageName)
            }
            complition()
        }
    }
    
    
    func generateImageForItem(itemName: String, with imageName: String) {
        if itemName != "" {
            var saveImg: UIImage?
            
            let scale = UIScreen.main.scale
            
            let frame = CGRect(x: 0, y: 0, width: 36 * scale, height: 36 * scale)
            
            let label = UILabel(frame: frame)
            label.textAlignment = .center
            label.backgroundColor = #colorLiteral(red: 0.7848496785, green: 0.9406532519, blue: 0.9205730495, alpha: 0.9811351852)
            label.textColor = .black
            label.font = UIFont.boldSystemFont(ofSize: 28 * scale)
            label.text = String(itemName[itemName.startIndex]).uppercased()
            
            UIGraphicsBeginImageContext(frame.size)
            let context = UIGraphicsGetCurrentContext()
            label.layer.render(in: context!)
            let image = UIGraphicsGetImageFromCurrentImageContext()!
            saveImg = UIImage(cgImage: image.cgImage!, scale: scale, orientation: .up)
            FilesHandling.saveImage(image: saveImg!, withName: imageName)
        }
    }
    
    func urlIsValid (urlString: String?) -> Bool {
        if let urlString = urlString {
            if let url = NSURL(string: urlString) {
                return UIApplication.shared.canOpenURL(url as URL)
            }
        }
        return false
    }
    
    
    private func internetIsEnable() -> Bool {
        if ReachabilityTest.isConnectedToNetwork() {
            return true
        }
        else{
            return false
        }
    }
    
}
