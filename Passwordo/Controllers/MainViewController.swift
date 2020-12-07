//
//  TableViewController.swift
//  Passwordo
//
//  Created by Boris Goncharov on 7/10/20.
//  Copyright © 2020 Boris Goncharov. All rights reserved.
//

import UIKit
//import LocalAuthentication

class MainViewController: UITableViewController {
    
    
    let passwords: [MPassword] = [
        MPassword(itemName: "Facebook", userName: "UserName", password: "12345678", serviceURL: "fb.com", imageURL: "fb"),
        MPassword(itemName: "Instagram", userName: "UserName", password: "12345678", serviceURL: "insta.com", imageURL: "fb"),
        MPassword(itemName: "Fedor Network", userName: "UserName", password: "12345678", serviceURL: "fedor.com", imageURL: "fb"),
        MPassword(itemName: "Amazon", userName: "UserName", password: "12345678", serviceURL: "amazon.com", imageURL: "fb"),
        MPassword(itemName: "Dash", userName: "UserName", password: "12345678", serviceURL: "dash.com", imageURL: "fb"),
        MPassword(itemName: "Twitter", userName: "UserName", password: "12345678", serviceURL: "twitter.com", imageURL: "fb"),
        MPassword(itemName: "VKontakte", userName: "UserName", password: "12345678", serviceURL: "vk.com", imageURL: "fb"),
    ]
    
    var loginsDictionary = [String: [String]]()
    var loginSectionTitles = [String]()
    var logins = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setup()
    }
        
    private func setup() {
        //tableView.register(ItemTableViewCell.self, forCellReuseIdentifier: "cell")

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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ItemTableViewCell
        
        let loginKey = loginSectionTitles[indexPath.section]
        if let loginValues = loginsDictionary[loginKey] {
            cell.setup()
            cell.itemNameLabel?.text = loginValues[indexPath.row]
            cell.itemLoginLabel?.text = "test login text 123"
            cell.itemImage.image = UIImage(named: "fb")
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
    

    @IBAction func addNewItem(_ sender: Any) {
        
        let newItemVC = NewPasswordViewController()
        
        navigationController?.pushViewController(newItemVC, animated: true)
        
    }
    
}
