//
//  ASCredentialServiceIdentifier+extension.swift
//  AutoFill_Extension
//
//  Created by Boris Goncharov on 12/28/20.
//  Copyright © 2020 Boris Goncharov. All rights reserved.
//

import UIKit
import AuthenticationServices

extension ASCredentialServiceIdentifier {
    
    var domainForFilter: String {
        let host = URL(string: identifier)?.host ?? identifier
        
        let components = host.components(separatedBy: ".")
        switch components.count {
        case 0...1:
            return "*" + host
        default:
            return "*" + components[components.count - 2] + "." + components[components.count - 1]
        }
    }
    
}
