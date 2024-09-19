//
//  Alert.swift
//  STCollection
//
//  Created by JimmyChao on 2024/9/19.
//

import SwiftUI

/// Alert Config
public struct AlertConfig {
    
    public var enableBackgroundBlur: Bool
    public var disableOutSideTap: Bool
    public var transition: TransitionType
    
    var show: Bool = false
    var showView: Bool = false
    
    public init(
        enableBackgroundBlur: Bool = true,
        disableOutSideTap: Bool = true,
        transition: TransitionType = .slide,
        show: Bool = false) {
        self.enableBackgroundBlur = enableBackgroundBlur
        self.disableOutSideTap = disableOutSideTap
        self.transition = transition
        self.show = show
    }
    
    public enum TransitionType {
        case slide
        case opacity
    }
    
    mutating
    public func present() {
        show = true
    }
    
    public mutating
    func dismiss() {
        show = false
    }
}
