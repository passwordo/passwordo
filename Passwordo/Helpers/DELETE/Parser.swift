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
    
    var websites =  ["https://apple.com","https://www.google.com","https://youtube.com","https://microsoft.com","https://www.blogger.com","https://support.google.com","https://play.google.com","https://linkedin.com","https://en.wikipedia.org","https://mozilla.org","https://cloudflare.com","https://docs.google.com","https://youtu.be","https://wordpress.org","https://maps.google.com","https://sites.google.com","https://accounts.google.com","https://googleusercontent.com","https://drive.google.com","https://europa.eu","https://adobe.com","https://vimeo.com","https://plus.google.com","https://amazon.com","https://bbc.co.uk","https://es.wikipedia.org","https://bp.blogspot.com","https://github.com","https://istockphoto.com","https://facebook.com","https://vk.com","https://uol.com.br","https://cnn.com","https://line.me","https://feedburner.com","https://forbes.com","https://bbc.com","https://dropbox.com","https://mail.ru","https://issuu.com","https://google.com.br","https://slideshare.net","https://news.google.com","https://gstatic.com","https://msn.com","https://myspace.com","https://nytimes.com","https://dailymotion.com","https://google.es","https://fr.wikipedia.org","https://reuters.com","https://medium.com","https://pt.wikipedia.org","https://developers.google.com","https://hugedomains.com","https://get.google.com","https://www.yahoo.com","https://creativecommons.org","https://wikimedia.org","https://washingtonpost.com","https://google.de","https://live.com","https://imdb.com","https://theguardian.com","https://google.fr","https://whatsapp.com","https://t.me","https://globo.com","https://paypal.com","https://policies.google.com","https://nih.gov","https://w3.org","https://mail.google.com","https://jimdofree.com","https://google.co.jp","https://opera.com","https://tinyurl.com","https://foxnews.com","https://office.com","https://harvard.edu","https://google.ru","https://amazon.co.uk","https://youronlinechoices.com","https://4shared.com","https://it.wikipedia.org","https://businessinsider.com","https://aliexpress.com","https://abcnews.go.com","https://photos.google.com","https://ig.com.br","https://amazon.de","https://picasaweb.google.com","https://aol.com","https://lefigaro.fr","https://archive.org","https://ok.ru","https://bloomberg.com","https://fb.com","https://themeforest.net","https://usatoday.com","https://indiatimes.com","https://wired.com","https://scribd.com","https://independent.co.uk","https://bing.com","https://cpanel.net","https://dan.com","https://goo.gl","https://search.google.com","https://elpais.com","https://namecheap.com","https://plesk.com","https://mirror.co.uk","https://marketingplatform.google.com","https://ipv4.google.com","https://networkadvertising.org","https://de.wikipedia.org","https://gravatar.com","https://myaccount.google.com","https://www.wix.com","https://telegram.me","https://wikia.com","https://mediafire.com","https://files.wordpress.com","https://ebay.com","https://huffingtonpost.com","https://booking.com","https://buydomains.com","https://tools.google.com","https://telegraph.co.uk","https://pinterest.com","https://rakuten.co.jp","https://cpanel.com","https://ft.com","https://change.org","https://draft.blogger.com","https://abril.com.br","https://terra.com.br","https://dailymail.co.uk","https://hatena.ne.jp","https://books.google.com","https://twitter.com","https://time.com","https://android.com","https://cnet.com","https://google.it","https://aboutads.info","https://thesun.co.uk","https://fandom.com","https://google.co.uk","https://nasa.gov","https://translate.google.com","https://cdc.gov","https://www.gov.uk","https://id.wikipedia.org","https://un.org","https://wsj.com","https://amazon.co.jp","https://webmd.com","https://news.yahoo.com","https://bit.ly","https://steampowered.com","https://who.int","https://samsung.com","https://latimes.com","https://google.pl","https://vice.com","https://netvibes.com","https://whitehouse.gov","https://finance.yahoo.com","https://rapidshare.com","https://sapo.pt","https://instructables.com","https://google.co.in","https://economist.com","https://ovh.net","https://nokia.com","https://groups.google.com","https://bp2.blogger.com","https://ovh.com","https://newsweek.com","https://noaa.gov","https://interia.pl","https://mozilla.com","https://nypost.com","https://ovh.co.uk","https://playstation.com","https://enable-javascript.com","https://ibm.com","https://weibo.com","https://lemonde.fr","https://elmundo.es","https://gizmodo.com","https://blackberry.com","https://ted.com","https://quora.com","https://list-manage.com","https://imageshack.us","https://google.com.tw","https://mysql.com","https://code.google.com","https://detik.com","https://amzn.to","https://addtoany.com","https://dw.com","https://yandex.ru","https://akamaihd.net","https://pixabay.com","https://ggpht.com","https://researchgate.net","https://instagram.com","https://asus.com","https://privacyshield.gov","https://hm.com","https://goo.ne.jp","https://nbcnews.com","https://ru.wikipedia.org","https://soundcloud.com","https://addthis.com","https://liveinternet.ru","https://shutterstock.com","https://chicagotribune.com","https://umich.edu","https://apache.org","https://abc.es","https://ytimg.com","https://bloglovin.com","https://nginx.org","https://20minutos.es","https://berkeley.edu","https://gofundme.com","https://scoop.it","https://my.yahoo.com","https://cornell.edu","https://www.over-blog.com","https://espn.com","https://rtve.es","https://theglobeandmail.com","https://google.nl","https://columbia.edu","https://000webhost.com","https://mashable.com","https://metro.co.uk","https://kickstarter.com","https://npr.org","https://spiegel.de","https://guardian.co.uk","https://cnil.fr","https://rt.com","https://nikkei.com","https://nationalgeographic.com","https://allaboutcookies.org","https://sciencemag.org","https://cambridge.org","https://yahoo.co.jp","https://ea.com","https://ikea.com","https://britannica.com","https://buzzfeed.com","https://techcrunch.com","https://ria.ru","https://nature.com","https://doubleclick.net","https://gnu.org","https://naver.com","https://cnbc.com","https://photobucket.com","https://godaddy.com","https://photos1.blogger.com","https://secureserver.net","https://hp.com","https://ietf.org","https://amazon.es","https://oup.com","https://cbsnews.com","https://bp0.blogger.com","https://stackoverflow.com","https://wp.com","https://brandbucket.com","https://goodreads.com","https://worldbank.org","https://depositfiles.com","https://nydailynews.com","https://google.co.id","https://theatlantic.com","https://sendspace.com","https://m.wikipedia.org","https://bandcamp.com","https://shopify.com","https://walmart.com","https://ign.com","https://abc.net.au","https://princeton.edu","https://yadi.sk","https://pbs.org","https://washington.edu","https://hollywoodreporter.com","https://nvidia.com","https://biglobe.ne.jp","https://sputniknews.com","https://trustpilot.com","https://yelp.com","https://adssettings.google.com","https://sciencedaily.com","https://vox.com","https://search.yahoo.com","https://forms.gle","https://yale.edu","https://sedo.com","https://ziddu.com","https://amazon.fr","https://repubblica.it","https://icann.org","https://dell.com","https://discord.gg","https://xbox.com","https://ox.ac.uk","https://tripadvisor.com","https://nicovideo.jp","https://gmail.com","https://thetimes.co.uk","https://oracle.com","https://huffpost.com","https://spotify.com","https://bitly.com","https://news.com.au","https://cbc.ca","https://disqus.com","https://standard.co.uk","https://loc.gov","https://php.net","https://nginx.com","https://greenpeace.org","https://target.com","https://storage.googleapis.com","https://netflix.com","https://naver.jp","https://t.co","https://wa.me","https://mit.edu","https://box.com","https://wiley.com","https://sciencedirect.com","https://theverge.com","https://picasa.google.com","https://newyorker.com","https://unesco.org","https://about.com","https://engadget.com","https://afternic.com","https://usnews.com","https://smh.com.au","https://mega.nz","https://alibaba.com","https://deezer.com","https://zendesk.com","https://ja.wikipedia.org","https://surveymonkey.com","https://utexas.edu","https://express.co.uk","https://corriere.it","https://sfgate.com","https://psychologytoday.com","https://pl.wikipedia.org","https://google.ca","https://skype.com","https://welt.de","https://academia.edu","https://variety.com","https://bt.com","https://disney.com","https://www.wikipedia.org","https://eventbrite.com","https://wikihow.com","https://stanford.edu","https://e-recht24.de","https://rambler.ru","https://digg.com","https://www.weebly.com","https://googleblog.com","https://twitch.tv","https://urbandictionary.com","https://so-net.ne.jp","https://imgur.com","https://gutenberg.org","https://m.me","https://investopedia.com","https://arstechnica.com","https://indiegogo.com","https://pastebin.com","https://entrepreneur.com","https://groups.yahoo.com","https://outlook.com","https://cia.gov","https://medicalnewstoday.com","https://vkontakte.ru","https://calendar.google.com","https://mhlw.go.jp","https://answers.yahoo.com","https://dreniq.com","https://sina.com.cn","https://rollingstone.com","https://cocolog-nifty.com","https://sky.com","https://inc.com","https://ca.gov","https://ucoz.ru","https://marriott.com","https://answers.com","https://billboard.com","https://thoughtco.com","https://arxiv.org","https://tabelog.com","https://fb.me","https://channel4.com","https://zdnet.com","https://iso.org","https://mystrikingly.com","https://xing.com","https://thedailybeast.com","https://viagens.com.br","https://coursera.org","https://wiktionary.org","https://imageshack.com","https://newscientist.com","https://prestashop.com","https://dribbble.com","https://about.me","https://iubenda.com","https://csmonitor.com","https://steamcommunity.com","https://adweek.com","https://offset.com","https://udemy.com","https://soratemplates.com","https://ndtv.com","https://evernote.com","https://searchenginejournal.com","https://behance.net","https://tes.com","https://usgs.gov","https://ap.org","https://axs.com","https://amazon.ca","https://house.gov","https://weforum.org","https://cisco.com","https://biblegateway.com","https://airbnb.com","https://ebay.co.uk","https://qz.com","https://fifa.com","https://ieee.org","https://a8.net","https://amazon.it","https://blog.fc2.com","https://last.fm","https://thehill.com","https://ftc.gov","https://sports.yahoo.com","https://elsevier.com","https://livescience.com","https://redhat.com","https://kinja.com","https://thestar.com","https://fastcompany.com","https://discovery.com","https://consumerreports.org","https://upenn.edu","https://slate.com","https://dreamstime.com","https://statista.com","https://calameo.com","https://zeit.de","https://thenextweb.com","https://politico.com","https://boston.com","https://ssl-images-amazon.com","https://lifehacker.com","https://nba.com","https://foursquare.com","https://digitaltrends.com","https://bp1.blogger.com","https://state.gov","https://pinterest.co.uk","https://techradar.com","https://merriam-webster.com","https://video.google.com","https://example.com","https://fortune.com","https://mercurynews.com","https://xinhuanet.com","https://fda.gov","https://ucla.edu","https://tmz.com","https://orange.fr","https://pcmag.com","https://cmu.edu","https://symantec.com","https://eonline.com","https://wildberries.ru","https://avito.ru","https://aliexpress.ru","https://sberbank.ru","https://gosuslugi.ru","https://ozon.ru","https://kinopoisk.ru","https://ivi.ru","https://gismeteo.ru"]
    
    
    func parseIcons() {
        
        
        for item in websites {
            
            let url = URL(string: item)!
            let imageName = nameForImage(url: item)
            
            self.timer?.invalidate()
            
            self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { (_) in
                
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
            })
        }
    }
    
    
    func nameForImage(url: String) -> String {
        let extractor = try! TLDExtract(useFrozenData: true)
        guard let result: TLDResult = extractor.parse(url) else { return "" }
        return result.secondLevelDomain ?? ""
    }
    
}
