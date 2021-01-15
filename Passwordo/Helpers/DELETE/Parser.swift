//
//  Parser.swift
//  Passwordo
//
//  Created by Boris Goncharov on 1/6/21.
//  Copyright © 2021 Boris Goncharov. All rights reserved.
//

import Foundation
import FavIcon
import TLDExtract

class Parser {
    
    var timer: Timer?
    
    var websites =  ["https://core.ac.uk","https://cosmo.ru","https://couponxoo.com","https://culture.ru","https://cyberleninka.ru","https://dailymail.co.uk","https://dailymotion.com","https://deal.by","https://depositphotos.com","https://desertcart.com","https://detmir.ru","https://deviantart.com","https://dictionary.com","https://digitaltrends.com","https://dnb.com","https://dns-shop.ru","https://dp73.spb.ru","https://drive2.ru","https://drom.ru","https://dtf.ru","https://dw.com","https://e-katalog.ru","https://e1.ru","https://ebay.com","https://ek.ua","https://eldorado.ru","https://elibrary.ru","https://epicentrk.ua","https://espn.com","https://etsy.com","https://europa.eu","https://facebook.com","https://fandom.com","https://farpost.ru","https://film.ru","https://findglocal.com","https://flamp.ru","https://flickr.com","https://flipkart.com","https://fontanka.ru","https://forbes.ru","https://foursquare.com","https://garant.ru","https://gazeta.ru","https://genius.com","https://gettyimages.com","https://github.com","https://glosbe.com","https://go.com","https://goodhousekeeping.com"]
    
    
    func parseIcons() {
        
        
        for item in websites {
            
            let url = URL(string: item)!
            let imageName = nameForImage(url: item)

                do {
                    try FavIcon.downloadPreferred(url, width: 512, height: 512) { result in
                        if case let .success(image) = result {
                            
                            FilesHandling.saveImage(image: image, withName: imageName)
                        } else if case .failure(_) = result {
                            print("error")
                        }
                    }
                } catch {
                    print(error)
                }
        }
        
        self.timer?.invalidate()
        
        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { (_) in
            print("timer")
        })
    }
    
    
    func nameForImage(url: String) -> String {
        let extractor = try! TLDExtract(useFrozenData: true)
        guard let result: TLDResult = extractor.parse(url) else { return "" }
        return result.secondLevelDomain ?? ""
    }
    
}
