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
                try FavIcon.downloadPreferred(url) { [self] result in
                    if case let .success(image) = result {
                        
                        saveImg = image
                        
//                            saveImg = cropToBounds(image: image, width: 50, height: 50)
                        
                        
                        guard Cache.saveToCache(image: saveImg!, imageID: imageName) else { return }
                        complition()
                    } else if case .failure(_) = result {
                        generateImageForItem(itemName: itemName, with: imageName)
                        complition()
                    }
                    
                }
            } catch {
                generateImageForItem(itemName: itemName, with: imageName)
                complition()
            }
        } else {
            generateImageForItem(itemName: itemName, with: imageName)
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
            Cache.saveToCache(image: saveImg!, imageID: imageName)
        }
    }
    
    func cropToBounds(image: UIImage, width: Double, height: Double) -> UIImage {

            let cgimage = image.cgImage!
            let contextImage: UIImage = UIImage(cgImage: cgimage)
            let contextSize: CGSize = contextImage.size
            var posX: CGFloat = 0.0
            var posY: CGFloat = 0.0
            var cgwidth: CGFloat = CGFloat(width)
            var cgheight: CGFloat = CGFloat(height)

            // See what size is longer and create the center off of that
            if contextSize.width > contextSize.height {
                posX = ((contextSize.width - contextSize.height) / 2)
                posY = 0
                cgwidth = contextSize.height
                cgheight = contextSize.height
            } else {
                posX = 0
                posY = ((contextSize.height - contextSize.width) / 2)
                cgwidth = contextSize.width
                cgheight = contextSize.width
            }

            let rect: CGRect = CGRect(x: posX, y: posY, width: cgwidth, height: cgheight)

            // Create bitmap image from context using the rect
            let imageRef: CGImage = cgimage.cropping(to: rect)!

            // Create a new image based on the imageRef and rotate back to the original orientation
            let image: UIImage = UIImage(cgImage: imageRef, scale: image.scale, orientation: image.imageOrientation)

            return image
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
