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
    
    // Internal state controlled by this view
    @State private var internalAnimate: Bool = false
    
    // Binding for external control
    @Binding private var externalAnimate: Bool

    // Control flag to determine whether to use internal or external animate state
    private var usesExternalControl: Bool

    // First initializer: Internal control
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
        self._externalAnimate = .constant(false) // Provide a default binding
        self.usesExternalControl = false
    }

    // Second initializer: External control
    public init(
        inputIcon: Image,
        effect: T,
        options: SymbolEffectOptions = .default,
        animate: Binding<Bool>,
        action: (() -> Void)? = nil
    ) {
        self.inputIcon = inputIcon
        self.effect = effect
        self.options = options
        self.action = action
        self._externalAnimate = animate
        self.usesExternalControl = true
    }

    public var body: some View {
        inputIcon
            .symbolEffect(effect, options: options, value: usesExternalControl ? externalAnimate : internalAnimate)
            .onTapGesture {
                if usesExternalControl {
                    externalAnimate.toggle()
                } else {
                    internalAnimate.toggle()
                }
                action?()
            }
    }
}


