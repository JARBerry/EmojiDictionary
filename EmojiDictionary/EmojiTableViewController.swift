//
//  EmojiTableViewController.swift
//  EmojiDictionary
//
//  Created by Ray Berry on 04/12/2018.
//  Copyright © 2018 JARBerry. All rights reserved.
//

import UIKit

class EmojiTableViewController: UITableViewController {
    
    var emojis: [Emoji] = [
    Emoji(symbol: "😀", name: "Grinning Face", description: "A typical smiley face", usage: "Happiness"),
    Emoji(symbol: "😕", name: "Confused Face", description: "A confused puzzled face", usage: "Unsure what to think; displeasure"),
    Emoji(symbol: "😍", name: "Heart Eyes", description: "A smiley face with hearts for eyes", usage: "Love of something; attractive"),
    Emoji(symbol: "👮🏻‍♂️", name: "Police Officer", description: "A police officer wearing a blue cap with a gold badge", usage: "Person of authority"),
    Emoji(symbol: "🐢", name: "Turtle", description: "A cute turtle", usage: "Something slow"),
    Emoji(symbol: "🐘", name: "Elephant", description: "A gray elephant", usage: "Good memory"),
    Emoji(symbol: "🍝", name: "Spaghetti", description: "A plate of spaghetti", usage: "Spaghetti"),
    Emoji(symbol: "🎲", name: "Dice", description: "A single dice", usage: "Taking a risk, chance; game"),
    Emoji(symbol: "⛺️", name: "Tent", description: "A small tent", usage: "Camping"),
    Emoji(symbol: "📚",name: "Stack Of Books", description: "Three colored books stacked on each other", usage: "homework, studying"),
    Emoji(symbol: "💔", name: "Broken Heart", description: "A red, broken heart", usage: "Extreme sadness"),
    Emoji(symbol: "💤", name: "Snore", description: "three blue \'z\'s", usage: "Tired,sleepiness"),
    Emoji(symbol: "🏁", name: "Checkered Flag", description: "A black-and-white checkered flag", usage: "Completion"),
    Emoji(symbol: "🤡", name: "Clown", description: "A smiley clown face", usage: "scare the kids"),
    Emoji(symbol: "🐶", name: "Dog", description: "A lovely little dog", usage: "walking"),
    Emoji(symbol: "🐰", name: "Rabbit", description: "A fluffy rabbit", usage: "cuddling")
        
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
              return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return emojis.count
        } else {
            return 0
        }
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Step 1: Dequeue cell

        let cell = tableView.dequeueReusableCell(withIdentifier: "EmojiCell", for : indexPath) as! EmojiTableViewCell

        //Step 2: Fetch model object to display
        let emoji = emojis[indexPath.row]
        
        //Step 3: Configure cell
        cell.update(with: emoji)
        cell.showsReorderControl = true
        
        
        //Step 4 : Return cell
        return cell
    }

    
   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let emoji = emojis[indexPath.row]
        print("\(emoji.symbol) \(indexPath) \(emoji.description)")
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let movedEmoji = emojis.remove(at: fromIndexPath.row)
        emojis.insert(movedEmoji, at: to.row)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    @IBAction func editButtonTapped(_ sender: UIBarButtonItem) {
        
        let tableViewEditingMode = tableView.isEditing
        
        tableView.setEditing(!tableViewEditingMode, animated: true)
    }
   

}
