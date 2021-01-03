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
    
    func showToast(state: Theme, message: String) {
        
        var config = SwiftMessages.Config()
        config.presentationContext = .window(windowLevel: .normal)

        let toast = MessageView.viewFromNib(layout: .cardView)
        toast.configureTheme(state)
        toast.configureContent(body: message)
        toast.button?.isHidden = true
        toast.configureDropShadow()
        
        DispatchQueue.main.async {
            SwiftMessages.show(config: config, view: toast)
        }
    }
}
