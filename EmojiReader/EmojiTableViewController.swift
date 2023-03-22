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
        Emoji(name: "TEXT", destription: "Some Text1", emoji: "😀", isFavorite: false),
        Emoji(name: "TEXT", destription: "Some Text2", emoji: "😠", isFavorite: false),
        Emoji(name: "TEXT", destription: "Some Text3", emoji: "🫵", isFavorite: false),
        Emoji(name: "TEXT", destription: "Some Text4", emoji: "👀", isFavorite: false)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Emoji Reader"
        navigationItem.leftBarButtonItem = self.editButtonItem
    }
    
    @IBAction func unwindSegue(segue: UIStoryboardSegue) {
        guard segue.identifier == "saveSegue" else {return}
        guard let sourceVC = segue.source as? AddEmojiTableViewController else {return}
        let emoji = sourceVC.emojiEddit
        
        if let selectedIndexPath = tableView.indexPathForSelectedRow{
            itemArray[selectedIndexPath.row] = emoji
            tableView.reloadRows(at: [selectedIndexPath], with: .fade)
        }else{
            let newIndexPath = IndexPath(row: itemArray.count, section: 0)
            itemArray.append(emoji)
            tableView.insertRows(at: [newIndexPath], with: .fade)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard segue.identifier == "edditEmoji" else {return}
        guard let indexPath = tableView.indexPathForSelectedRow else {return}
        let emoji = itemArray[indexPath.row]
        
        let navigationVC = segue.destination as? UINavigationController
        let newEmojiVC = navigationVC?.topViewController as? AddEmojiTableViewController
        newEmojiVC?.emojiEddit = emoji
        newEmojiVC?.title = "Edit"
    }
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifiuerCell, for: indexPath) as? CustomTableViewCell else {return UITableViewCell()}
        
        cell.setCell = itemArray[indexPath.row]
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
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let actionDone = doneAction(at: indexPath)
        let actionFavorite = favorioteAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [actionDone, actionFavorite])
    }
    
    func doneAction(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "Done") {(action, view, completion) in
            self.itemArray.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            completion(true)
        }
        
        action.backgroundColor = .systemGreen
        action.image = UIImage(systemName: "checkmark.circle")
        
        return action
    }
    
    func favorioteAction(at indexPath: IndexPath) -> UIContextualAction {
        var item = itemArray[indexPath.row]
        let action = UIContextualAction(style: .normal, title: "Favorite") { (action, view, completion) in
            item.isFavorite = !item.isFavorite
            self.itemArray[indexPath.row] = item
            completion(true)
        }
        action.backgroundColor = item.isFavorite ? .systemPurple : .systemGray
        action.image = UIImage(systemName: "heart")
        return action
    }
}
