//
//  ThemeStore.swift
//  Memorize
//
//  Created by Сергей Захаров on 13.10.2025.
//

import Foundation
import SwiftUI

struct ThemeStore {
    
    static let nPairs = 12
    
    static var builtins:[Theme] {[
        Theme(name: "Halloween", emojis:"👻🎃🕷️😈💀🕸️🧙🙀👹😱☠️🍭".shuffled(),
              nPairs: nPairs, color: RGBA(color: .orange)),
        Theme(name: "Vehicle", emojis:"🚗🚖⛴️🚁🚚🚂🚀🚌🚑🚔🚜🚄".shuffled(),
              nPairs: nPairs, color: RGBA(color: .blue)),
        Theme(name: "Drink", emojis:"🥂🍵🥛🧋🍻🍾🧃🫖🍶🥃🥤🍹".shuffled(),
              nPairs: nPairs, color: RGBA(color: .pink)),
        Theme(name: "Food", emojis:"🍔🌽🌯🌭🌮🍕🍗🍟🥐🍛🍱🍲".shuffled(),
              nPairs: nPairs, color: RGBA(color: .yellow)),
        Theme(name: "Wearing", emojis:"🥼👠👙👗👢🧥👖🥾🧣👔👚🩳".shuffled(),
              nPairs: nPairs, color: RGBA(color: .green)),
        Theme(name: "Sports", emojis:"🚲🏀🏸⛹️‍♀️🎾🏓🏑⚾️🏈🏊‍♀️🏄🏿‍♀️🚵".shuffled(),
              nPairs: nPairs, color: RGBA(color: .red))
    ]}
    
    
    struct Theme: Identifiable, Hashable, Codable {
        
        var name: String
        var emojis: String
        var nPairs: Int
        var color: RGBA
        var id = UUID()
        
    }
}
