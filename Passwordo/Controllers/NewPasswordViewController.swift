//
//  NewPasswordViewController.swift
//  Passwordo
//
//  Created by Boris Goncharov on 12/6/20.
//  Copyright © 2020 Boris Goncharov. All rights reserved.
//

import UIKit

class NewPasswordViewController: UIViewController {
    
    let navbar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width , height: 58))
    
    var loginLabel: UILabel = {
        let label = UILabel()
        label.text = "Login"
        label.font = UIFont(name: "AvenirNext-Medium", size: 17)
        return label
    }()
    
    var passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "Password"
        label.font = UIFont(name: "AvenirNext-Medium", size: 17)
        return label
    }()
    
    var websiteLabel: UILabel = {
        let label = UILabel()
        label.text = "Web site"
        label.font = UIFont(name: "AvenirNext-Medium", size: 17)
        return label
    }()
    
    var loginTextField: UITextField = {
        let tf = UITextField()
        tf.layer.borderWidth = 1
        tf.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        tf.layer.cornerRadius = 4
        tf.placeholder = "Type login here"
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: tf.frame.height))
        tf.leftView = paddingView
        tf.leftViewMode = .always
        return tf
    }()
    
    var passwordTextField: UITextField = {
        let tf = UITextField()
        tf.layer.borderWidth = 1
        tf.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        tf.layer.cornerRadius = 4
        tf.placeholder = "Type password here"
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: tf.frame.height))
        tf.leftView = paddingView
        tf.leftViewMode = .always
        return tf
    }()
    
    var websiteTextField: UITextField = {
        let tf = UITextField()
        tf.layer.borderWidth = 1
        tf.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        tf.layer.cornerRadius = 4
        tf.placeholder = "Web site"
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: tf.frame.height))
        tf.leftView = paddingView
        tf.leftViewMode = .always
        return tf
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setup()
        loginTextField.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.post(name: Notification.Name(rawValue: "Data"), object: nil)
    }
    
    private func setup() {
        view.addSubview(navbar)
        navbar.backgroundColor = UIColor.systemGray6
        navbar.delegate = self
        let navItem = UINavigationItem()
        navItem.title = "Add new password"
        navItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(pressCancelButton))
        navItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveNewItem))
        navbar.items = [navItem]
        
        let loginStack = UIStackView(arrangedSubviews: [loginLabel, loginTextField])
        loginStack.axis = .vertical
        loginStack.spacing = 8
        loginStack.translatesAutoresizingMaskIntoConstraints = false
        
        let passwordStack =  UIStackView(arrangedSubviews: [passwordLabel, passwordTextField])
        passwordStack.axis = .vertical
        passwordStack.spacing = 8
        
        let websiteStack =  UIStackView(arrangedSubviews: [websiteLabel, websiteTextField])
        websiteStack.axis = .vertical
        websiteStack.spacing = 8
        
        let stack = UIStackView(arrangedSubviews: [loginStack, passwordStack, websiteStack])
        stack.axis = .vertical
        stack.spacing = 16
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)
        
        NSLayoutConstraint.activate([
            loginTextField.heightAnchor.constraint(equalToConstant: 42),
            passwordTextField.heightAnchor.constraint(equalToConstant: 42),
            websiteTextField.heightAnchor.constraint(equalToConstant: 42),
            
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -200)
        ])
        
    }
    
    @objc private func pressCancelButton() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func saveNewItem() {
        guard let login = loginTextField.text, let password = passwordTextField.text, let website = websiteTextField.text else { return }
        if login.isEmpty || password.isEmpty ||  website.isEmpty {
            //loginTextField.layer.borderColor = CGColor(red: 1, green: 0.2, blue: 0.1, alpha: 0.1)
        } else {
            let newPass = MPassword(itemName: website, userName: login, password: password, serviceURL: website, imageURL: "fb")
            print(newPass)
            DatabaseManager().saveToDataBase(item: newPass)
            self.dismiss(animated: true, completion: nil)
        }
    }
}

extension NewPasswordViewController: UINavigationBarDelegate {
    
}
