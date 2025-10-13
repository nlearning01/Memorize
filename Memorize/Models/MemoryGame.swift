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
    private var checkOAOCardSelected = false
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        for pairIndex in 0..<max(2, numberOfPairsOfCards) {
            let content: CardContent = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: "\(pairIndex + 1)a"))
            cards.append(Card(content: content, id: "\(pairIndex + 1)b"))
        }
    }
    
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { return cards.indices.filter { index in cards[index].isFaceUp }.only }
        set { cards.indices.forEach { cards[$0].isFaceUp = (newValue == $0) }}
    }
    
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id}) {
            if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched {
                if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                    if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                        cards[chosenIndex].isMatched = true
                        cards[potentialMatchIndex].isMatched = true
                        score += 2
                        checkOAOCardSelected = false
                    }
                    else {
                        deductScore(chosenIndex, potentialMatchIndex)
                        checkOAOCardSelected = false
                    }
                } else {
                    indexOfTheOneAndOnlyFaceUpCard = chosenIndex
                    if cards[chosenIndex].isSelected {
                        checkOAOCardSelected = true
                    }
                }
                
                cards[chosenIndex].isFaceUp = true
                
            }
            cards[chosenIndex].isSelected = true
        }
    }
    
    mutating private func deductScore(_ chosenIndex: Int, _ potentialMatchIndex: Int) {
        if cards[chosenIndex].isSelected{
            score -= 1
        }
        if cards[potentialMatchIndex].isSelected && checkOAOCardSelected {
            score -= 1
        }
    }
    
    mutating func shuffle() {
        cards.shuffle()
    }
    
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
        var isFaceUp = false
        var isMatched = false
        var isSelected = false
        let content: CardContent
        
        var id: String
        var debugDescription: String {
            "\(id): \(content) \(isFaceUp ? "up" : "down")\(isMatched ? " matched": "")"
        }
    }
}

extension Array {
    var only: Element? {
        return count == 1 ? first : nil
    }
}
