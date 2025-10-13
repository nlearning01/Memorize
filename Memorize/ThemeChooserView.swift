//
//  ThemeChooserView.swift
//  Memorize
//
//  Created by Сергей Захаров on 13.10.2025.
//

import SwiftUI

struct ThemeChooserView: View {
    
    typealias Theme = ThemeStore.Theme
    @ObservedObject var themeChooser: ThemeChooser
    @State private var showCursorTheme = false
    @State private var selectedTheme: Theme?
    
    var body: some View {
        
        NavigationStack {
            List {
                ForEach(themeChooser.themes) { theme in
                    NavigationLink(destination: EmojiMemoryGameView(viewModel: EmojiMemoryGame(themeID: theme.id, themeChooser: themeChooser), themeID: theme.id)){
                        
                        themeView(theme)
                    }
                    .swipeActions(edge: .leading) {
                        Button {
                            selectedTheme = theme
                            
                        } label: {
                            Image(systemName: "square.and.pencil")
                        }
                        .tint(.blue)
                    }
                }
                .onDelete{ indexSet in
                    withAnimation {
                        themeChooser.themes.remove(atOffsets: indexSet)
                        themeChooser.printThemes()
                        
                    }
                }
                .deleteDisabled(themeChooser.themes.count <= 1)
            }
            .sheet(item: $selectedTheme, content: { item in
                if let index = themeChooser.themes.firstIndex(where: { $0.id == item.id }){
                    ThemeEditor(theme: $themeChooser.themes[index])
                }
            })
            
            .navigationDestination(isPresented: $showCursorTheme) {
                ThemeEditor(theme: $themeChooser.themes.last!)
            }
            .navigationTitle("Themes")
            .toolbar {
                Button {
                    themeChooser.append()
                    showCursorTheme = true
                    
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        
    }
    
    func themeView(_ theme: Theme) -> some View {
        let allPair = theme.emojis.count == theme.nPairs
        return VStack(alignment: .leading){
            Text(theme.name)
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .foregroundColor(Color(rgba: theme.color))
            Text(allPair ? "\(theme.emojis)" : "\(theme.nPairs) \(theme.emojis)")
        }
    }
}

#Preview {
    ThemeChooserView(themeChooser: ThemeChooser())
}
