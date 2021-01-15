//
//  PasswordCell.swift
//  Passwordo
//
//  Created by Boris Goncharov on 12/18/20.
//  Copyright © 2020 Boris Goncharov. All rights reserved.
//

import Foundation
import UIKit
import Combine

class PasswordCell: UITableViewCell, Colorable {
    
    @IBOutlet weak var passwordLabel: UILabel?
    @IBOutlet weak var passwordButton: UIButton?
    
    @Published var passwordHide = true
    var password: String?
    
    let applyColor = DefaultStyle()
    
    private var subscribers = Set<AnyCancellable>()
    
    var item: CheckoutViewModelItem? {
        didSet {
            guard let item = item as? CheckoutViewModelPassword else { return }

            password = item.password
            passwordLabel?.text = "••••••••••••"
            passwordLabel?.textColor = applyColor.Style.setColor(mainColor: UIColor.AppColors.text, darkModeCorlor: UIColor.AppColors.textDarkMode)
            passwordLabel?.font = UIFont.systemFont(ofSize: 25)
            
            backgroundColor = applyColor.Style.setColor(mainColor: UIColor.AppColors.cellBackgroundColor, darkModeCorlor: UIColor.AppColors.cellBackgroundColorDarkMode)
            
            passwordButtonImage()
        }
    }
    
    private func passwordButtonImage() {
        
        $passwordHide.sink { [unowned self] (status) in
            if status == true {
                self.passwordButton?.setImage(UIImage(named: "show"), for: .normal)
            } else {
                self.passwordButton?.setImage(UIImage(named: "hide"), for: .normal)
            }
        }.store(in: &subscribers)
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
        
        passwordLabel?.text = ""
    }
    
    
    @IBAction func buttonTapped(_ sender: Any) {
        
        if passwordHide == true {
            passwordHide = false
            
            guard let item = item as? CheckoutViewModelPassword else { return }
            
            let range = attributedNumberString(string: item.password, numberAttribute: [NSAttributedString.Key.foregroundColor: UIColor.systemRed])
                        passwordLabel?.attributedText = range
                        
            passwordLabel?.attributedText = range
            passwordLabel?.font = UIFont.systemFont(ofSize: 20)
            
        } else {
            passwordHide = true
            passwordLabel?.text = "••••••••••••"
            passwordLabel?.textColor = applyColor.Style.setColor(mainColor: UIColor.AppColors.text, darkModeCorlor: UIColor.AppColors.textDarkMode)
            passwordLabel?.font = UIFont.systemFont(ofSize: 25)
            passwordLabel?.textColor = applyColor.Style.setColor(mainColor: UIColor.AppColors.text, darkModeCorlor: UIColor.AppColors.textDarkMode)
        }
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        
        let showHide = passwordHide == true ? "Show".localized() : "Hide".localized()
        
        UIMenuController.shared.menuItems = [UIMenuItem(title: "Copy".localized(), action: #selector(PasswordCell.copyPass)), UIMenuItem(title: "Share".localized(), action: #selector(PasswordCell.sharePass)), UIMenuItem(title: showHide, action: #selector(PasswordCell.showHide))]
        
        return action == #selector(PasswordCell.copyPass) || action == #selector(PasswordCell.sharePass) || action == #selector(PasswordCell.showHide)
    }
    
    @objc func copyPass() {
        let pasteboard = UIPasteboard.general
        pasteboard.string = passwordLabel?.text
      }
    
    @objc func sharePass() {
        let sharingContent = [password]
        let ac = UIActivityViewController(activityItems: sharingContent as [Any], applicationActivities: nil)
//        UIApplication.shared.keyWindow?.rootViewController?.present(ac, animated: true)
        let keyWindow = UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive})
                .map({$0 as? UIWindowScene})
                .compactMap({$0})
                .first?.windows
                .filter({$0.isKeyWindow}).first
        keyWindow?.rootViewController?.present(ac, animated: true, completion: nil)
      }
    
    @objc func showHide() {
        if passwordHide == true {
            passwordHide = false
            
            guard let item = item as? CheckoutViewModelPassword else { return }
            
            let range = attributedNumberString(string: item.password, numberAttribute: [NSAttributedString.Key.foregroundColor: UIColor.systemRed])
                        passwordLabel?.attributedText = range
                        
            passwordLabel?.attributedText = range
            passwordLabel?.font = UIFont.systemFont(ofSize: 20)
            
        } else {
            passwordHide = true
            passwordLabel?.text = "••••••••••••"
            passwordLabel?.textColor = applyColor.Style.setColor(mainColor: UIColor.AppColors.text, darkModeCorlor: UIColor.AppColors.textDarkMode)
            passwordLabel?.font = UIFont.systemFont(ofSize: 25)
            passwordLabel?.textColor = applyColor.Style.setColor(mainColor: UIColor.AppColors.text, darkModeCorlor: UIColor.AppColors.textDarkMode)
        }
      }
}
