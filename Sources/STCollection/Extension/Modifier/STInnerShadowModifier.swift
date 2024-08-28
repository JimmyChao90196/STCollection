//
//  InnerShadowModifier.swift
//  SmartTrials
//
//  Created by JimmyChao on 2024/7/31.
//

import Foundation
import SwiftUI

struct STInnerShadowModifier: ViewModifier {
    @State var backgroundColor: Color
    @State var radius: CGFloat = 10
    
    func body(content: Content) -> some View {
        content
            .background(
                RoundedRectangle(cornerRadius: radius)
                    .fill(backgroundColor.shadow(.inner(
                        color: .gray.opacity(0.5),
                        radius: 1,
                        x: 0, y: 2.5)))
            )
    }
}

public extension View {
    func innerShadow(_ backgroundColor: Color, _ radius: CGFloat = 10) -> some View {
        modifier(STInnerShadowModifier(backgroundColor: backgroundColor, radius: radius))
    }
}

