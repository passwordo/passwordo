//
//  EditViewModel.swift
//  Passwordo
//
//  Created by Boris Goncharov on 12/19/20.
//  Copyright © 2020 Boris Goncharov. All rights reserved.
//

import Foundation
import UIKit

// MARK: - EditViewModelType

enum EditViewModelType {
    case nameAndPicture
    case url
    case login
    case password
}

protocol EditViewModelItem {
    var type: EditViewModelType { get }
    var rowCount: Int { get }
}

// MARK: - EditViewModel

class EditViewModel: NSObject {
    var items = [[EditViewModelItem]]()
    var attributes = [EditViewModelItem]()
    
    let db = DatabaseManager()
    let applyColor = DefaultStyle()
    
    var currentItem: MPassword!
    
    var image: UIImage?
    
    init(item: MPassword?) {
        super.init()
        
        if item != nil {
            self.currentItem = item
            image = FilesHandling.getImage(withName: item!.imageURL)
            if image == nil {
                image = UIImage(named: "noimage")
            }
        } else if item == nil {
            self.currentItem = MPassword(itemName: "", userName: "", password: "", serviceURL: "", imageURL: "")
            image = UIImage(named: "noimage")
        }

        let nameAndPictureItem = EditViewModelNamePicture(name: currentItem.itemName, image: image!, imageName: currentItem.imageURL)
        var nameImg = [EditViewModelItem]()
        nameImg.append(nameAndPictureItem)
        items.append(nameImg)
        
        let urlItem = EditViewModelUrl(url: currentItem.serviceURL)
        attributes.append(urlItem)
        
        let loginItem = EditViewModelLogin(login: currentItem.userName)
        attributes.append(loginItem)
  
        let passwordItem = EditViewModelPassword(password: currentItem.passwordString)
        attributes.append(passwordItem)
        
        
        items.append(attributes)
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension EditViewModel: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.section][indexPath.row]
        
        switch item.type {
        
        case .nameAndPicture:
            if let cell = tableView.dequeueReusableCell(withIdentifier: EditNamePictureCell.identifier, for: indexPath) as? EditNamePictureCell {
                cell.item = item
                cell.backgroundColor = applyColor.Style.setColor(mainColor: UIColor.AppColors.cellBackgroundColor, darkModeCorlor: UIColor.AppColors.cellBackgroundColorDarkMode)
                return cell
            }
        case .url:
            if let cell = tableView.dequeueReusableCell(withIdentifier: EditUrlCell.identifier, for: indexPath) as? EditUrlCell {
                cell.item = item
                cell.backgroundColor = applyColor.Style.setColor(mainColor: UIColor.AppColors.cellBackgroundColor, darkModeCorlor: UIColor.AppColors.cellBackgroundColorDarkMode)
                return cell
            }
        case .login:
            if let cell = tableView.dequeueReusableCell(withIdentifier: EditLoginCell.identifier, for: indexPath) as? EditLoginCell {
                cell.item = item
                cell.backgroundColor = applyColor.Style.setColor(mainColor: UIColor.AppColors.cellBackgroundColor, darkModeCorlor: UIColor.AppColors.cellBackgroundColorDarkMode)
                return cell
            }
        case .password:
            if let cell = tableView.dequeueReusableCell(withIdentifier: EditPasswordCell.identifier, for: indexPath) as? EditPasswordCell {
                cell.item = item
                cell.backgroundColor = applyColor.Style.setColor(mainColor: UIColor.AppColors.cellBackgroundColor, darkModeCorlor: UIColor.AppColors.cellBackgroundColorDarkMode)
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let headerHeight: CGFloat

            switch section {
            case 0:
                // hide the header
                headerHeight = 12
            default:
                headerHeight = 0
            }

            return headerHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        
        let returnedView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 0)) //set these values as necessary
        returnedView.backgroundColor = applyColor.Style.setColor(mainColor: UIColor.AppColors.mainBackground, darkModeCorlor: UIColor.AppColors.mainBackgroundDarkMode)
        
        return returnedView
    }
}

// MARK: - EditViewModelNamePicture

class EditViewModelNamePicture: EditViewModelItem {
    
    var type: EditViewModelType {
        return .nameAndPicture
    }
    
    var rowCount: Int {
        return 1
    }
    
    var name: String
    var image: UIImage
    var imageName: String
    
    init(name: String, image: UIImage, imageName: String) {
        self.name = name
        self.image = image
        self.imageName = imageName
    }
}

// MARK: - EditViewModelUrl

class EditViewModelUrl: EditViewModelItem {
    
    var type: EditViewModelType {
        return .url
    }
    
    var rowCount: Int {
        return 1
    }
    
    var url: String
    
    init(url: String) {
        self.url = url
    }
}

// MARK: - EditViewModelLogin

class EditViewModelLogin: EditViewModelItem {
    
    var type: EditViewModelType {
        return .login
    }
    
    var rowCount: Int {
        return 1
    }
    
    var login: String
    
    init(login: String) {
        self.login = login
    }
}

// MARK: - EditViewModelPassword

class EditViewModelPassword: EditViewModelItem {
    
    var type: EditViewModelType {
        return .password
    }
    
    var rowCount: Int {
        return 1
    }
    
    var password: String
    
    init(password: String) {
        self.password = password
    }
}
