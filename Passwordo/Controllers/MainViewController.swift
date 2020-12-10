//
//  TableViewController.swift
//  Passwordo
//
//  Created by Boris Goncharov on 7/10/20.
//  Copyright © 2020 Boris Goncharov. All rights reserved.
//

import UIKit
import RealmSwift
//import LocalAuthentication


class MainViewController: UITableViewController {
        
    var db = DatabaseManager()
    
    let searchBar = UISearchController()
    private var notificationToken: NotificationToken!
    
    var passwordItems: Results<MPassword>!
    
    var loginsDictionary = [String: [String]]()
    var loginSectionTitles = [String]()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        passwordItems = db.all()
        tableView.reloadData()
        print(passwordItems!)
//        tableView?.dataSource = self;
//        tableView?.delegate = self;
//        notificationToken = passwordItems.observe(updateTableView)
        self.setup()
    }
    

//
//    override func viewWillAppear(_ animated: Bool) {
//        self.tableView.reloadData()
//    }


    
//    private func updateTableView(_ changes: RealmCollectionChange<Results<MPassword>>) {
//        switch changes {
//        case .initial:
//            tableView.reloadData()
//
//        case .update(_, let deletions, let insertions, let modifications):
//            tableView.beginUpdates()
//            tableView.reloadSections(IndexSet(integer: insertions[0]), with: .automatic)
////            tableView.insertRows(at: [IndexPath(row: 0, section: insertions[0])], with: .automatic)
////            tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0)}), with: .automatic)
////            tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }), with: .automatic)
//            tableView.endUpdates()
////            self.tableView.reloadData()
//
//        case .error(let error):
//            fatalError("\(error)")
//        }
//    }
        
    private func setup() {
        navigationItem.searchController = searchBar
        tableView.tableFooterView = UIView()

        for item in passwordItems {
            //print(item)
            
            let loginKey = String(item.itemName.prefix(1))
            
            if var loginValues = loginsDictionary[loginKey] {
                //print(loginValues)
                loginValues.append(item.id)
                loginsDictionary[loginKey] = loginValues
            } else {
                loginsDictionary[loginKey] = [item.id]
            }
        }

        loginSectionTitles = [String](loginsDictionary.keys)
        loginSectionTitles = loginSectionTitles.sorted(by: { $0 < $1 })
        
        navigationController?.navigationBar.prefersLargeTitles = true
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
    
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
 
    }
    

    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return loginSectionTitles[section]
    }

    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return loginSectionTitles
    }

    @IBAction func addNewItem(_ sender: Any) {
        
        let newItemVC = NewPasswordViewController()
        
        
//        navigationController?.pushViewController(newItemVC, animated: true)
        present(newItemVC, animated: true, completion: nil)
        
    }
    
}
