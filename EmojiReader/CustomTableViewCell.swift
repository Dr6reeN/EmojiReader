//
//  CustomTableViewCell.swift
//  EmojiReader
//
//  Created by Николай Якименко on 20.03.2023.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var emojiLable: UILabel!
    @IBOutlet weak var descriptionLable: UILabel!
    @IBOutlet weak var nameLable: UILabel!
    
    
    var setCell: Emoji? {
        didSet{
            emojiLable.text = setCell?.emoji
            descriptionLable.text = setCell?.destription
            nameLable.text = setCell?.name
        }
    }


}
