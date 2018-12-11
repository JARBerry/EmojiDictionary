//
//  EmojiTableViewController.swift
//  EmojiDictionary
//
//  Created by Ray Berry on 04/12/2018.
//  Copyright © 2018 JARBerry. All rights reserved.
//

import UIKit



class EmojiTableViewController: UITableViewController {
    
  var emojis: [Emoji] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem
        
        // prevents decsription from being truncated
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44.0
        
       
       //checks if data already saved and loads sample data plus saved data
        if let savedData = Emoji.loadFromFile() {
             emojis.append(contentsOf: Emoji.loadSampleEmojis())
            emojis.append(contentsOf: savedData)
       // otherwise loads only Sample data only
        } else {
            emojis.append(contentsOf: Emoji.loadSampleEmojis())
        }
    }

    // MARK: - Table view data source
    
    
    // returns only 1 section
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
    
    
    // custom cell
    
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

  
    // puts emoji data into tableview cell
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let movedEmoji = emojis.remove(at: fromIndexPath.row)
        emojis.insert(movedEmoji, at: to.row)
        
        Emoji.saveToFile(emojis: emojis)
        
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    
    // deletes emojodata or savestofile
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            emojis.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            Emoji.saveToFile(emojis: emojis)
            
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        

        if segue.identifier == "EditEmoji"{
        let indexPath = tableView.indexPathForSelectedRow!
            let emoji = emojis[indexPath.row]
    
// Need to downcast AddEditEmojiTableViewController from Navigation controller
            
            let navViewController = segue.destination as! UINavigationController
            
            let addEditTableViewController = navViewController.topViewController as! AddEditEmojiTableViewController
//            let addEditTableViewContoller = segue.destination
//            as! AddEditEmojiTableViewController
            addEditTableViewController.emoji = emoji
        }
    }
    
    @IBAction func unwindToEmojiTableView(segue:UIStoryboardSegue)
    {
        guard segue.identifier == "saveUnwind" else { return }
        let sourceViewController = segue.source as! AddEditEmojiTableViewController
        
        if let emoji = sourceViewController.emoji {
            
            // update original emojis
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                emojis[selectedIndexPath.row] = emoji
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            } else {
                
            // add new emojis
                
                let newIndexPath = IndexPath(row: emojis.count, section: 0)
                emojis.append(emoji)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
            
            // Save to file
            
            Emoji.saveToFile(emojis: emojis)
            
            
        }
        
        
    }
    
    @IBAction func editButtonTapped(_ sender: UIBarButtonItem) {
        
        let tableViewEditingMode = tableView.isEditing
        
        tableView.setEditing(!tableViewEditingMode, animated: true)
    }
   

}
