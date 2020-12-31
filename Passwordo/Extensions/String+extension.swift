//
//  String+extension.swift
//  Passwordo
//
//  Created by Boris Goncharov on 12/27/20.
//  Copyright © 2020 Boris Goncharov. All rights reserved.
//

import Foundation

extension String {
    func localized() -> String {
        return NSLocalizedString(
            self,
            tableName: "Localizable",
            bundle: .main,
            value: self,
            comment: self)
    }
}
