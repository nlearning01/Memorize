//
//  Extensions.swift
//  Memorize
//
//  Created by Сергей Захаров on 13.10.2025.
//

import Foundation

extension Character {
    
    var isEmoji: Bool {
        if let firstScalar = unicodeScalars.first, firstScalar.properties.isEmoji {
            return (firstScalar.value >= 0x238d || unicodeScalars.count > 1)
        } else {
            return false
        }
    }
}

extension String {
    var uniqued: String {
        reduce(into: "") { sofar, element in
            if !sofar.contains(element) {
                sofar.append(element)
            }
        }
    }
    
    func shuffled() -> String {
        var characters = Array(self)
        
        for i in stride(from: characters.count - 1, to: 0, by: -1) {
            let j = Int.random(in: 0...i)
            characters.swapAt(i, j)
        }
        
        return String(characters)
    }
    
    mutating func remove(_ ch: Character) {
        removeAll(where: { $0 == ch })
    }
}
