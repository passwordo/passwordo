//
//  EditNamePictureCell.swift
//  Passwordo
//
//  Created by Boris Goncharov on 12/20/20.
//  Copyright © 2020 Boris Goncharov. All rights reserved.
//

import Foundation
import UIKit
import Combine
import FavIcon

class EditNamePictureCell: UITableViewCell, Faviconable {
    
    @IBOutlet weak var nameTextField: UITextField?
    @IBOutlet weak var pictureImageView: UIImageView?
        
    let color = DefaultStyle()
    var newUrl: String?
    var imageName: String?
    var cancellables = Set<AnyCancellable>()
    
    var item: EditViewModelItem? {
        didSet {
            guard let item = item as? EditViewModelNamePicture else { return }
            
            nameTextField?.text = item.name
            nameTextField?.isEnabled = true
            nameTextField?.becomeFirstResponder()
            pictureImageView?.image = item.image
            imageName = item.imageName
            backgroundColor = color.Style.color(mainColor: UIColor.AppColors.cellBackgroundColor, darkModeCorlor: UIColor.AppColors.cellBackgroundColorDarkMode)
            

            NotificationCenter.default.addObserver(self, selector: #selector(handleUrlUpdate), name: .didUpdateUrl, object: nil)
            
            NotificationCenter.default.addObserver(self, selector: #selector(handleNameUpdate), name: .didUpdateName, object: nil)
            
            let textFieldPublisher = NotificationCenter.default
                        .publisher(for: UITextField.textDidChangeNotification, object: nameTextField)
                        .map( {
                            ($0.object as? UITextField)?.text
                        })
                    
                    textFieldPublisher
                        .receive(on: RunLoop.main)
                        .sink(receiveValue: { value in
                            NotificationCenter.default.post(name: .didUpdateName, object: value)
                        })
                        .store(in: &cancellables)
            
            pictureImageView?.layer.cornerRadius = 8
        }
    }
    
    @objc func handleNameUpdate() {
        if nameTextField?.text?.isEmpty == true && (newUrl?.isEmpty == true || !urlIsValid(urlString: newUrl)) {
            pictureImageView?.image = UIImage(named: "noimage")
        } else if newUrl?.isEmpty == true || !urlIsValid(urlString: newUrl) {
            generateImageForItem(itemName: (nameTextField?.text)!, with: imageName!)
        self.pictureImageView?.image = Cache.getImageFromCache(named: self.imageName!)
        }
    }
    
    @objc func handleUrlUpdate(notification: Notification) {
        if let item = notification.object as? String {
            
            newUrl = item
            downloadFaviconForUrl(for: newUrl!, with: (nameTextField?.text!)!, imageName: imageName!, complition: {
                self.pictureImageView?.image = Cache.getImageFromCache(named: self.imageName!)
            })
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
        
        pictureImageView?.image = nil
    }
}
