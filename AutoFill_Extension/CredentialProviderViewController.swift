//
//  CredentialProviderViewController.swift
//  AutoFill_Extension
//
//  Created by Boris Goncharov on 12/27/20.
//  Copyright © 2020 Boris Goncharov. All rights reserved.
//

import AuthenticationServices
import RealmSwift

class CredentialProviderViewController: ASCredentialProviderViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
//    @IBOutlet weak var itemImageView: UIImageView!
//    @IBOutlet weak var itemTextLabel: UILabel!
//    @IBOutlet weak var itemDescriptionLabel: UILabel!
    
    
    private var passwordItems: Results<MPassword>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        tableView.register(CredentialTableViewCell.self, forCellReuseIdentifier: "cell")

//        navigationBar.topItem?.leftBarButtonItem = nil

        navigationBar.topItem?.rightBarButtonItem = nil
 
    }
    
    

    /*
     Prepare your UI to list available credentials for the user to choose from. The items in
     'serviceIdentifiers' describe the service the user is logging in to, so your extension can
     prioritize the most relevant credentials in the list.
    */
    override func prepareCredentialList(for serviceIdentifiers: [ASCredentialServiceIdentifier]) {
//        navigationBar.topItem?.leftBarButtonItem = cancelButton
//
//        if serviceIdentifiers.count == 1 {
//            passwordItems = DatabaseManager.all().filter("serviceURL like %@", serviceIdentifiers.first!.domainForFilter)
//        }
//        if passwordItems.first == nil {
            passwordItems = DatabaseManager.all()
//        }
        
        tableView.reloadData()
    }

    /*
     Implement this method if your extension supports showing credentials in the QuickType bar.
     When the user selects a credential from your app, this method will be called with the
     ASPasswordCredentialIdentity your app has previously saved to the ASCredentialIdentityStore.
     Provide the password by completing the extension request with the associated ASPasswordCredential.
     If using the credential would require showing custom UI for authenticating the user, cancel
     the request with error code ASExtensionError.userInteractionRequired.
     */

//    override func provideCredentialWithoutUserInteraction(for credentialIdentity: ASPasswordCredentialIdentity) {
//        let databaseIsUnlocked = true
//        if (databaseIsUnlocked) {
//            let passwordCredential = ASPasswordCredential(user: "j_appleseed", password: "apple1234")
//            self.extensionContext.completeRequest(withSelectedCredential: passwordCredential, completionHandler: nil)
//        } else {
//            self.extensionContext.cancelRequest(withError: NSError(domain: ASExtensionErrorDomain, code:ASExtensionError.userInteractionRequired.rawValue))
//        }
//    }
//
    

//    override func provideCredentialWithoutUserInteraction(for credentialIdentity: ASPasswordCredentialIdentity) {
//        passwordItems = DatabaseManager.all()
//
//        tableView.reloadData()
//    }
    
//
    override func provideCredentialWithoutUserInteraction(for credentialIdentity: ASPasswordCredentialIdentity) {

        let id = credentialIdentity.recordIdentifier!
        let passwordItem = DatabaseManager.search(searchText: id)

        let passwordCredential = ASPasswordCredential(user: passwordItem[0].userName, password: passwordItem[0].passwordString)
        extensionContext.completeRequest(withSelectedCredential: passwordCredential, completionHandler: nil)
    }
    
    

    /*
     Implement this method if provideCredentialWithoutUserInteraction(for:) can fail with
     ASExtensionError.userInteractionRequired. In this case, the system may present your extension's
     UI and call this method. Show appropriate UI for authenticating the user then provide the password
     by completing the extension request with the associated ASPasswordCredential.
     */
    
    
    override func prepareInterfaceToProvideCredential(for credentialIdentity: ASPasswordCredentialIdentity) {
        print("prepareInterfaceToProvideCredential start")
        if let id = credentialIdentity.recordIdentifier {
            passwordItems = DatabaseManager.all().filter("id = %@", id)
        } else {
            passwordItems = DatabaseManager.all().filter("serviceURL like %@", credentialIdentity.serviceIdentifier.domainForFilter)
        }
        tableView.reloadData()

    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let passwordItems = passwordItems else {
            return 0
        }
        return passwordItems.count
//        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let passwordItem = passwordItems[indexPath.row]
        
//        let image = FilesHandling.getImage(withName: passwordItem.imageURL)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CredentialTableViewCell
        cell.setupCell(item: passwordItem)
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let passwordItem = passwordItems[indexPath.row]
        extensionContext.completeRequest(withSelectedCredential: ASPasswordCredential(user: passwordItem.userName, password: passwordItem.passwordString), completionHandler: nil)
    }

    @IBAction func cancel(_ sender: AnyObject?) {
        self.extensionContext.cancelRequest(withError: NSError(domain: ASExtensionErrorDomain, code: ASExtensionError.userCanceled.rawValue))
    }
}
