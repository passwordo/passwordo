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
    
    var temporaryImage: UIImage?
//    var itemImage: UIImage?
    
    var item: EditViewModelItem? {
        didSet {
            
            activityIndicator.isHidden = true
            guard let item = item as? EditViewModelNamePicture else { return }
            
            temporaryImage = FilesHandling.getImage(withName: item.imageName)
            
            nameTextField?.text = item.name != "" ? item.name : nameText
            pictureImageView?.image = temporaryImage != nil ? temporaryImage : item.image
            
            imageName = item.imageName
            
            pictureImageView?.backgroundColor = UIColor(white:1, alpha:0)
            pictureImageView?.isOpaque = false
            
            setupTextField()
            setupObservers()

            pictureImageView?.layer.cornerRadius = 8
            
            NotificationCenter.default.addObserver(self, selector: #selector(handleSaveButtonPressed), name: .didSaveButtonPress, object: nil)
            
            NotificationCenter.default.addObserver(self, selector: #selector(handleCancelButtonPressed), name: .didCancelButtonPress, object: nil)
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
//
        NotificationCenter.default.addObserver(self, selector: #selector(handleNameUpdate), name: .didUpdateName, object: nil)
//
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
    
    func removeObservers() {
        print("removeObservers")
        NotificationCenter.default.removeObserver(self)
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
            temporaryImage = UIImage(named: "noimage")
            self.pictureImageView?.image = temporaryImage
        } else if newUrl?.isEmpty == true || !urlIsValid(urlString: newUrl) {
            

            temporaryImage = generateImageForItem(itemName: (nameTextField?.text)!, with: imageName!)
            self.pictureImageView?.image = temporaryImage
//        self.pictureImageView?.image = FilesHandling.getImage(withName: self.imageName!)
        }
    }
    
    @objc func handleUrlUpdate(notification: Notification) {
        if let item = notification.object as? String {
//
            newUrl = item
//            startActivityIndicator()
//            self.temporaryImage = downloadFaviconForUrl(for: newUrl!, with: (nameTextField?.text!)!, imageName: imageName!, complition: {
//
////                self.pictureImageView?.image = FilesHandling.getImage(withName: self.imageName!)
//                self.stopActivityIndicator()
//            })
        }
//        self.pictureImageView?.image = temporaryImage
    }
    
    
    @objc private func handleSaveButtonPressed() {
        FilesHandling.saveImage(image: temporaryImage!, withName: imageName!)
        removeObservers()
    }
    
    @objc private func handleCancelButtonPressed() {
        removeObservers()
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()

        print("prepareForReuse")
        
        pictureImageView?.image = nil
    }
}
