//
//  CardView.swift
//  Memorize
//
//  Created by Сергей Захаров on 09.10.2025.
//

import SwiftUI

struct CardView: View {
    let card: MemoryGame<String>.Card
    
    init(_ card: Card) {
        self.card = card
    }
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: Constants.cornerRadius)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: Constants.lineWidth)
                Pie(endAngle: .degrees(240))
                    .opacity(Constants.Pie.opacity)
                    .overlay(
                        Text(card.content)
                            .font(.system(size: Constants.FontSize.largest))
                            .minimumScaleFactor(Constants.FontSize.scaleFactor)
                            .multilineTextAlignment(.center)
                            .aspectRatio(contentMode: .fit)
                            .padding(Constants.Pie.insert)
                    )
                    .padding(Constants.insert)
            }
            .opacity(card.isFaceUp ? 1:0)
            base.fill()
                .opacity(card.isFaceUp ? 0:1)
        }
        .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
    }
}

private struct Constants {
    static let cornerRadius: CGFloat = 12
    static let lineWidth: CGFloat = 2
    static let insert: CGFloat = 5
    struct FontSize {
        static let largest: CGFloat = 200
        static let smallest: CGFloat = 10
        static let scaleFactor: CGFloat = smallest / largest
    }
    struct Pie {
        static let opacity: CGFloat = 0.5
        static let insert: CGFloat = 5
    }
}

typealias Card = MemoryGame<String>.Card

#Preview {
    VStack {
        HStack {
            CardView(Card(isFaceUp: true, content: "X", id: "test1"))
                .aspectRatio(3/4, contentMode: .fit)
            CardView(Card(content: "X", id: "test1"))
        }
        HStack {
            CardView(Card(isFaceUp: true, isMatched: true, content: "This is a very long string and i hope it fits", id: "test1"))
            CardView(Card(isMatched: true, content: "X", id: "test1"))
        }
    }
    .padding()
        .foregroundColor(.green)
}
