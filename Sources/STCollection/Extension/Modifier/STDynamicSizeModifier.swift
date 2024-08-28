//
//  Extensions.swift
//  SmartTrials
//
//  Created by JimmyChao on 2024/7/26.
//

import Foundation
import SwiftUI

struct STDynamicTypeModifierA: ViewModifier {
    
    let font: Font
    let dynamicTypeSize: DynamicTypeSize
    
    func body(content: Content) -> some View {
        content
            .font(font)
            .dynamicTypeSize(dynamicTypeSize)
    }
}

struct STDynamicTypeModifierB: ViewModifier {
    
    let font: Font
    let dynamicTypeSize: PartialRangeThrough<DynamicTypeSize>
    
    func body(content: Content) -> some View {
        content
            .font(font)
            .dynamicTypeSize(dynamicTypeSize)
    }
}

public extension View {
    // Function for single DynamicTypeSize
    func customDynamicSize(
        font: Font = .callout,
        _ dynamicTypeSize: DynamicTypeSize = .xLarge) -> some View {
        modifier(STDynamicTypeModifierA(font: font, dynamicTypeSize: dynamicTypeSize))
    }
    
    // Function for a range of DynamicTypeSize
    func customDynamicSize(
        font: Font = .callout,
        _ dynamicTypeSize: PartialRangeThrough<DynamicTypeSize> = ...DynamicTypeSize.xLarge) -> some View {
        modifier(STDynamicTypeModifierB(font: font, dynamicTypeSize: dynamicTypeSize))
    }
}

