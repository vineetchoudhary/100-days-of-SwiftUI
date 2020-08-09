//
//  Demo1_MemorizeApp.swift
//  Demo1-Memorize
//
//  Created by Vineet Choudhary on 31/07/20.
//

import SwiftUI

@main
struct Demo1_MemorizeApp: App {
    let emojiGame = EmojiMemoryGame()
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: emojiGame)
        }
    }
}
