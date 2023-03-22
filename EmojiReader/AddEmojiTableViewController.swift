//
//  AddEmojiTableViewController.swift
//  EmojiReader
//
//  Created by Николай Якименко on 21.03.2023.
//

import UIKit

class AddEmojiTableViewController: UITableViewController {
    
    var emojiEddit = Emoji(name: "", destription: "", emoji: "", isFavorite: false)
    
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emojiTextField: UITextField!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
        updateSaveButton()
    }
    
    private func updateSaveButton() {
        let emojiText = emojiTextField.text ?? ""
        let nameText = nameTextField.text ?? ""
        let descriptionText = descriptionTextField.text ?? ""
        
        saveButton.isEnabled = !emojiText.isEmpty && !nameText.isEmpty && !descriptionText.isEmpty
    }
    
    private func updateUI() {
        emojiTextField.text = emojiEddit.emoji
        nameTextField.text = emojiEddit.name
        descriptionTextField.text = emojiEddit.destription
    }
    
    @IBAction func textChanged(_ sender: UITextField) {
        updateSaveButton()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard segue.identifier == "saveSegue" else {return}
        
        let emoji = emojiTextField.text ?? ""
        let name = nameTextField.text ?? ""
        let description = descriptionTextField.text ?? ""
        self.emojiEddit = Emoji(name: name, destription: description, emoji: emoji, isFavorite: self.emojiEddit.isFavorite)
        
    }
    
    
}
