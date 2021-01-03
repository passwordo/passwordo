//
//  CheckoutViewModel.swift
//  Passwordo
//
//  Created by Boris Goncharov on 12/17/20.
//  Copyright © 2020 Boris Goncharov. All rights reserved.
//

import Foundation
import UIKit

enum CheckoutViewModetType {
    case nameAndPicture
    case url
    case login
    case password
}

protocol CheckoutViewModelItem {
    var type: CheckoutViewModetType { get }
    var rowCount: Int { get }
}

class CheckoutViewModel: NSObject {
    var items = [[CheckoutViewModelItem]]()
    var attributes = [CheckoutViewModelItem]()
    
    let db = DatabaseManager()
    let color = DefaultStyle()
    
    var delegate: DataModelDelegate?

    var item: MPassword!
    
    init(item: MPassword) {
        super.init()
        
        self.item = item
        
        let image = FilesHandling.getImage(withName: item.imageURL) ?? UIImage(named: "fb")
        
        let nameAndPictureItem = CheckoutViewModelNamePicture(name: item.itemName, image: image!)
        var nameImg = [CheckoutViewModelItem]()
        nameImg.append(nameAndPictureItem)
        items.append(nameImg)
        
        let urlItem = CheckoutViewModelUrl(url: item.serviceURL)
        attributes.append(urlItem)
        
        let loginItem = CheckoutViewModelLogin(login: item.userName)
        attributes.append(loginItem)
        
        let passwordItem = CheckoutViewModelPassword(password: item.passwordString)
        attributes.append(passwordItem)
        
        items.append(attributes)
    }
}

extension CheckoutViewModel: UITableViewDataSource, UITableViewDelegate {
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let tapPress = UITapGestureRecognizer(target: self, action: #selector(CalorieCountViewController.handleTapPress))
//        cell.addGestureRecognizer(tapPress)
//    }
    
     func tableView(_ tableView: UITableView, shouldShowMenuForRowAt indexPath: IndexPath) -> Bool {
            return true
        }

        func tableView(_ tableView: UITableView, canPerformAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?) -> Bool {

            return action == #selector(UrlCell.copyUrl)
        }

        func tableView(_ tableView: UITableView, performAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?) {
            // needs to be here
        }

    
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if indexPath.section == 0 {
//            return 82
//        } else {
//            return 68
//        }
//        
//    }
    
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
        returnedView.backgroundColor = color.Style.color(mainColor: UIColor.AppColors.mainBackground, darkModeCorlor: UIColor.AppColors.mainBackgroundDarkMode)
        
        return returnedView
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.section][indexPath.row]
        
        switch item.type {
        
        case .nameAndPicture:
            if let cell = tableView.dequeueReusableCell(withIdentifier: NamePictureCell.identifier, for: indexPath) as? NamePictureCell {
                cell.item = item
                cell.backgroundColor = color.Style.color(mainColor: UIColor.AppColors.cellBackgroundColor, darkModeCorlor: UIColor.AppColors.cellBackgroundColorDarkMode)
                return cell
            }
        case .url:
            if let cell = tableView.dequeueReusableCell(withIdentifier: UrlCell.identifier, for: indexPath) as? UrlCell {
                cell.item = item
                cell.backgroundColor = color.Style.color(mainColor: UIColor.AppColors.cellBackgroundColor, darkModeCorlor: UIColor.AppColors.cellBackgroundColorDarkMode)
                return cell
            }
        case .login:
            if let cell = tableView.dequeueReusableCell(withIdentifier: LoginCell.identifier, for: indexPath) as? LoginCell {
                cell.item = item
 
                cell.backgroundColor = color.Style.color(mainColor: UIColor.AppColors.cellBackgroundColor, darkModeCorlor: UIColor.AppColors.cellBackgroundColorDarkMode)
                return cell
            }
        case .password:
            if let cell = tableView.dequeueReusableCell(withIdentifier: PasswordCell.identifier, for: indexPath) as? PasswordCell {
                cell.item = item
                cell.backgroundColor = color.Style.color(mainColor: UIColor.AppColors.cellBackgroundColor, darkModeCorlor: UIColor.AppColors.cellBackgroundColorDarkMode)
                return cell
            }
        }
        return UITableViewCell()
    }
}


class CheckoutViewModelNamePicture: CheckoutViewModelItem {
    
    var type: CheckoutViewModetType {
        return .nameAndPicture
    }
    
    var rowCount: Int {
        return 1
    }
    
    var name: String
    var image: UIImage
    
    init(name: String, image: UIImage) {
        self.name = name
        self.image = image
    }
}

class CheckoutViewModelUrl: CheckoutViewModelItem {
    var type: CheckoutViewModetType {
        return .url
    }
    
    var rowCount: Int { return 1 }
    
    var url: String
    
    init(url: String) {
        self.url = url
    }
}

class CheckoutViewModelLogin: CheckoutViewModelItem {
    var type: CheckoutViewModetType {
        return .login
    }
    
    var rowCount: Int { return 1 }
    
    var login: String
    
    init(login: String) {
        self.login = login
    }
}


class CheckoutViewModelPassword: CheckoutViewModelItem {
    var type: CheckoutViewModetType {
        return .password
    }
    
    var rowCount: Int { return 1 }
    
    var password: String
    
    init(password: String) {
        self.password = password
    }
}
    


