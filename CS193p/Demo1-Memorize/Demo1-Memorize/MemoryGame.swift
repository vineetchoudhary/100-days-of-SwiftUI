//
//  MemoryGame.swift
//  Demo1-Memorize
//
//  Created by Vineet Choudhary on 01/08/20.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    var cards: [Card]
    var indexOfFaceUpCard: Int?
    
    init(numOfPairsOfCards: Int, cardContentFactory: (Int)-> CardContent) {
        cards = [Card]()
        for index in 0..<numOfPairsOfCards {
            let content = cardContentFactory(index)
            cards.append(Card(id: (index * 2), content: content))
            cards.append(Card(id: (index * 2) + 1, content: content))
        }
        cards.shuffle()
    }
    
    mutating func choose(_ card: Card) {
        print("Card Chosen: \(card)")
        
        //return if card not exists or already matched
        guard let choosenIndex = cards.firstIndex(where: { $0.id == card.id }), !cards[choosenIndex].isMatched else {
            return;
        }
        
        //flip up card face if selected card is first of it kind faceup card
        guard let indexOfFaceUpCard = indexOfFaceUpCard else {
            self.indexOfFaceUpCard = choosenIndex
            cards[choosenIndex].isFaceUp = true
            return;
        }
        
        //if last face up card content match match with current card then faceup card
        //add both card index into matched indexs
        if cards[indexOfFaceUpCard].content == cards[choosenIndex].content {
            cards[choosenIndex].isFaceUp = true
            cards[choosenIndex].isMatched = true
            cards[indexOfFaceUpCard].isMatched = true
        } else {
            cards[indexOfFaceUpCard].isFaceUp = false
        }
        
        self.indexOfFaceUpCard = nil
    }
    
    struct Card: Identifiable {
        var id: Int
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
    }
}
