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
    
    var item: MPassword?
    var viewModel: EditViewModel?
    weak var delegate: DataModelDelegate?
    
    let db = DatabaseManager()
    let applyColor = DefaultStyle()
    
    var generatedImageName: String?
    var editMode = true
    
    private var newName: String!
    private var newUrl: String!
    private var newLogin: String!
    private var newPassword = ""
    
    @Published var checker: [Bool] = [false, false, false]
        
    var tableView = UITableView(frame: .zero, style: .grouped)
    
    private var subscribers = Set<AnyCancellable>()
 
    override func viewDidLoad() {
        super.viewDidLoad()

        if !editMode {
            generatedImageName = randomString(length: 12)
        }

        setupLaunch()
        setupTableView()
        setupCells()
        setupView()
        setupObservers()
        deleteButton()
        
        observeForm()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("viewDidDisappear VC")
        item = nil
        generatedImageName = nil
        
        NotificationCenter.default.removeObserver(self)
        
//        NotificationCenter.default.removeObserver(self, name: .didSaveButtonPress, object: nil)
//        NotificationCenter.default.removeObserver(self, name: .didUpdateLogin, object: nil)
//        NotificationCenter.default.removeObserver(self, name: .didUpdateName, object: nil)
//        NotificationCenter.default.removeObserver(self, name: .didUpdateUrl, object: nil)
//        NotificationCenter.default.removeObserver(self, name: .didUpdatePassword, object: nil)
//        NotificationCenter.default.removeObserver(self, name: .didPasswordGenerationButtonTapped, object: nil)
        }
    
    // MARK: - setupLaunch()
    
    private func setupLaunch() {
        
        if editMode {
            viewModel = EditViewModel(item: item!)
            checker = [true, true, true]
        } else {
            item = MPassword(itemName: "", userName: "", password: "", serviceURL: "", imageURL: generatedImageName!)
            checker = [false, false, false]
        }
    }
    
    // MARK: - setupTableView()
    
    private func setupTableView() {
        
        if !editMode {
            viewModel = EditViewModel(item: item!)
        }
        
        tableView.dataSource = viewModel
        tableView.delegate = viewModel
        
        tableView.allowsSelection = false
        
        tableView.backgroundColor = applyColor.Style.setColor(mainColor: UIColor.AppColors.mainBackground, darkModeCorlor: UIColor.AppColors.mainBackgroundDarkMode)
        
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
    
    // MARK: - setupCells()
    
    private func setupCells() {
        tableView.register(EditNamePictureCell.nib, forCellReuseIdentifier: EditNamePictureCell.identifier)
        tableView.register(EditUrlCell.nib, forCellReuseIdentifier: EditUrlCell.identifier)
        tableView.register(EditLoginCell.nib, forCellReuseIdentifier: EditLoginCell.identifier)
        tableView.register(EditPasswordCell.nib, forCellReuseIdentifier: EditPasswordCell.identifier)
    }
    
    // MARK: - setupView()
    
    private func setupView() {
        
        navigationItem.largeTitleDisplayMode = .never
        view.backgroundColor = applyColor.Style.setColor(mainColor: UIColor.AppColors.mainBackground, darkModeCorlor: UIColor.AppColors.mainBackgroundDarkMode)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save".localized(), style: .plain, target: self, action: #selector(saveButtonPressed))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel".localized(), style: .plain, target: self, action: #selector(cancel))
    }
    
    // MARK: - setupObservers()

    private func setupObservers() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleNameUpdate), name: .didUpdateName, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleUrlUpdate), name: .didUpdateUrl, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleLoginUpdate), name: .didUpdateLogin, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handlePasswordUpdate), name: .didUpdatePassword, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handlePasswordGeneration), name: .didPasswordGenerationButtonTapped, object: nil)
    }
    
    // MARK: - observeForm()
    
    private func observeForm() {

        $checker.sink { (checks) in
            if checks.allSatisfy({$0}) {
                self.navigationItem.rightBarButtonItem?.isEnabled = true
            } else {
                self.navigationItem.rightBarButtonItem?.isEnabled = false
            }
        }.store(in: &subscribers)
    }
    
    
    // MARK: - editModeEnable()
    
    func enableEditMode() {
        editMode = false
    }
    
    // MARK: - updateItem()
    
    func updateItem() {
        
        if newName != nil && newName != item?.itemName {
            DatabaseManager.updateItem(id: item!.id, forKey: "itemName", newValue: newName!)
        }
        if newUrl != nil && newUrl != item?.serviceURL {
            DatabaseManager.updateItem(id: item!.id, forKey: "serviceURL", newValue: newUrl)
        }
        if newLogin != nil && newLogin != item?.userName {
            DatabaseManager.updateItem(id: item!.id, forKey: "userName", newValue: newLogin)
        }
        if newPassword != item?.passwordString {
            DatabaseManager.updateItem(id: item!.id, forKey: "passwordString", newValue: newPassword)
        }
    }
    
    // MARK: - @objc funcs
    
    @objc func handlePasswordGeneration() {
        
        let vc = PasswordGeneratorVC.make { [weak self] (password) in
            self?.newPassword = password
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
    
    @objc func cancel() {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "didCancelButtonPress"), object: nil)
        navigationController?.popViewController(animated: false)
    }
    
    @objc func saveButtonPressed() {
        if editMode {
            updateItem()
        } else {
            let newPass = MPassword(itemName: newName!, userName: newLogin, password: newPassword, serviceURL: newUrl!, imageURL: generatedImageName!)
            DatabaseManager.saveToDataBase(item: newPass)
        }
        NotificationCenter.default.post(name: Notification.Name(rawValue: "didSaveButtonPress"), object: nil)
        navigationController?.popViewController(animated: false)
        item = nil
        generatedImageName = nil
    }
    
    // MARK: - deinit
    
    deinit {
        print("Deinit VC")
        
        NotificationCenter.default.removeObserver(self, name: .didSaveButtonPress, object: nil)
        NotificationCenter.default.removeObserver(self, name: .didUpdateName, object: nil)
        NotificationCenter.default.removeObserver(self, name: .didUpdateUrl, object: nil)
        NotificationCenter.default.removeObserver(self, name: .didUpdatePassword, object: nil)
        NotificationCenter.default.removeObserver(self, name: .didPasswordGenerationButtonTapped, object: nil)
    }
    
    
    private func deleteButton() {
        if editMode {
            
            let deleteButton: UIButton = {
                let button = UIButton()
                button.setTitle("Delete", for: .normal)
                button.backgroundColor = .red
                button.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
                return button
            }()
            
            let deleteView = UIView()
            deleteView.backgroundColor = applyColor.Style.setColor(mainColor: UIColor.AppColors.cellBackgroundColor, darkModeCorlor: UIColor.AppColors.cellBackgroundColorDarkMode)
            
            deleteView.translatesAutoresizingMaskIntoConstraints = false
            deleteButton.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(deleteView)
            view.addSubview(deleteButton)
            
            
            NSLayoutConstraint.activate([
                deleteView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                deleteView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                deleteView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                deleteView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.height / 10),
            ])
            
            deleteButton.centerYAnchor.constraint(equalTo: deleteView.centerYAnchor).isActive = true
            deleteButton.centerXAnchor.constraint(equalTo: deleteView.centerXAnchor).isActive = true
            
            
        }
    }
}

// MARK: - DataModelDelegate

extension EditVC: DataModelDelegate {
    func didRecieveDataUpdate(data: MPassword) {
        self.item = data
    }
}
