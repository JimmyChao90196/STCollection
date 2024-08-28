//
//  STButtonModifier.swift
//  SmartTrials
//
//  Created by JimmyChao on 2024/8/1.
//

import Foundation
import SwiftUI

public struct STButtonModifier: ViewModifier {
    
    var validate: Bool
    let vPadding: CGFloat
    let cornerRadius: CGFloat
    let foregroundColor: Color
    let backgroundColor: Color
    let strokeColor: Color
    let font: Font
    let lineLimit: Int
    let dynamicSizeLock: PartialRangeThrough<DynamicTypeSize>
    
    public func body(content: Content) -> some View {
        content
            .customDynamicSize(font: font, dynamicSizeLock)
            .lineLimit(lineLimit)
            .minimumScaleFactor(0.5)
            .fontWeight(.bold)
            .padding(.vertical, vPadding)
            .padding(.horizontal, 5)
            .frame(maxWidth: .infinity)
            .bubbleStyle(backgroundColor, cornerRadius)
            .foregroundStyle(validate ? foregroundColor: .gray.opacity(0.5))
            .shadow(color: .black.opacity(0.35), radius: 2, x: 0, y: 4)
            .overlay {
                RoundedRectangle(cornerRadius: cornerRadius).stroke(strokeColor, lineWidth: 1.25)
            }
            .padding(.horizontal, 1.25)
            .onTapGesture {}
            .disabled(validate)
            
        
    }
}

public extension View {
    func STButton(
        validation: Bool,
        vPadding: CGFloat = 15,
        cornerRadius: CGFloat = 7,
        foregroundColor: Color = .red,
        bgColor: Color = .white,
        strokeColor: Color = .black.opacity(0.25),
        font: Font = .title3,
        lineLimit: Int = 1,
        dynamicSize: PartialRangeThrough<DynamicTypeSize> = ...DynamicTypeSize.xxxLarge
    ) -> some View {
        modifier(STButtonModifier(
            validate: validation,
            vPadding: vPadding,
            cornerRadius: cornerRadius,
            foregroundColor: foregroundColor,
            backgroundColor: bgColor, 
            strokeColor: strokeColor,
            font: font,
            lineLimit: lineLimit,
            dynamicSizeLock: dynamicSize
        ))
    }
}
