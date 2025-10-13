//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Сергей Захаров on 02.10.2025.
//

import SwiftUI

@main
struct MemorizeApp: App {
    
    @StateObject var themeChooser = ThemeChooser()
    var body: some Scene {
        WindowGroup {
            ThemeChooserView(themeChooser: themeChooser)
        }
    }
}
