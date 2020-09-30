//
//  EmojiMemoryGame.swift
//  StanfordCS193p
//
//  Created by Kristoffer Dahl on 21/07/2020.
//  Copyright © 2020 Kristoffer Dahl. All rights reserved.
//

import Foundation

// ViewModel-klasse

class EmojiMemoryGame: ObservableObject {
    // @Published sørger for at objectWillChange.send() blir sendt, og at man ikke trenger å kalle funksjonen manuelt
    @Published private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    //   var objectWillChange: ObservableObjectPublisher <-- var fra ObservableObject.
    
    private static func createMemoryGame() -> MemoryGame<String> {
        let halloweenEmoji: Array<String> = ["👻", "🎃", "🕷", "💀"]
        let animalEmoji: Array<String> = ["🐶", "🐱", "🦁", "🐷", "🐵", "🐥", "🐄", "🐑", "🐲"]
        let emojiArray: Array<Array<String>> = [halloweenEmoji, animalEmoji]
        return   MemoryGame<String>(numberOfPairsOfCards: emojiArray[0].count) { pairIndex in return emojiArray[0][pairIndex] }    // closure (funksjon i metodekallet)
    }
     
    
    // MARK: Access to the model
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    // MARK: Intent(s)
    
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
    
    func resetGame() {
        model = EmojiMemoryGame.createMemoryGame()
    }
    
   
}
