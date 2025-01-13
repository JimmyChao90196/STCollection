//
//  STButton.swift
//  STCollection
//
//  Created by JimmyChao on 2024/10/24.
//

import SwiftUI
import Foundation

public struct STButtonStyle: ButtonStyle {
    
    //@Environment(\.isEnabled) private var isEnabled: Bool
    
    var isDisalbe: Bool
    let vPadding: CGFloat
    let cornerRadius: CGFloat
    let foregroundColor: Color
    let backgroundColor: Color
    let strokeColor: Color
    let font: Font
    let lineLimit: Int
    let dynamicSizeLock: PartialRangeThrough<DynamicTypeSize>
    
    public init(
        isDisable: Bool = false,
        vPadding: CGFloat = 15,
        cornerRadius: CGFloat = 7,
        foregroundColor: Color = .red,
        bgColor: Color = .white,
        strokeColor: Color = .black.opacity(0.25),
        font: Font = .title3,
        lineLimit: Int = 1,
        dynamicSize: PartialRangeThrough<DynamicTypeSize> = ...DynamicTypeSize.xxxLarge
    ) {
        self.isDisalbe = isDisable
        self.vPadding = vPadding
        self.cornerRadius = cornerRadius
        self.foregroundColor = foregroundColor
        self.backgroundColor = bgColor
        self.strokeColor = strokeColor
        self.font = font
        self.lineLimit = lineLimit
        self.dynamicSizeLock = dynamicSize
    }
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
        
            .customDynamicSize(font: font, dynamicSizeLock)
            .lineLimit(lineLimit)
            .minimumScaleFactor(0.5)
            .fontWeight(.bold)
            .padding(.vertical, vPadding)
            .padding(.horizontal, 5)
            .frame(maxWidth: .infinity)
            .bubbleStyle(!isDisalbe ? backgroundColor: Color(hex: "#D9D9D9"), cornerRadius)
            .foregroundStyle(!isDisalbe ? foregroundColor: Color(hex: "#494949"))
            .shadow(color: .black.opacity(0.35), radius: 2, x: 0, y: 4)
            .overlay {
                RoundedRectangle(cornerRadius: cornerRadius).stroke(strokeColor, lineWidth: 1.25)
            }
            .padding(.horizontal, 1.25)
            .allowsHitTesting(!isDisalbe)
            .opacity(configuration.isPressed ? 0.25: 1)
    }
}

