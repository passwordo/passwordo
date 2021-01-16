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
    
    var websites =  ["https://superpages.com","https://tandfonline.com","https://tass.ru","https://techradar.com","https://teksty-pesenok.ru","https://telegraph.co.uk","https://the-village.ru","https://thefreedictionary.com","https://theguardian.com","https://thesun.co.uk","https://theverge.com","https://time.com","https://tinkoff.ru","https://tiu.ru","https://tomsk.ru","https://tonkosti.ru","https://tourister.ru","https://travelask.ru","https://tripadvisor.com","https://trud.com","https://ts-parfum.ru","https://tumblr.com","https://tut.by","https://tutu.ru","https://twitter.com","https://ucoz.ru","https://urbandictionary.com","https://usatoday.com","https://usnews.com","https://vc.ru","https://vedomosti.ru","https://vesti.ru","https://vimeo.com","https://vk.com","https://vl.ru","https://vokrug.tv","https://walmart.com","https://washingtonpost.com","https://wattpad.com","https://wayfair.com","https://wday.ru","https://webmd.com","https://weebly.com","https://wikimedia.org","https://wikipedia.org","https://wikireading.ru","https://wikiwand.com","https://wiktionary.org","https://wildberries.ru","https://wish.com","https://wordpress.com","https://wsj.com","https://yahoo.com","https://yandex.ru","https://yell.ru","https://yelp.com","https://youla.ru","https://yourdictionary.com","https://youtube.com","https://yumpu.com","https://zachestnyibiznes.ru","https://zakupka.com","https://zillow.com","https://ziprecruiter.com","https://znanija.com","https://zomato.com","https://zoominfo.com","https://zoon.ru"   ]
    
    
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
