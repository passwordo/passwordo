//
//  EditVC.swift
//  Passwordo
//
//  Created by Boris Goncharov on 12/19/20.
//  Copyright © 2020 Boris Goncharov. All rights reserved.
//

import Foundation
import UIKit
import Combine

class EditVC: UIViewController, Randomable {
    
    let color = DefaultStyle()
    var item: MPassword?
    var viewModel: EditViewModel?
    weak var delegate: DataModelDelegate?
    let db = DatabaseManager()
    
    var generatedImageName: String?
    var editMode = true
    
    @Published var newName: String!
    @Published var newUrl: String!
    @Published var newLogin: String!
    @Published var newPassword = ""
    
    @Published var checker: [Bool] = [false, false, false]
        
    var tableView = UITableView(frame: .zero, style: .grouped)
    private var subscribers = Set<AnyCancellable>()
 
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(handleNameUpdate), name: .didUpdateName, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleUrlUpdate), name: .didUpdateUrl, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleLoginUpdate), name: .didUpdateLogin, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handlePasswordUpdate), name: .didUpdatePassword, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handlePasswordGeneration), name: .didPasswordGenerationButtonTapped, object: nil)
        
        if !editMode {
            generatedImageName = randomString(length: 12)
        }

        
        setupLaunch()
        setupTableView()
        setupCells()
        setupView()
        
        obderveForm()
    }
    
    private func obderveForm() {
        
        $checker.sink { (checks) in
            if checks.allSatisfy({$0}) {
                self.navigationItem.rightBarButtonItem?.isEnabled = true
            } else {
                self.navigationItem.rightBarButtonItem?.isEnabled = false
            }
        }.store(in: &subscribers)
        
        
//        $newName.sink { [unowned self] text in
//            self.navigationItem.rightBarButtonItem?.isEnabled = text?.isEmpty == false
//        }.store(in: &subscribers)
    }

    
    func editModeEnable() {
        editMode = false
    }
    
    @objc func handlePasswordGeneration() {
        
        let vc = PasswordGeneratorVC.make { [weak self] (password) in
            self?.newPassword = password
//            if self?.editMode == false {
//                self?.item?.passwordString = password 
//            }
            NotificationCenter.default.post(name: Notification.Name(rawValue: "didPasswordGenerated"), object: self?.newPassword)
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func handleNameUpdate(notification: Notification) {
        if let item = notification.object as? String {
            newName = item
            checker[0] = newName.isEmpty ? false : true
        }
    }
    
    
    @objc func handleUrlUpdate(notification: Notification) {
        if let item = notification.object as? String {
            newUrl = item
            checker[1] = newUrl.isEmpty ? false : true
        }
    }
    
    @objc func handleLoginUpdate(notification: Notification) {
        if let item = notification.object as? String {
            newLogin = item
            checker[2] = newLogin.isEmpty ? false : true
        }
    }
    
    @objc func handlePasswordUpdate(notification: Notification) {
        if let item = notification.object as? String {
            newPassword = item
        }
    }
    
    private func setupLaunch() {
        if editMode {
            viewModel = EditViewModel(item: item!)
        } else {
            item = MPassword(itemName: "", userName: "", password: "", serviceURL: "", imageURL: generatedImageName!)
        }
    }
    
    private func setupTableView() {
        
        if !editMode {
            viewModel = EditViewModel(item: item!)
        }
        
        tableView.dataSource = viewModel
        tableView.delegate = viewModel
        
        tableView.allowsSelection = false
        
        tableView.backgroundColor = color.Style.color(mainColor: UIColor.AppColors.mainBackground, darkModeCorlor: UIColor.AppColors.mainBackgroundDarkMode)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 1))
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupCells() {
        tableView.register(EditNamePictureCell.nib, forCellReuseIdentifier: EditNamePictureCell.identifier)
        tableView.register(EditUrlCell.nib, forCellReuseIdentifier: EditUrlCell.identifier)
        tableView.register(EditLoginCell.nib, forCellReuseIdentifier: EditLoginCell.identifier)
        tableView.register(EditPasswordCell.nib, forCellReuseIdentifier: EditPasswordCell.identifier)
    }
    
    private func setupView() {
        
        navigationItem.largeTitleDisplayMode = .never
        view.backgroundColor = color.Style.color(mainColor: UIColor.AppColors.mainBackground, darkModeCorlor: UIColor.AppColors.mainBackgroundDarkMode)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save".localized(), style: .plain, target: self, action: #selector(saveButtonPressed))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel".localized(), style: .plain, target: self, action: #selector(cancel))
    }
    
    @objc func cancel() {
        navigationController?.popViewController(animated: false)
    }
    
    @objc func saveButtonPressed() {
        if editMode {
            updateItem()
        } else {
            let newPass = MPassword(itemName: newName!, userName: newLogin, password: newPassword, serviceURL: newUrl!, imageURL: generatedImageName!)
            DatabaseManager.saveToDataBase(item: newPass)
        }
        navigationController?.popViewController(animated: false)
    }
    
    func updateItem() {
        
        if newName != "" && newName != item?.itemName {
            DatabaseManager.up_Date(id: item!.id, forKey: "itemName", newValue: newName!)
        }
        if newUrl != "" && newUrl != item?.serviceURL {
            DatabaseManager.up_Date(id: item!.id, forKey: "serviceURL", newValue: newUrl)
        }
        if newLogin != "" && newLogin != item?.userName {
            DatabaseManager.up_Date(id: item!.id, forKey: "userName", newValue: newLogin)
        }
        if newPassword != "" && newPassword != item?.passwordString {
            DatabaseManager.up_Date(id: item!.id, forKey: "passwordString", newValue: newPassword)
        }
    }
    
}

extension EditVC: DataModelDelegate {
    func didRecieveDataUpdate(data: MPassword) {
        self.item = data
    }
}
