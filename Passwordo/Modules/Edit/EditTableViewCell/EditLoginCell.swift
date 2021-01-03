//
//  EditLoginCell.swift
//  Passwordo
//
//  Created by Boris Goncharov on 12/21/20.
//  Copyright © 2020 Boris Goncharov. All rights reserved.
//

import Foundation
import UIKit
import Combine

class EditLoginCell: UITableViewCell {
    
    @IBOutlet weak var loginTextField: UITextField?
    
    let applyColor = DefaultStyle()
    
    var cancellables = Set<AnyCancellable>()
    
    var newLogin = ""
    
    var item: EditViewModelItem? {
        didSet {
            guard let item = item as? EditViewModelLogin else { return }
            
            if item.login != "" {
                loginTextField?.text = item.login
            } else if newLogin != nil {
                loginTextField?.text = newLogin
            }
            
            loginTextField?.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            
            let textFieldPublisher = NotificationCenter.default
                        .publisher(for: UITextField.textDidChangeNotification, object: loginTextField)
                        .map( {
                            ($0.object as? UITextField)?.text
                        })
                    
                    textFieldPublisher
                        .receive(on: RunLoop.main)
                        .sink(receiveValue: { value in
                            NotificationCenter.default.post(name: .didUpdateLogin, object: value)
                        })
                        .store(in: &cancellables)
            
            
            backgroundColor = applyColor.Style.setColor(mainColor: UIColor.AppColors.cellBackgroundColor, darkModeCorlor: UIColor.AppColors.cellBackgroundColorDarkMode)
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        newLogin = textField.text ?? ""
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
//        loginTextField?.text = ""
//    }
    
}
