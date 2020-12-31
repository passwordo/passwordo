//
//  PasswordGeneratorVC.swift
//  Passwordo
//
//  Created by Boris Goncharov on 12/25/20.
//  Copyright © 2020 Boris Goncharov. All rights reserved.
//

import Foundation
import UIKit

class PasswordGeneratorVC: UITableViewController, Colorable {
    
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var lengthLabel: UILabel!
    @IBOutlet weak var lengthSlider: UISlider!
    @IBOutlet weak var includeLowerCell: UITableViewCell!
    @IBOutlet weak var includeUpperCell: UITableViewCell!
    @IBOutlet weak var includeSpecialCell: UITableViewCell!
    @IBOutlet weak var includeDigitsCell: UITableViewCell!
    @IBOutlet weak var includeLookAlikeCell: UITableViewCell!
    
    var lowerOn = true
    var upperOn = true
    var specialOn = true
    var digitsOn = true
    var lookLikeOn = false
    var passwordLenght = 20
    
    typealias CompletionHandler = ((String) -> Void)
    
    private var password = ""
    private var completionHandler: CompletionHandler?
    
    static func make(completion: CompletionHandler?) -> UIViewController {
        let vc = PasswordGeneratorVC.instantiateFromStoryboard()
        vc.completionHandler = completion
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        
        setupSettungs()
        refresh()
    }
    
    private func setupSettungs() {
        lengthSlider.value = 20
        lengthLabel.text = "20"
        
        includeLowerCell.accessoryType = .checkmark
        includeUpperCell.accessoryType = .checkmark
        includeSpecialCell.accessoryType = .checkmark
        includeDigitsCell.accessoryType = .checkmark
        includeLookAlikeCell.accessoryType = .none
    }
    
    func refresh() {
        var gotChars = false
        var params: Set<PasswordGenerator.Parameters> = []
        if lowerOn {
            params.insert(.includeLowerCase)
            gotChars = true
        }
        if upperOn {
            params.insert(.includeUpperCase)
            gotChars = true
        }
        if specialOn {
            params.insert(.includeSpecials)
            gotChars = true
        }
        if digitsOn {
            params.insert(.includeDigits)
            gotChars = true
        }
        if lookLikeOn {
            params.insert(.includeLookAlike)
        }
        
        guard gotChars else {
            password = ""
            passwordLabel.text = " "
            return
        }
        
        do {
            password = try PasswordGenerator.generate(
                length: passwordLenght,
                parameters: params)
            let range = attributedNumberString(string: password, numberAttribute: [NSAttributedString.Key.foregroundColor: UIColor.systemRed])
            passwordLabel.attributedText = range
        } catch {
            print("error")
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let selectedRow = tableView.cellForRow(at: indexPath) else { return }
        
        if selectedRow === includeLowerCell {
            lowerOn = !lowerOn
            includeLowerCell.accessoryType = lowerOn ? .checkmark : .none
        } else if selectedRow === includeUpperCell {
            upperOn = !upperOn
            includeUpperCell.accessoryType = upperOn ? .checkmark : .none
        } else if selectedRow === includeSpecialCell {
            specialOn = !specialOn
            includeSpecialCell.accessoryType = specialOn ? .checkmark : .none
        } else if selectedRow === includeDigitsCell {
            digitsOn = !digitsOn
            includeDigitsCell.accessoryType = digitsOn ? .checkmark : .none
        }
        else if selectedRow === includeLookAlikeCell {
            lookLikeOn = !lookLikeOn
            includeLookAlikeCell.accessoryType = lookLikeOn ? .checkmark : .none
        }
        refresh()
    }
    
    @IBAction func didChangeLenghtSlider(_ sender: Any) {
        let newLenght = Int(lengthSlider.value)
        passwordLenght = newLenght
        lengthLabel.text = "\(newLenght)"
        
        refresh()
    }
    
    @IBAction func didPressDone(_ sender: Any) {
        completionHandler?(password)
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didPressRefresh(_ sender: Any) {
        refresh()
    }
    
    
}
