//
//  Notification+Extension.swift
//  Passwordo
//
//  Created by Boris Goncharov on 12/23/20.
//  Copyright © 2020 Boris Goncharov. All rights reserved.
//

import Foundation

extension Notification.Name {
    static let didUpdateUrl = Notification.Name("didUpdateUrl")
    static let didUpdateLogin = Notification.Name("didUpdateLogin")
    static let didUpdatePassword = Notification.Name("didUpdatePassword")
    static let didUpdateName = Notification.Name("didUpdateName")
    static let didPasswordGenerationButtonTapped = Notification.Name("didPasswordGenerationButtonTapped")
    static let didPasswordGenerated = Notification.Name("didPasswordGenerated")
    static let didSaveButtonPress = Notification.Name("didSaveButtonPress")
    static let didCancelButtonPress = Notification.Name("didCancelButtonPress")
}
