//
//  STTitle.swift
//  SmartTrials
//
//  Created by JimmyChao on 2024/8/1.
//

import SwiftUI
import Foundation

struct STTitleModifier: ViewModifier {
    
    let font: Font
    let fontWeight: Font.Weight
    let color: Color
    let icon: Image?
    let iconSize: CGFloat
    let shouldHaveInitalFrame: Bool
    var dynamicSizeLock: PartialRangeThrough<DynamicTypeSize>
    
    func body(content: Content) -> some View {
        
        HStack(alignment: .bottom, spacing: 0) {
            
            if icon != nil {
                icon!
                    .resizable()
                    .scaledToFit()
                    .frame(width: iconSize, height: iconSize)
                    .padding(.trailing, 5)
            }
            
            content
        }
        .customDynamicSize(font: font, dynamicSizeLock)
        .fontWeight(fontWeight)
        .foregroundStyle(color)
        .padding(.bottom, 3)
        .zIndex(1)
        .if(shouldHaveInitalFrame) { view in
            view.frame(maxWidth: .infinity, alignment: .leading)
        } else: { view in
            view
        }
    }
}

public extension View {
    func titleConfig(
        font: Font = .headline,
        fontWeight: Font.Weight = .bold,
        textColor: Color = .ST_1B0851,
        icon: Image? = nil,
        iconSize: CGFloat = 25,
        initalFrame: Bool = true,
        dynamicSizeLock: PartialRangeThrough<DynamicTypeSize> = ...DynamicTypeSize.accessibility1
    ) -> some View {
        modifier(STTitleModifier(
            font: font,
            fontWeight: fontWeight,
            color: textColor,
            icon: icon,
            iconSize: iconSize,
            shouldHaveInitalFrame: initalFrame, dynamicSizeLock: dynamicSizeLock))
    }
}
