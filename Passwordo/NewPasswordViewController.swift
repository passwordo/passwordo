//
//  NewPasswordViewController.swift
//  Passwordo
//
//  Created by Boris Goncharov on 7/11/20.
//  Copyright © 2020 Boris Goncharov. All rights reserved.
//

import UIKit
import Eureka

class NewPasswordViewController: FormViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        form +++
        MultivaluedSection(multivaluedOptions: [.Reorder, .Insert, .Delete],
                           header: "Multivalued TextField",
                           footer: ".Insert adds a 'Add Item' (Add New Tag) button row as last cell.") {
            $0.addButtonProvider = { section in
                return ButtonRow(){
                    $0.title = "Add New Tag"
                }
            }
            $0.multivaluedRowToInsertAt = { index in
                return NameRow() {
                    $0.placeholder = "Tag Name"
                }
            }
            $0 <<< NameRow() {
                $0.placeholder = "Tag Name"
            }
        }
        }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
