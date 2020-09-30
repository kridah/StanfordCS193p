//
//  Cardify.swift
//  StanfordCS193p
//
//  Created by Kristoffer Dahl on 23/07/2020.
//  Copyright © 2020 Kristoffer Dahl. All rights reserved.
//

import SwiftUI

struct Cardify: AnimatableModifier {
    var rotation: Double      // rotasjon i degrees
    
    init(isFaceUp: Bool) {
        rotation = isFaceUp ? 0 : 180
    }
    
    var isFaceUp: Bool {
        rotation < 90
    }
    
    var animatableData: Double {
        get { return rotation }
        set { rotation = newValue }
    }

    func body(content: Content) -> some View {
        ZStack {
            //if isFaceUp {
                Group {
                    RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                    RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
                    content
                }
                    .opacity(isFaceUp ? 1 : 0)
                RoundedRectangle(cornerRadius: cornerRadius).fill()
                    .opacity(isFaceUp ? 0 : 1)
           // }
        }
        .rotation3DEffect(Angle.degrees(rotation), axis: (0,1,0)) 
    }
    
    private let cornerRadius: CGFloat = 10.0
    private let edgeLineWidth: CGFloat = 3
}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}
