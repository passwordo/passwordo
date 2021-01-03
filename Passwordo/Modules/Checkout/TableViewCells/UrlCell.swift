//
//  UrlCell.swift
//  Passwordo
//
//  Created by Boris Goncharov on 12/18/20.
//  Copyright © 2020 Boris Goncharov. All rights reserved.
//

import Foundation
import UIKit

class UrlCell: UITableViewCell, Colorable {
    
    @IBOutlet weak var urlLabel: UILabel?
    
    let applyColor = DefaultStyle()
    
    var item: CheckoutViewModelItem? {
        didSet {
            guard let item = item as? CheckoutViewModelUrl else { return }
            
            urlLabel?.attributedText = findHttpsRange(string: item.url)
            
            backgroundColor = applyColor.Style.setColor(mainColor: UIColor.AppColors.cellBackgroundColor, darkModeCorlor: UIColor.AppColors.cellBackgroundColorDarkMode)
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
        
        urlLabel?.text = ""
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        
        
        
        UIMenuController.shared.menuItems = [UIMenuItem(title: "Copy".localized(), action: #selector(UrlCell.copyUrl)), UIMenuItem(title: "Share".localized(), action: #selector(UrlCell.shareUrl)), UIMenuItem(title: "Open in Safari".localized(), action: #selector(UrlCell.openInSafari))]
        
        return action == #selector(UrlCell.copyUrl) || action == #selector(UrlCell.shareUrl) || action == #selector(UrlCell.openInSafari)
    }
    
    
    @objc func copyUrl() {
        let pasteboard = UIPasteboard.general
        pasteboard.string = urlLabel?.text
      }
    
    @objc func shareUrl() {
        let sharingContent = [urlLabel?.text]
        let ac = UIActivityViewController(activityItems: sharingContent as [Any], applicationActivities: nil)
        let keyWindow = UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive})
                .map({$0 as? UIWindowScene})
                .compactMap({$0})
                .first?.windows
                .filter({$0.isKeyWindow}).first
        keyWindow?.rootViewController?.present(ac, animated: true, completion: nil)
      }
    
    @objc func openInSafari() {
        guard let link = URL(string: (urlLabel?.text)!) else { return }
        UIApplication.shared.open(link)
      }
    

    @IBAction func urlButtonPressed(_ sender: Any) {
        guard let link = URL(string: (urlLabel?.text)!) else { return }
        UIApplication.shared.open(link)
    }
    
}
