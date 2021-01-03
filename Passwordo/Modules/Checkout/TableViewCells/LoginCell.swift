//
//  LoginCell.swift
//  Passwordo
//
//  Created by Boris Goncharov on 12/18/20.
//  Copyright © 2020 Boris Goncharov. All rights reserved.
//

import Foundation
import UIKit

class LoginCell: UITableViewCell {
    
    @IBOutlet weak var loginTextField: UITextField?
        
    let applyColor = DefaultStyle()
    
    var item: CheckoutViewModelItem? {
        didSet {
            guard let item = item as? CheckoutViewModelLogin else { return }

            loginTextField?.text = item.login
            
            loginTextField?.isEnabled = false 
            
            backgroundColor = applyColor.Style.setColor(mainColor: UIColor.AppColors.cellBackgroundColor, darkModeCorlor: UIColor.AppColors.cellBackgroundColorDarkMode)
        }
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    override class func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        loginTextField?.text = ""
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        
        UIMenuController.shared.menuItems = [UIMenuItem(title: "Copy".localized(), action: #selector(LoginCell.copyLogin)), UIMenuItem(title: "Share".localized(), action: #selector(LoginCell.shareLogin))]
        
        return action == #selector(LoginCell.copyLogin) || action == #selector(LoginCell.shareLogin)
        
    }

    @objc func copyLogin() {
        let pasteboard = UIPasteboard.general
        pasteboard.string = loginTextField?.text
      }
    
    @objc func shareLogin() {
        let sharingContent = [loginTextField?.text]
        let ac = UIActivityViewController(activityItems: sharingContent as [Any], applicationActivities: nil)
        let keyWindow = UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive})
                .map({$0 as? UIWindowScene})
                .compactMap({$0})
                .first?.windows
                .filter({$0.isKeyWindow}).first
        keyWindow?.rootViewController?.present(ac, animated: true, completion: nil)
      }
}
