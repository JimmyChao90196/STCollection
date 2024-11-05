//
//  PlaceholderModifier.swift
//  SmartTrials
//
//  Created by JimmyChao on 2024/8/6.
//

import Foundation
import SwiftUI

public extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}

public extension View {
    func placeholder(
        _ text: String,
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        color: Color = .ST_595757,
        font: Font = .callout,
        fontWeight: Font.Weight = .bold
    ) -> some View {
            
            placeholder(when: shouldShow, alignment: alignment) {
                Text(text)
                    .foregroundColor(color)
                    .fontWeight(fontWeight)
            }
    }
}
