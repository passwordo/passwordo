//
//  CheckoutVC.swift
//  Passwordo
//
//  Created by Boris Goncharov on 12/17/20.
//  Copyright © 2020 Boris Goncharov. All rights reserved.
//

import Foundation
import UIKit
import Realm
import RealmSwift

class CheckoutVC: UIViewController {
    
    let applyColor = DefaultStyle()
    let db = DatabaseManager()

    var item: MPassword?
    var viewModel: CheckoutViewModel?
    
    var tableView = UITableView(frame: .zero, style: .grouped)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIMenuController.shared.update()
        
        setupView()
        setupTableView()
        setupCells()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setupTableView()
    }
    
    private func setupView() {
        
        view.backgroundColor = applyColor.Style.setColor(mainColor: UIColor.AppColors.mainBackground, darkModeCorlor: UIColor.AppColors.mainBackgroundDarkMode)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit".localized(), style: .plain, target: self, action: #selector(openEdit))
    }
    
    private func setupTableView() {
        
        viewModel = CheckoutViewModel(item: item!)
        tableView.dataSource = viewModel
        tableView.delegate = viewModel
        tableView.allowsSelection = false
        tableView.backgroundColor = applyColor.Style.setColor(mainColor: UIColor.AppColors.mainBackground, darkModeCorlor: UIColor.AppColors.mainBackgroundDarkMode)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 1))
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        title = item?.itemName
        navigationItem.largeTitleDisplayMode = .never
    }
    
    private func setupCells() {
        
        tableView.register(NamePictureCell.nib, forCellReuseIdentifier: NamePictureCell.identifier)
        tableView.register(UrlCell.nib, forCellReuseIdentifier: UrlCell.identifier)
        tableView.register(LoginCell.nib, forCellReuseIdentifier: LoginCell.identifier)
        tableView.register(PasswordCell.nib, forCellReuseIdentifier: PasswordCell.identifier)

    }

    @objc func openEdit() {
        
        let vc = EditVC()
        vc.didRecieveDataUpdate(data: item!)
        navigationController?.pushViewController(vc, animated: false)
    }
}


extension CheckoutVC: DataModelDelegate {
    func didRecieveDataUpdate(data: MPassword) {
        self.item = data
    }
}
