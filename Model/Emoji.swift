//
//  Emoji.swift
//  EmojiDictionary
//
//  Created by Ray Berry on 04/12/2018.
//  Copyright © 2018 JARBerry. All rights reserved.
//

import Foundation

class Emoji: Codable{
    var symbol: String
    var name: String
    var description: String
    var usage: String
    
    static var archiveURL: URL {
    
    let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .allDomainsMask).first!
    
    let result = documentsDirectory.appendingPathComponent("emojis")
    
        return result
    }
    
    init(symbol: String, name: String, description: String, usage: String) {
        self.symbol = symbol
        self.name = name
        self.description = description
        self.usage = usage
    }
    
   
    static func saveToFile(emojis: [Emoji]) {
        
        print("saveToFile Entered \(emojis)")
        let propertyListEncoder = PropertyListEncoder()
        let encodedEmoji = try? propertyListEncoder.encode(emojis)
        
        try? encodedEmoji?.write(to: archiveURL)
        
      

        
    }
    
 static func loadFromFile() -> [Emoji]? {
        let propertyListDecoder = PropertyListDecoder()
        if let retrievedEmojiData = try? Data(contentsOf: archiveURL),
            let decodedEmoji = try?
                propertyListDecoder.decode(Array<Emoji>.self, from:
                    retrievedEmojiData) {
            print(decodedEmoji)

//retrieve data
            return decodedEmoji
        }
    
    
// if no data found return nil 
      return nil
        
    }
    
    static func loadSampleEmojis() -> [Emoji] {
        
        //Load intial array
        
        let emojis: [Emoji] = [
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
        
        
        return emojis
        
        
    }
    
}
