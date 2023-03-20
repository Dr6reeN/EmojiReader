//
//  EmojiTableViewController.swift
//  EmojiReader
//
//  Created by Николай Якименко on 20.03.2023.
//

import UIKit

class EmojiTableViewController: UITableViewController {
    
    let identifiuerCell = "emojiCell"
    var itemArray = [
        Emoji(name: "Smile", destription: "u are pidor", emoji: "😀", isFavorite: false),
        Emoji(name: "Gay", destription: "u are gay", emoji: "😠", isFavorite: false),
        Emoji(name: "Dog", destription: "u are dog ", emoji: "🫵", isFavorite: false)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Emoji Reader"
        navigationItem.leftBarButtonItem = self.editButtonItem
         
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifiuerCell, for: indexPath) as? CustomTableViewCell else {return UITableViewCell()}
        
        cell.setEmoji = itemArray[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            itemArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedCell = itemArray.remove(at: sourceIndexPath.row)
        itemArray.insert(movedCell, at: destinationIndexPath.row)
        tableView.reloadData()
    }
    
}
