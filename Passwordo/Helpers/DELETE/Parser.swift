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
    
    var websites =  ["https://1tv.ru","https://123rf.com","https://24smi.org","https://2gis.ru","https://3dnews.ru","https://4pda.ru","https://academic.ru","https://afisha.ru","https://agoda.com","https://aif.ru","https://airbnb.com","https://alamy.com","https://alibaba.com","https://aliexpress.com","https://aliradar.com","https://amazon.com","https://apnews.com","https://apple.com","https://asktel.ru","https://au.ru","https://auto.ru","https://avito.ru","https://babyblog.ru","https://banki.ru","https://barnesandnoble.com","https://bbb.org","https://bbc.co.uk","https://bbc.com","https://beru.ru","https://bestbuy.com","https://bigl.ua","https://birdeye.com","https://blizko.ru","https://bloomberg.com","https://bolshoyvopros.ru","https://booking.com","https://britannica.com","https://business-gazeta.ru","https://businessinsider.com","https://businesswire.com","https://bustle.com","https://buzzfeed.com","https://ca.gov","https://cbslocal.com","https://cdc.gov","https://championat.com","https://chicagotribune.com","https://chitai-gorod.ru","https://chron.com","https://cian.ru","https://citilink.ru","https://city-data.com","https://cnbc.com","https://cnet.com","https://cnn.com","https://cntd.ru","https://consultant.ru","https://core.ac.uk","https://cosmo.ru","https://couponxoo.com","https://culture.ru","https://cyberleninka.ru","https://dailymail.co.uk","https://dailymotion.com","https://deal.by","https://depositphotos.com","https://desertcart.com","https://detmir.ru","https://deviantart.com","https://dictionary.com","https://digitaltrends.com","https://dnb.com","https://dns-shop.ru","https://dp73.spb.ru","https://drive2.ru","https://drom.ru","https://dtf.ru","https://dw.com","https://e-katalog.ru","https://e1.ru","https://ebay.ca","https://ebay.co.uk","https://ebay.com","https://ebay.com.au","https://ebay.de","https://ek.ua","https://eldorado.ru","https://elibrary.ru","https://epicentrk.ua","https://espn.com","https://etsy.com","https://europa.eu","https://facebook.com","https://fandom.com","https://farpost.ru","https://film.ru","https://findglocal.com","https://flamp.ru","https://flickr.com","https://flipkart.com","https://fontanka.ru","https://forbes.ru","https://foursquare.com","https://garant.ru","https://gazeta.ru","https://genius.com","https://gettyimages.com","https://github.com","https://glosbe.com","https://go.com","https://goodhousekeeping.com","https://goodreads.com","https://goods.ru","https://google.co.uk","https://google.com","https://google.ru","https://gorodrabot.ru","https://gramho.com","https://groupon.com","https://habr.com","https://harvard.edu","https://healthline.com","https://hh.ru","https://homedepot.com","https://hotels.com","https://hotline.ua","https://houzz.com","https://hse.ru","https://huffpost.com","https://imdb.com","https://imgur.com","https://indeed.com","https://independent.co.uk","https://indiamart.com","https://indiatimes.com","https://infourok.ru","https://insider.com","https://instagram.com","https://instructables.com","https://interfax.ru","https://irecommend.ru","https://issuu.com","https://ivi.ru","https://ixbt.com","https://iz.ru","https://izi.ua","https://jobsearcher.com","https://jooble.org","https://joom.com","https://jstor.org","https://justdial.com","https://kartaslov.ru","https://kino-teatr.ru","https://kinopoisk.ru","https://kohls.com","https://kommersant.ru","https://kp.ru","https://kudago.com","https://labirint.ru","https://latimes.com","https://legacy.com","https://lenta.ru","https://leroymerlin.ru","https://lifehacker.ru","https://linguee.com","https://list-org.com","https://litres.ru","https://liveinternet.ru","https://livejournal.com","https://livelib.ru","https://livemaster.ru","https://loopnet.com","https://lowes.com","https://m24.ru","https://macys.com","https://mail.ru","https://mayoclinic.org","https://medium.com","https://meduza.io","https://merriam-webster.com","https://microsoft.com","https://mk.ru","https://mos.ru","https://mskobr.ru","https://msn.com","https://msu.ru","https://mvideo.ru","https://my-shop.ru","https://narod.ru","https://nature.com","https://nbcnews.com","https://ndtv.com","https://newsbreak.com","https://ngs.ru","https://nih.gov","https://novayagazeta.ru","https://npr.org","https://nsportal.ru","https://nv.ua","https://nytimes.com","https://ok.ru","https://olx.ua","https://onliner.by","https://onlinetrade.ru","https://otzovik.com","https://oup.com","https://over-blog.com","https://overstock.com","https://ozon.ru","https://patch.com","https://pcmag.com","https://picclick.com","https://picuki.com","https://pikabu.ru","https://pinterest.at","https://pinterest.ca","https://pinterest.ch","https://pinterest.cl","https://pinterest.co.kr","https://pinterest.co.uk","https://pinterest.com","https://pinterest.com.au","https://pinterest.com.mx","https://pinterest.de","https://pinterest.dk","https://pinterest.es","https://pinterest.fr","https://pinterest.ie","https://pinterest.it","https://pinterest.ph","https://pinterest.ru","https://pinterest.se","https://popsugar.com","https://poshmark.com","https://price.ua","https://prnewswire.com","https://prodoctorov.ru","https://prom.ua","https://psu.edu","https://qaz.wiki","https://quizlet.com","https://quora.com","https://qwe.wiki","https://rambler.ru","https://rbc.ru","https://realtor.com","https://redbubble.com","https://reddit.com","https://redfin.com","https://regmarkets.ru","https://regnum.ru","https://researchgate.net","https://reuters.com","https://reverso.net","https://rg.ru","https://ria.ru","https://rozetka.com.ua","https://rt.com","https://rusprofile.ru","https://sbis.ru","https://screenrant.com","https://scribd.com","https://sears.com","https://semanticscholar.org","https://sfgate.com","https://shopee.com.my","https://sima-land.ru","https://simplyhired.com","https://slideshare.net","https://soundcloud.com","https://spark-interfax.ru","https://sports.ru","https://spotify.com","https://spr.ru","https://springer.com","https://stackexchange.com","https://stackoverflow.com","https://studfile.net","https://study.com","https://superjob.ru","https://superpages.com","https://tandfonline.com","https://tass.ru","https://techradar.com","https://teksty-pesenok.ru","https://telegraph.co.uk","https://the-village.ru","https://thefreedictionary.com","https://theguardian.com","https://thesun.co.uk","https://theverge.com","https://time.com","https://tinkoff.ru","https://tiu.ru","https://tomsk.ru","https://tonkosti.ru","https://tourister.ru","https://travelask.ru","https://tripadvisor.ca","https://tripadvisor.co.nz","https://tripadvisor.co.uk","https://tripadvisor.com","https://tripadvisor.com.hk","https://tripadvisor.ru","https://trud.com","https://ts-parfum.ru","https://tumblr.com","https://tut.by","https://tutu.ru","https://twitter.com","https://ucoz.ru","https://urbandictionary.com","https://usatoday.com","https://usnews.com","https://vc.ru","https://vedomosti.ru","https://vesti.ru","https://vimeo.com","https://vk.com","https://vl.ru","https://vokrug.tv","https://walmart.ca","https://walmart.com","https://washingtonpost.com","https://wattpad.com","https://wayfair.com","https://wday.ru","https://webmd.com","https://weebly.com","https://wikimedia.org","https://wikipedia.org","https://wikireading.ru","https://wikiwand.com","https://wiktionary.org","https://wildberries.ru","https://wish.com","https://wordpress.com","https://wsj.com","https://yahoo.com","https://yandex.by","https://yandex.com","https://yandex.kz","https://yandex.ru","https://yell.ru","https://yelp.com","https://youla.ru","https://yourdictionary.com","https://youtube.com","https://yumpu.com","https://zachestnyibiznes.ru","https://zakupka.com","https://zillow.com","https://ziprecruiter.com","https://znanija.com","https://zomato.com","https://zoominfo.com","https://zoon.ru"]
    
    
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
