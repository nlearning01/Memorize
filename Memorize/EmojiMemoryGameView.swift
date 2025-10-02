//
//  ContentView.swift
//  Memorize
//
//  Created by Сергей Захаров on 02.10.2025.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    
    @State var currentTheme = Theme(
        name: "Halloween",
        emojis: [],
        color: .orange
    )
    
    @State var gameCards: [String] = []
    
    func generateCards() {
        gameCards = currentTheme.emojis.flatMap { [$0, $0] }.shuffled()
    }
    
    var body: some View {
        VStack {
            Text("Memorize!")
                .font(.largeTitle)
            ScrollView {
                cards
            }
            Spacer()
            HStack {
                Button(action: { selectTheme(.halloween) }) {
                    VStack {
                        Image(systemName: "moon.haze.fill")
                            .font(.title)
                        Text("Halloween")
                            .font(.caption)
                    }
                }
                Spacer()
                Button(action: { selectTheme(.food) }) {
                    VStack {
                        Image(systemName: "frying.pan.fill")
                            .font(.title)
                        Text("Food")
                            .font(.caption)
                    }
                }
                Spacer()
                Button(action: { selectTheme(.animals) }) {
                    VStack {
                        Image(systemName: "pawprint.fill")
                            .font(.title)
                        Text("Animals")
                            .font(.caption)
                    }
                }
            }
            .padding(.horizontal)
        }
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))]) {
            ForEach(gameCards.indices, id: \.self) { index in
                CardView(content: gameCards[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(currentTheme.color)
    }
    
    enum ThemeType {
        case halloween, animals, food
    }
    
    func selectTheme(_ theme: ThemeType) {
        switch theme {
        case .halloween:
            currentTheme = Theme(
                name: "Halloween",
                emojis: ["👻", "🎃", "🕷️", "😈", "💀", "🧙‍♀️"],
                color: .orange
            )
        case .animals:
            currentTheme = Theme(
                name: "Animals",
                emojis: ["🐶", "🐱", "🐻", "🦁", "🐵"],
                color: .yellow
            )
        case .food:
            currentTheme = Theme(
                name: "Food",
                emojis: ["🍎", "🍇", "🍕", "🍟", "🍔", "🍤", "🍩"],
                color: .brown
            )
        }
        generateCards()
    }
}

struct CardView: View {
    let content: String
    @State var isFaceUp = false
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}

struct Theme {
    let name: String
    let emojis: [String]
    let color: Color
}

#Preview {
    EmojiMemoryGameView()
}
