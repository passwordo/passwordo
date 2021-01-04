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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let applyColor = DefaultStyle()
    var cancellables = Set<AnyCancellable>()
    
    var newUrl: String?
    var imageName: String?
    var nameText: String?
    var itemImage: UIImage?
    
    var item: EditViewModelItem? {
        didSet {
            
            activityIndicator.isHidden = true
            guard let item = item as? EditViewModelNamePicture else { return }
            
            itemImage = FilesHandling.getImage(withName: item.imageName)
            
            nameTextField?.text = item.name != "" ? item.name : nameText
            pictureImageView?.image = itemImage != nil ? itemImage : item.image
            
            imageName = item.imageName

            setupTextField()
            setupObservers()

            pictureImageView?.layer.cornerRadius = 8
        }
    }
    
    // MARK: - setupTextField()
    
    private func setupTextField() {
        
        nameTextField?.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        nameTextField?.isEnabled = true
        nameTextField?.becomeFirstResponder()
        backgroundColor = applyColor.Style.setColor(mainColor: UIColor.AppColors.cellBackgroundColor, darkModeCorlor: UIColor.AppColors.cellBackgroundColorDarkMode)
    }
    
    // MARK: - setupObservers()
    
    private func setupObservers() {
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
    
    private func startActivityIndicator() {
        self.pictureImageView?.image = UIImage(named: "white")
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
    }
    
    private func stopActivityIndicator() {
        self.activityIndicator.stopAnimating()
        self.activityIndicator.isHidden = true
    }
    
    // MARK: - @objc funcs
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        nameText = textField.text ?? ""
    }
    
    @objc func handleNameUpdate() {
        if nameTextField?.text?.isEmpty == true && (newUrl?.isEmpty == true || !urlIsValid(urlString: newUrl)) {
            pictureImageView?.image = UIImage(named: "noimage")
        } else if newUrl?.isEmpty == true || !urlIsValid(urlString: newUrl) {
            generateImageForItem(itemName: (nameTextField?.text)!, with: imageName!)
        self.pictureImageView?.image = FilesHandling.getImage(withName: self.imageName!)
        }
    }
    
    @objc func handleUrlUpdate(notification: Notification) {
        if let item = notification.object as? String {
            
            newUrl = item
            startActivityIndicator()
            downloadFaviconForUrl(for: newUrl!, with: (nameTextField?.text!)!, imageName: imageName!, complition: {
                
                self.pictureImageView?.image = FilesHandling.getImage(withName: self.imageName!)
                self.stopActivityIndicator()
            })
        }
    }
    
//    override func prepareForReuse() {
//        super.prepareForReuse()
//
//        pictureImageView?.image = nil
//    }
}
