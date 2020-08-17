//
//  EmojiMemoryGameView.swift
//  Demo1-Memorize
//
//  Created by Vineet Choudhary on 31/07/20.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    let spacing: CGFloat = 10.0
    let numberOfColumn: Int = 3
    let minColumnWidth: CGFloat = 80.0
    var columns: [GridItem] {
        let gridItem = GridItem(.adaptive(minimum: minColumnWidth), spacing: spacing)
        return Array(repeating: gridItem, count: numberOfColumn)
    }
    
    var body: some View {
        VStack {
            LazyVGrid(columns: columns, spacing: spacing) {
                ForEach(viewModel.cards) { card in
                    CartView(card: card).onTapGesture {
                        viewModel.choose(card)
                    }
                }
            }
            .padding()
            .foregroundColor(.orange)
            
            Button("Reset Game") {
                withAnimation(.easeOut) { 
                    self.viewModel.reset()
                }
            }
            .foregroundColor(.red)
        }
    }
}

struct CartView: View {
    var card: MemoryGame<String>.Card
    
    let lineWidth: CGFloat = 3.0
    let cornerRadius: CGFloat = 10.0
    let fontSizeRatio: CGFloat = 0.80
    let minHeight: CGFloat = 80.0
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                if card.isFaceUp {
                    RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                    RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: lineWidth)
                    Text(card.content)
                        .rotation3DEffect(
                            .init(degrees: card.isFaceUp ? 0 : 180),
                            axis: (x: 0.0, y: 1.0, z: 0.0)
                        )
                        .animation(Animation.linear(duration: 1))
                } else {
                    RoundedRectangle(cornerRadius: cornerRadius).fill(Color.orange)
                }
            }
            .font(.system(size: fontSize(for: geometry.size)))
        }
        .frame(minWidth: .zero, maxWidth: .infinity, minHeight: minHeight)
    }
    
    func fontSize(for size: CGSize)-> CGFloat {
        min(size.width, size.height) * fontSizeRatio
    }
}
