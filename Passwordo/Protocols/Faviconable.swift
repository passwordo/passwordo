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
import TLDExtract

protocol Faviconable {
    
}

extension Faviconable where Self: UIResponder {
    
    func downloadFaviconForUrl(for url: String, with itemName: String, imageName: String, complition: @escaping () -> Void) -> UIImage {
        
//        var saveImg: UIImage?
//
//        let existingImage = setUpExsistingImage(for: url, name: itemName)
//
//        if existingImage != nil  {
//            saveImg = existingImage
////            FilesHandling.saveImage(image: saveImg!, withName: imageName)
//            complition()
//            return saveImg!
//        } else {
//
//            var id = itemName
//            let vowels: Set<Character> = ["/", "\\", ":", ";"]
//            id.removeAll(where: { vowels.contains($0)})
//
//            if urlIsValid(urlString: url) && internetIsEnable() {
//                do {
//                    try FavIcon.downloadPreferred(url, width: 256, height: 256) { [self] result in
//                        if case let .success(image) = result {
//
//                            saveImg = image
//
////                            FilesHandling.saveImage(image: saveImg!, withName: imageName)
//                            complition()
//                        } else if case .failure(_) = result {
//                            saveImg = generateImageForItem(itemName: itemName, with: imageName)
//                            complition()
//                        }
//                    }
//                } catch {
//                    if !itemName.isEmpty {
//                        saveImg = generateImageForItem(itemName: itemName, with: imageName)
//                    } else {
////                        FilesHandling.saveImage(image: UIImage(named: "noimage")!, withName: imageName)
//                    }
//                    complition()
//                    return saveImg!
//                }
//            } else {
//                if !itemName.isEmpty {
//                    saveImg = generateImageForItem(itemName: itemName, with: imageName)
//                } else {
////                    FilesHandling.saveImage(image: UIImage(named: "noimage")!, withName: imageName)
//                    return UIImage(named: "noimage")!
//                }
//                complition()
////                return saveImg!
//            }
//            return saveImg ?? UIImage(named: "noimage")!
//        }
        return UIImage()
    }
    
    
    func generateImageForItem(itemName: String, with imageName: String) -> UIImage {
        var saveImg: UIImage?
        
        if itemName != "" {
            let exicstingImage = setUpExsistingImage(for: nil, name: itemName)
            
            if exicstingImage != nil {
//                FilesHandling.saveImage(image: exicstingImage!, withName: imageName)
                return exicstingImage!
            }
            
            
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
//            FilesHandling.saveImage(image: saveImg!, withName: imageName)
            
        }
        return saveImg ?? UIImage(named: "noimage")!
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
    
    private func parseDomainName(url: String) -> String {
        let extractor = try! TLDExtract(useFrozenData: true)
        guard let result: TLDResult = extractor.parse(url) else { return "" }
        return result.secondLevelDomain ?? ""
    }
    
    private func setUpExsistingImage(for url: String?, name: String) -> UIImage? {
        var returnImage: UIImage?
        var icon: String?

        if url != nil && internetIsEnable() {
            let name = parseDomainName(url: url!)
            icon = IconCases.RawValue(name).description
        } else {
            icon = IconCases.RawValue(name.lowercased()).description
        }

        if icon != nil {
            returnImage = UIImage(named: icon!)
            return returnImage
        }
        return nil
    }
}
