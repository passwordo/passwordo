//
//  ValidUrl.swift
//  Passwordo
//
//  Created by Boris Goncharov on 1/14/21.
//  Copyright © 2021 Boris Goncharov. All rights reserved.
//

import UIKit

class ValidUrl {
    
    static func urlIsValid (urlString: String?) -> Bool {
        if let urlString = urlString {
            if let url = NSURL(string: urlString) {
                return UIApplication.shared.canOpenURL(url as URL)
            }
        }
        return false
    }
}
