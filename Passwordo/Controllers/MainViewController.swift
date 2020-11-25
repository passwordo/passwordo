//
//  TableViewController.swift
//  Passwordo
//
//  Created by Boris Goncharov on 7/10/20.
//  Copyright © 2020 Boris Goncharov. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController {
    
    
    var loginsDictionary = [String: [String]]()
    var loginSectionTitles = [String]()
    var logins = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
       setup()
    }
    
    
    private func setup() {
        var passwords: [MPassword] = [MPassword(itemName: "Facebook", userName: "UserName", password: "12345678", serviceURL: UIImage(named: "fb")!)]
        
        for item in passwords {
            let loginKey = String(item.itemName.prefix(1))
            if var loginValues = loginsDictionary[loginKey] {
                loginValues.append(item.itemName)
                loginsDictionary[loginKey] = loginValues
            } else {
                loginsDictionary[loginKey] = [item.itemName]
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ItemTableViewCell

        // Configure the cell...
        let loginKey = loginSectionTitles[indexPath.section]
        if let loginValues = loginsDictionary[loginKey] {
            cell?.textLabel?.text = loginValues[indexPath.row]
        }

        return cell!
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return loginSectionTitles[section]
    }

    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return loginSectionTitles
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
