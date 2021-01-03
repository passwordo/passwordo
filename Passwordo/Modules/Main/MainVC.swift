//
//  MainVC.swift
//  Passwordo
//
//  Created by Boris Goncharov on 7/10/20.
//  Copyright © 2020 Boris Goncharov. All rights reserved.
//

import UIKit
import RealmSwift
import EmptyDataSet_Swift

class MainVC: UITableViewController, UISearchControllerDelegate, Emptyble {

    let applyColor = DefaultStyle()
    var db = DatabaseManager()
    weak var dataDelegate: DataModelDelegate?
    
    var passwordItems: Results<MPassword>!
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    var timer: Timer?
    
    var loginsDictionary = [String: [String]]()
    var loginSectionTitles = [String]()
    
    // MARK: - viewDidLoad()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        passwordItems = DatabaseManager.all()
        setupView()
        setupObservers()
        emptyTableView(forEmptyDataSet: tableView)
    }
    
    deinit {
        // Remove observer
        NotificationCenter.default.removeObserver(self, name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        passwordItems = DatabaseManager.all()
        createSections()
        self.tableView.reloadData()
    
    }
    
    // MARK: - setupObservers()
    
    private func setupObservers() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: NSNotification.Name(rawValue: "Data"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadAfterSearch), name: NSNotification.Name(rawValue: "searchData"), object: nil)
    }
    
    // MARK: - setupView()
    
    private func setupView() {
        
        createSections()
        
        navigationItem.searchController = searchController
        navigationItem.largeTitleDisplayMode = .always
        
        
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
        
        tableView.tableFooterView = UIView()
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 1))
        tableView.backgroundColor = applyColor.Style.color(mainColor: UIColor.AppColors.mainBackground, darkModeCorlor: UIColor.AppColors.mainBackgroundDarkMode)
    }
    
    // MARK: - createSections()
    
    private func createSections() {
        
        loginsDictionary = [String: [String]]()
        loginSectionTitles = [String]()
        
        for item in passwordItems {
            let loginKey = String(item.itemName.prefix(1).uppercased())
            if var loginValues = loginsDictionary[loginKey] {
                if !loginValues.contains(item.id) {
                    loginValues.append(item.id)
                }
                loginsDictionary[loginKey] = loginValues
            } else {
                loginsDictionary[loginKey] = [item.id]
            }
        }
        
        loginSectionTitles = [String](loginsDictionary.keys)
        loginSectionTitles = loginSectionTitles.sorted(by: { $0 < $1 })
    }
    
    // MARK: - UITableViewDelegate
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return loginSectionTitles.count
    }
    
    // MARK: - numberOfRowsInSection
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let loginKey = loginSectionTitles[section]
        if let loginValues = loginsDictionary[loginKey] {
            return loginValues.count
        }
        return 0
    }
    
    // MARK: - cellForRowAt
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ItemTableViewCell
        
        let loginKey = loginSectionTitles[indexPath.section].uppercased()
        
        if let loginValues = loginsDictionary[loginKey] {
            let item = passwordItems.first(where: { $0.id == loginValues[indexPath.row] })
            cell.setupCell(item: item!)
            cell.setup()
        }
        return cell
    }
    
    // MARK: - titleForHeaderInSection
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return loginSectionTitles[section]
    }
    
    // MARK: - sectionForSectionIndexTitle
    
    override func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return loginSectionTitles.firstIndex(where: { $0.uppercased() == title })!
    }
    
    // MARK: - willDisplayHeaderView
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        header.contentView.backgroundColor = applyColor.Style.color(mainColor: UIColor.AppColors.sectionHeaderBackground, darkModeCorlor: UIColor.AppColors.sectionHeaderBackgroundDarkMode)
    }
    
    // MARK: - sectionIndexTitles
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return loginSectionTitles
    }
    
    // MARK: - editingStyle
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let loginKey = loginSectionTitles[indexPath.section].uppercased()
        
        if let loginValue = loginsDictionary[loginKey] {
            let item = passwordItems.first(where: { $0.id == loginValue[indexPath.row] })
            
            if editingStyle == .delete {
                FilesHandling.deleteImage(withName: "\(item!.imageURL).png")
                DatabaseManager.deleteFromDataBase(item: item!)
                reload()
            }
        }
    }
    
    // MARK: - didSelectRowAt
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? ItemTableViewCell {
            let item = passwordItems.first(where: { $0.id == cell.itemId })
            
            let vc = CheckoutVC()
            vc.didRecieveDataUpdate(data: item!)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    // MARK: - @objc funcs
    
    @objc func reload() {
        passwordItems = DatabaseManager.all()
        createSections()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    @objc func reloadAfterSearch() {
        createSections()
        tableView.reloadData()
    }
    
    @IBAction func addNewItemButtonPressed(_ sender: Any) {
        let newItemVC = EditVC()
        newItemVC.editModeEnable()
        navigationController?.pushViewController(newItemVC, animated: true)
    }
}

// MARK: - UISearchBarDelegate

extension MainVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        timer?.invalidate()
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false, block: { (_) in
            if searchText.isEmpty{
                self.passwordItems = DatabaseManager.all()
            } else {
                self.passwordItems = DatabaseManager.search(searchText: searchText)
            }
            
            if self.passwordItems.count == 0 {
                self.noSearchResults(forEmptyDataSet: self.tableView)
            }
            
            NotificationCenter.default.post(name: Notification.Name(rawValue: "searchData"), object: nil)
        })
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.passwordItems = DatabaseManager.all()
        emptyTableView(forEmptyDataSet: tableView)
        NotificationCenter.default.post(name: Notification.Name(rawValue: "Data"), object: nil)
    }
}
