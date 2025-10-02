//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Сергей Захаров on 02.10.2025.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    
    private static let themes: [Theme] = [
        Theme(
            name: "Halloween",
            emojis: ["👻", "🎃", "🕷️", "😈", "💀", "🧙‍♀️", "🙀", "👹", "😱", "☠️", "🍭"],
            numberOfPairs: 6,
            color: "orange"
        ),
        Theme(
            name: "Animals",
            emojis: ["🪿", "🦇", "🐺", "🐢", "🦉", "🐗", "🐡", "🦧", "🦈", "🐊", "🦍"],
            numberOfPairs: 6,
            color: "brown"
        ),
        Theme(
            name: "Weather",
            emojis: ["🌪️", "☀️", "🌤️", "☁️", "🌦️", "🌩️", "❄️", "🌬️", "🌈", "💨", "💧"],
            numberOfPairs: 6,
            color: "blue"
        ),
        Theme(
            name: "Food",
            emojis: ["🍇", "🥨", "🥓", "🍔", "🌶️", "🌯", "🍕", "🍣", "🥙", "🍤", "🍢", "🍪"],
            numberOfPairs: 6,
            color: "yellow"
        ),
        Theme(
            name: "Vehicles",
            emojis: ["🚗", "🚕", "🚎", "🏎️", "🏍️", "🛴", "🛵", "🛩️", "🛸", "⛵️"],
            numberOfPairs: 6,
            color: "gray"
        ),
        Theme(
            name: "Flags",
            emojis: ["🏴‍☠️", "🇦🇺", "🇧🇾", "🇧🇷", "🇨🇱", "🇧🇪", "🇮🇹", "🇰🇷", "🇷🇺"],
            numberOfPairs: 6,
            color: "red"
        )
    ]
    
    private static func createMemoryGame(theme: Theme, numberOfPairs: Int) -> MemoryGame<String> {
        let maxAvailablePairs = theme.emojis.count / 2
        let adjustedPairs = min(numberOfPairs, maxAvailablePairs)
        let selectedEmojis = theme.emojis.shuffled().prefix(adjustedPairs)
        return MemoryGame(numberOfPairsOfCards: adjustedPairs) { pairIndex in
            selectedEmojis[pairIndex]
        }
    }
    
    @Published private var model: MemoryGame<String>
    @Published var theme: Theme
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    var score: Int {
        return model.score
    }
    
    var themeColor: Color {
        switch theme.color {
        case "orange": return .orange
        case "brown": return .brown
        case "blue": return .blue
        case "yellow": return .yellow
        case "gray": return .gray
        case "red": return .red
        default: return .white
        }
    }
    
    init() {
        let initialTheme = EmojiMemoryGame.themes.randomElement()!
        self.theme = initialTheme
        let maxPairs = initialTheme.emojis.count / 2
        let randomPairs = Int.random(in: 6...max(maxPairs, 6))
        self.model = EmojiMemoryGame.createMemoryGame(theme: initialTheme, numberOfPairs: randomPairs)
        model.shuffle()
    }
    
    func shuffle() {
        model.shuffle()
    }
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    func newGame() {
        theme = EmojiMemoryGame.themes.randomElement()!
        let maxPairs = theme.emojis.count / 2
        let randomPairs = Int.random(in: 6...max(maxPairs, 6))
        model = EmojiMemoryGame.createMemoryGame(theme: theme, numberOfPairs: randomPairs)
        model.shuffle()
    }
}
