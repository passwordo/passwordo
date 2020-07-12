//
//  TableViewController.swift
//  Passwordo
//
//  Created by Boris Goncharov on 7/10/20.
//  Copyright © 2020 Boris Goncharov. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    
    var loginsDictionary = [String: [String]]()
    var loginSectionTitles = [String]()
    var logins = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        logins = ["Facebook", "Gmail","VK", "Skype", "Skype","Github", "Facebook","Login1","Jogin2", "Login3","Pass1","Pass2","Pass3","Stack Overflow", "Utube",]
        
        for login in logins {
            let loginKey = String(login.prefix(1))
            if var loginValues = loginsDictionary[loginKey] {
                loginValues.append(login)
                loginsDictionary[loginKey] = loginValues
            } else {
                loginsDictionary[loginKey] = [login]
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
        let carKey = loginSectionTitles[section]
        if let carValues = loginsDictionary[carKey] {
            return carValues.count
        }
        
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        // Configure the cell...
        let carKey = loginSectionTitles[indexPath.section]
        if let carValues = loginsDictionary[carKey] {
            cell.textLabel?.text = carValues[indexPath.row]
        }

        return cell
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
