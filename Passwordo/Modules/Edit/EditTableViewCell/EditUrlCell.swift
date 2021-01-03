//
//  EditWebsiteCell.swift
//  Passwordo
//
//  Created by Boris Goncharov on 12/21/20.
//  Copyright © 2020 Boris Goncharov. All rights reserved.
//

import Foundation
import UIKit
import Combine

class EditUrlCell: UITableViewCell {
    
    @IBOutlet weak var urlTextField: UITextField?
    
    let color = DefaultStyle()
    var cancellables = Set<AnyCancellable>()
    
    var urlText = ""
    
    var item: EditViewModelItem? {
        didSet {
            guard let item = item as? EditViewModelUrl else { return }
            
            if item.url != "" {
                urlTextField?.text = item.url
            } else if urlText != nil {
                urlTextField?.text = urlText
            }
            
            urlTextField?.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            
            let textFieldPublisher = NotificationCenter.default
                        .publisher(for: UITextField.textDidChangeNotification, object: urlTextField)
                        .map( {
                            ($0.object as? UITextField)?.text
                        })
                    
                    textFieldPublisher
                        .receive(on: RunLoop.main)
                        .sink(receiveValue: { value in             
                            NotificationCenter.default.post(name: .didUpdateUrl, object: value)
                        })
                        .store(in: &cancellables)
            
            
            backgroundColor = color.Style.color(mainColor: UIColor.AppColors.cellBackgroundColor, darkModeCorlor: UIColor.AppColors.cellBackgroundColorDarkMode)

        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        urlText = textField.text ?? ""
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
//        urlTextField?.text = ""
//    }
//
}
