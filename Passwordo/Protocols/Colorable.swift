//
//  Colorable.swift
//  Passwordo
//
//  Created by Boris Goncharov on 12/18/20.
//  Copyright © 2020 Boris Goncharov. All rights reserved.
//

import Foundation
import UIKit

protocol Colorable {
    
}

extension Colorable where Self: UIResponder {
    
    func findHttpsRange(string: String) -> NSAttributedString {
        let range = (string as NSString).range(of: "https://")
        let mutableAttributedString = NSMutableAttributedString.init(string: string)
        mutableAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.systemGreen, range: range)
        return mutableAttributedString
    }
    
    
    func findPatternRange(string: String, pattern: String) -> [NSRange] {
        
        let nsString = string as NSString
        let regex = try? NSRegularExpression(pattern: pattern, options: [])
        let matches = regex?.matches(in: string, options: .withoutAnchoringBounds, range: NSMakeRange(0, nsString.length))
        return matches?.map{$0.range} ?? []
    }
    
    func attributedNumberString(string: String, numberAttribute: [NSAttributedString.Key: Any]) -> NSAttributedString{
        
        let rangeNums = findPatternRange(string: string, pattern: "[0-9]+")
        let rangeSymbolic = findPatternRange(string: string, pattern: "[$&+,:;=?@#|'<>.^*()%!-]+")
        let rangeLetters = findPatternRange(string: string, pattern: "[a-z]+")

        let attributedString = NSMutableAttributedString(string: string)
        for range in rangeNums{
            attributedString.addAttributes(numberAttribute, range: range)
        }
        for range in rangeLetters{
            attributedString.addAttributes([NSAttributedString.Key.foregroundColor: UIColor.systemGreen], range: range)
        }
        for range in rangeSymbolic{
            attributedString.addAttributes([NSAttributedString.Key.foregroundColor: UIColor.systemBlue], range: range)
        }

        return attributedString
    }
}
