//
//  EmojiMemoryGame.swift
//  Demo1-Memorize
//
//  Created by Vineet Choudhary on 01/08/20.
//

import Foundation

class EmojiMemoryGame: ObservableObject {
    @Published private var model: MemoryGame<String> = EmojiMemoryGame.create()
    
    private static func create()-> MemoryGame<String> {
        let emojis = ["👻", "🎃", "🕷", "🐈", "🐶", "🐞", "🐠", "🐓", "🥚"]
        return MemoryGame<String>(numOfPairsOfCards: emojis.count) { emojis[$0] }
    }
    
    //MARK: - Access to the Model
    var cards: [MemoryGame<String>.Card] {
        return model.cards
    }
    
    //MARK: - Model modifier
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    func reset() {
        model = Self.create()
    }
}
