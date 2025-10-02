//
//  MemoryGame.swift
//  Memorize
//
//  Created by Сергей Захаров on 02.10.2025.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    
    private(set) var cards: Array<Card>
    
    private(set) var score = 0
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        
        for pairIndex in 0..<max(2, numberOfPairsOfCards) {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: "`\(pairIndex + 1)a"))
            cards.append(Card(content: content, id: "`\(pairIndex + 1)b"))
        }
    }
    
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter { index in cards[index].isFaceUp }.only }
        set { cards.indices.forEach { cards[$0].isFaceUp = (newValue == $0) }}
    }
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }) {
            if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched {
                let bonusScore = 2
                
                if let potentialMatchedIndex = indexOfTheOneAndOnlyFaceUpCard {
                    if cards[chosenIndex].content == cards[potentialMatchedIndex].content {
                        cards[chosenIndex].isMatched = true
                        cards[potentialMatchedIndex].isMatched = true
                        score += bonusScore
                    } else {
                        if cards[chosenIndex].hasBeenSeen || cards[potentialMatchedIndex].hasBeenSeen {
                            score -= 1
                        }
                        cards[chosenIndex].hasBeenSeen = true
                        cards[potentialMatchedIndex].hasBeenSeen = true
                    }
                } else {
                    indexOfTheOneAndOnlyFaceUpCard = chosenIndex
                }
                cards[chosenIndex].isFaceUp = true
            }
        }
    }
    
    mutating func shuffle() {
        cards.shuffle()
        print(cards)
        score = 0
        for index in cards.indices {
            cards[index].hasBeenSeen = false
        }
    }
    
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
        var isFaceUp = false
        var isMatched = false
        let content: CardContent
        
        var id: String
        var hasBeenSeen = false
        
        var debugDescription: String {
            "`\(id): `\(content) `\(isFaceUp ? "up" : "down") `\(isMatched ? "matched" : "") `\(hasBeenSeen ? "seen" : "")"
        }
    }
}

extension Array {
    var only: Element? {
        return count == 1 ? first : nil
    }
}
