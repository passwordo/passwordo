//
//  TableViewController.swift
//  Passwordo
//
//  Created by Boris Goncharov on 7/10/20.
//  Copyright © 2020 Boris Goncharov. All rights reserved.
//

import UIKit
import RealmSwift

class MainViewController: UITableViewController {
    
    private let searchBar = UISearchController()
        
    var db = DatabaseManager()
    var passwordItems: Results<MPassword>!
    
    var loginsDictionary = [String: [String]]()
    var loginSectionTitles = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        passwordItems = db.all()
        self.setup()
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: NSNotification.Name(rawValue: "Data"), object: nil)
    }
    
    deinit {
        // Remove observer
        NotificationCenter.default.removeObserver(self, name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    @objc func reload() {
        passwordItems = db.all()
        createSections()
        print(passwordItems!)
        tableView.reloadData()
    }
    
        
    private func setup() {
        createSections()
        navigationItem.searchController = searchBar
        tableView.tableFooterView = UIView()
        searchBar.obscuresBackgroundDuringPresentation = false
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func createSections() {
        
        for item in passwordItems {
            let loginKey = String(item.itemName.prefix(1))
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

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return loginSectionTitles.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let loginKey = loginSectionTitles[section]
        if let loginValues = loginsDictionary[loginKey] {
            return loginValues.count
        }
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ItemTableViewCell
        
        let loginKey = loginSectionTitles[indexPath.section]
        
        if let loginValues = loginsDictionary[loginKey] {
            let item = passwordItems.first(where: { $0.id == loginValues[indexPath.row] })
            cell.setup()

            cell.textLabel?.text = item?.itemName
            cell.detailTextLabel?.text = item?.userName
            cell.imageView?.layer.cornerRadius = 6
            cell.imageView?.layer.masksToBounds = true
            cell.imageView?.image = item?.image
        }
        return cell
    }
    


    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return loginSectionTitles[section]
    }

    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return loginSectionTitles
    }

    @IBAction func addNewItem(_ sender: Any) {
        
        let newItemVC = NewPasswordViewController()
        present(newItemVC, animated: true, completion: nil)

    }
}
