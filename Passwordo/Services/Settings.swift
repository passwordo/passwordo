//
//  Settings.swift
//  Passwordo
//
//  Created by Boris Goncharov on 12/26/20.
//  Copyright © 2020 Boris Goncharov. All rights reserved.
//

import Foundation


public class Settings {
    
    public static let current = Settings()
    
    public enum Keys: String {
        case passwordGeneratorLength
        case passwordGeneratorIncludeLowerCase
        case passwordGeneratorIncludeUpperCase
        case passwordGeneratorIncludeSpecials
        case passwordGeneratorIncludeDigits
        case passwordGeneratorIncludeLookAlike
        case passcodeKeyboardType
    }
    
}
