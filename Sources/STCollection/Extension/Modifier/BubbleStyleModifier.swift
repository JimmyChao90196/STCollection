//
//  BubbleStyleModifier.swift
//  SmartTrials
//
//  Created by JimmyChao on 2024/7/26.
//

import Foundation
import SwiftUI

// Bubble Modifier
struct STBubbleModifier: ViewModifier {
    
    let bubbleColor: Color
    let radius: CGFloat
    
    init(bubbleColor: Color, radius: CGFloat = 12.0) {
        self.bubbleColor = bubbleColor
        self.radius = radius
    }
    
    func body(content: Content) -> some View {
        content
            .background(bubbleColor)
            .clipShape(.rect(cornerRadius: radius))
            //.shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 1.5)
            .multilineTextAlignment(.center)
    }
}

// RoundBubble Modifier
struct STRoundBubbleModifier: ViewModifier {
    
    let bubbleColor: Color
    let radius: CGFloat
    
    init(bubbleColor: Color, radius: CGFloat = 12.0) {
        self.bubbleColor = bubbleColor
        self.radius = radius
    }
    
    func body(content: Content) -> some View {
        content
            .background(bubbleColor)
            .clipShape(.circle)
            //.shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 1.5)
            .multilineTextAlignment(.center)
    }
}

public extension View {
    
    func bubbleStyle(_ bubbleColor: Color, _ radius: CGFloat = 12.0) -> some View {
        modifier(STBubbleModifier(bubbleColor: bubbleColor, radius: radius))
    }
    
    func roundBubbleStyle(_ bubbleColor: Color, _ radius: CGFloat = 12.0) -> some View {
        modifier(STRoundBubbleModifier(bubbleColor: bubbleColor, radius: radius))
    }
}
