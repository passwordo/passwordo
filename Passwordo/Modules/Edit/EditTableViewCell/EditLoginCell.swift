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
    
    let color = DefaultStyle()
    
    var cancellables = Set<AnyCancellable>()
    
    var item: EditViewModelItem? {
        didSet {
            guard let item = item as? EditViewModelLogin else { return }
            
            loginTextField?.text = item.login
            
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
            
            
            backgroundColor = color.Style.color(mainColor: UIColor.AppColors.cellBackgroundColor, darkModeCorlor: UIColor.AppColors.cellBackgroundColorDarkMode)
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        loginTextField?.text = ""
    }
    
}
