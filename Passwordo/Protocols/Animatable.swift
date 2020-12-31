//
//  Animatable.swift
//  Passwordo
//
//  Created by Boris Goncharov on 12/25/20.
//  Copyright © 2020 Boris Goncharov. All rights reserved.
//

import Foundation
import UIKit
import SwiftMessages

protocol Animatable {
    
}

extension Animatable where Self: UIViewController {
    
    func showErrorToast(errorMessage: String) {
        
        let iconText = ["🤔", "😳", "🙄", "😶"].randomElement()!
        
        var config = SwiftMessages.Config()
        config.presentationContext = .window(windowLevel: .normal)

        let error = MessageView.viewFromNib(layout: .cardView)
        error.configureTheme(.error)
        error.configureContent(title: "Error", body: errorMessage, iconText: iconText)
        error.button?.isHidden = true
        error.configureDropShadow()

        SwiftMessages.show(config: config, view: error)
    }
}
