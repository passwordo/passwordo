//
//  SettingsVC.swift
//  Passwordo
//
//  Created by Boris Goncharov on 1/16/21.
//  Copyright © 2021 Boris Goncharov. All rights reserved.
//

import UIKit

struct Sections {
    let title: String
    let options: [SettingsOption]
}

struct SettingsOption {
    let title: String
    let icon: UIImage?
    let iconBackgroundColor: UIColor
    let handler: (() -> Void)
}

class SettingsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(SettingsTableViewCell.self, forCellReuseIdentifier: SettingsTableViewCell.identifier)
        return table
    }()
    
    var models = [Sections]()
    
    let myNav = UINavigationBar(frame: CGRect.zero)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        title = "Settings"
        
        myNav.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(tableView)
        view.addSubview(myNav)
        myNav.backgroundColor = .blue
        tableView.frame = view.bounds
        
        configure()
        
        tableView.delegate = self
        tableView.dataSource = self
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButtonPressed))
    }
    
    
    private func configure() {
        self.models.append(Sections(title: "General", options: [
            SettingsOption(title: "Wi-Fi", icon: UIImage(systemName: "house"), iconBackgroundColor: .systemPink) {
                print("Tapped first cell")
            },
            SettingsOption(title: "Airplane", icon: UIImage(systemName: "airplane"), iconBackgroundColor: .link) {
                
            },
            SettingsOption(title: "Icloud", icon: UIImage(systemName: "icloud"), iconBackgroundColor: .orange) {
                
            },
        ]))
        
        self.models.append(Sections(title: "Information", options: [
            SettingsOption(title: "Wi-Fi", icon: UIImage(systemName: "house"), iconBackgroundColor: .systemPink) {
                
            },
            SettingsOption(title: "Airplane", icon: UIImage(systemName: "airplane"), iconBackgroundColor: .link) {
                
            },
            SettingsOption(title: "Icloud", icon: UIImage(systemName: "icloud"), iconBackgroundColor: .orange) {
                
            },
        ]))
        
        self.models.append(Sections(title: "Something else", options: [
            SettingsOption(title: "Wi-Fi", icon: UIImage(systemName: "house"), iconBackgroundColor: .systemPink) {
                
            },
            SettingsOption(title: "Airplane", icon: UIImage(systemName: "airplane"), iconBackgroundColor: .link) {
                
            },
            SettingsOption(title: "Icloud", icon: UIImage(systemName: "icloud"), iconBackgroundColor: .orange) {
                
            },
        ]))
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = models[section]
        return section.title
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        models.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.section].options[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.identifier, for: indexPath) as? SettingsTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = models[indexPath.section].options[indexPath.row]
        model.handler()
    }
    
    @objc func doneButtonPressed() {
        dismiss(animated: true, completion: nil)
    }
}
