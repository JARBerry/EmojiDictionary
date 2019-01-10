//
//  AddEditEmojiTableViewController.swift
//  EmojiDictionary
//
//  Created by James and Ray Berry on 06/12/2018.
//  Copyright © 2018 JARBerry. All rights reserved.
//

import UIKit

class AddEditEmojiTableViewController: UITableViewController {

       var emoji : Emoji?
    
    
    @IBOutlet weak var symbolTextField: UITextField!
 
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var descriptionTextField: UITextField!
    
    
    @IBOutlet weak var usageTextField: UITextField!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // update view fields with model fields - load up symbol, name and description
        
        if let emoji = emoji {
            symbolTextField.text = emoji.symbol
            nameTextField.text = emoji.name
            descriptionTextField.text = emoji.description
            usageTextField.text = emoji.usage
        }
        updateSaveButtonState()
    }

    // update data after save button pressed
    
    func updateSaveButtonState() {
        
        let symbolText = symbolTextField.text ?? ""
        let nameText = nameTextField.text ?? ""
        let descriptionText = descriptionTextField.text ?? ""
        let usageText = usageTextField.text ?? ""
      
        
        saveButton.isEnabled = !symbolText.isEmpty && !nameText.isEmpty && !descriptionText.isEmpty && !usageText.isEmpty
        
    }
    
    
    // unwind Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard segue.identifier == "saveUnwind" else { return }
        
        let symbol = symbolTextField.text ?? ""
        let name = nameTextField.text ?? ""
        let description = descriptionTextField.text ?? ""
        let usage = usageTextField.text ?? ""
        emoji = Emoji(symbol: symbol, name: name, description: description, usage: usage)
    }
    
    
    // save data if text is edited
    
    @IBAction func textEditingChanged(_ sender: UITextField) {
        
        updateSaveButtonState()
        
        
    
        
    }
    
    
    
    
}
