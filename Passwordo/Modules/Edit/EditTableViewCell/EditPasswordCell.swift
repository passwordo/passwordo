//
//  EditPasswordCell.swift
//  Passwordo
//
//  Created by Boris Goncharov on 12/21/20.
//  Copyright © 2020 Boris Goncharov. All rights reserved.
//

import Foundation
import UIKit
import Combine

class EditPasswordCell: UITableViewCell, Colorable {
    
    @IBOutlet weak var passworTextField: UITextField?
    
    let applyColor = DefaultStyle()
    var password: String?
    var isHide = true
    
    var cancellables = Set<AnyCancellable>()
    
    var item: EditViewModelItem? {
        didSet {
            NotificationCenter.default.addObserver(self, selector: #selector(handlePasswordGenerated), name: .didPasswordGenerated, object: nil)
            
            guard let item = item as? EditViewModelPassword else { return }

            if item.password.isEmpty {
                passworTextField?.text = ""
            } else {
                passworTextField?.text = item.password
            }
            password = item.password
            
            let textFieldPublisher = NotificationCenter.default
                        .publisher(for: UITextField.textDidChangeNotification, object: passworTextField)
                        .map( {
                            ($0.object as? UITextField)?.text
                        })
                    
                    textFieldPublisher
                        .receive(on: RunLoop.main)
                        .sink(receiveValue: { value in
                            NotificationCenter.default.post(name: .didUpdatePassword, object: value)
                        })
                        .store(in: &cancellables)

            backgroundColor = applyColor.Style.setColor(mainColor: UIColor.AppColors.cellBackgroundColor, darkModeCorlor: UIColor.AppColors.cellBackgroundColorDarkMode)
        }
    }
    
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    
        
    }
    
//    override func prepareForReuse() {
//        super.prepareForReuse()
//
//        passworTextField?.text = ""
//    }
    
    @objc func handlePasswordGenerated(notification: Notification) {
        if let item = notification.object as? String {
            passworTextField?.text = item
            password = item
            
        }
        
    }
    
    
//    @IBAction func showButton() {
//        if isHide {
//            isHide = false
//            let range = attributedNumberString(string: password!, numberAttribute: [NSAttributedString.Key.foregroundColor: UIColor.systemRed])
//            passworTextField?.attributedText = range
//        } else {
//            isHide = true
//            passworTextField?.text = "••••••••••••"
//            passworTextField?.textColor = .black
//        }
//    }
    
    @IBAction func createButton() {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "didPasswordGenerationButtonTapped"), object: nil)
        
    }
}
