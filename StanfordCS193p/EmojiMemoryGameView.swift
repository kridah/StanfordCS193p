//
//  ContentView.swift
//  StanfordCS193p
//
//  Created by Kristoffer Dahl on 11/07/2020.
//  Copyright © 2020 Kristoffer Dahl. All rights reserved.
//

import SwiftUI

// View-klasse
// Denne klassen beskriver skjermen, altså Swift UI

struct EmojiMemoryGameView: View {
    
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack {
            Grid(viewModel.cards) { card in  // Grid finnes ikke som egen type, så vi må definere den selv
                CardView(card: card).onTapGesture {
                    withAnimation(.linear(duration: 0.75)) {
                        self.viewModel.choose(card: card)
                    }
                }
                .padding(5)
            }
            .padding()
            .foregroundColor(Color.red)
            HStack{
                Button(action: {
                    withAnimation(.easeInOut) {
                        self.viewModel.resetGame()
                    }
                }, label: { Text("New Game") })
//                Button(action: {
//                      withAnimation(.easeInOut) {
//                          self.viewModel.selectEmoji(chosen: 1)()
//                      }
//                  }, label: { Text("Choose emoji") })
     
               
            }
            
        }
        
    }
}


struct CardView: View {
    var card: MemoryGame<String>.Card
    
    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    
    @State private var animatedBonusRemaining: Double = 0
    
    private func startBonusTimeAnimation() {
        animatedBonusRemaining = card.bonusRemaining
        withAnimation(.linear(duration: card.bonusTimeRemaining)) {
            animatedBonusRemaining = 0
        }
    }

    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
            ZStack {
                Group {
                    if card.isConsumingBonusTime {
                        Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.radians(-animatedBonusRemaining*360-90), clockwise: true)
                            .onAppear() {
                                self.startBonusTimeAnimation()
                        }
                    } else {
                        Pie(startAngle: Angle.degrees(0 - 90), endAngle: Angle.radians(-card.bonusRemaining * 360 - 90), clockwise: true)
                    }
                }
                .padding(5)
                .opacity(0.4)
            Text(card.content)     // emoji
                .font(Font.system(size: fontSize(for: size)))
                .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                .animation(card.isMatched ? Animation.linear(duration: 1).repeatForever(autoreverses: false): .default)
        }
            .cardify(isFaceUp: card.isFaceUp)
            .transition(AnyTransition.scale)
    }
}
    
    // MARK: - Drawing Constants - // for å endre var (magic numbers)
    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.7
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(card: game.cards[0])
        return EmojiMemoryGameView(viewModel: game)
    }
}
