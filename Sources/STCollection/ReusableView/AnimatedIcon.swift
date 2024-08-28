//
//  AnimatedIcon.swift
//  SmartTrials
//
//  Created by JimmyChao on 2024/7/31.
//

import Foundation
import SwiftUI

public struct AnimatedImageView<T: SymbolEffect & DiscreteSymbolEffect>: View {
    
    var inputIcon: Image
    var action: (() -> Void)? = nil
    var effect: T
    var options: SymbolEffectOptions = .default
    @State var animate: Bool = false
    
    public init(
        inputIcon: Image,
        effect: T,
        options: SymbolEffectOptions = .default,
        action: (() -> Void)? = nil
    ) {
        self.inputIcon = inputIcon
        self.effect = effect
        self.options = options
        self.action = action
    }


    public var body: some View {
        inputIcon
            .symbolEffect(effect, options: options, value: animate)
            .onTapGesture {
                animate.toggle()
                action?()
            }
    }
}

