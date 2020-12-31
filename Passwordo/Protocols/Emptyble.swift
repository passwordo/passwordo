//
//  Emptyble.swift
//  Passwordo
//
//  Created by Boris Goncharov on 12/15/20.
//  Copyright © 2020 Boris Goncharov. All rights reserved.
//

import Foundation
import UIKit
import EmptyDataSet_Swift

protocol Emptyble {
    
}

extension Emptyble where Self: UITableViewController {
    func emptyTableView(forEmptyDataSet tableView: UITableView) {
        tableView.emptyDataSetView { view in
            view.titleLabelString(NSAttributedString(string: "Nothing here"))
                .detailLabelString(NSAttributedString(string: "press \"+\" to add new item"))
                .image(UIImage(named: "empty-box"))
                .isTouchAllowed(false)
                .verticalOffset(CGFloat(-(UIScreen.main.bounds.size.height / 4.8)))
                .verticalSpace(CGFloat(14))
        }
    }
    
    func noSearchResults(forEmptyDataSet tableView: UITableView) {
        tableView.emptyDataSetView { view in
            view.titleLabelString(NSAttributedString(string: "No results"))
                .detailLabelString(NSAttributedString(string: "try something else"))
                .isTouchAllowed(false)
                .verticalOffset(CGFloat(-(UIScreen.main.bounds.size.height / 4.8)))
                .verticalSpace(CGFloat(14))
        }
    }
}
