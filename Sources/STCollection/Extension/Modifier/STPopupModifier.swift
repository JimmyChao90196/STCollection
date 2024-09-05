//
//  PopupModifier.swift
//  SmartTrials
//
//  Created by JimmyChao on 2024/8/6.
//

import Foundation
import SwiftUI

public extension View {
    
    func popup<PopupView: View & Popable>(
        content: PopupView,
        _ backgroundEnabel: Bool = true,
        backgroundOpacity: CGFloat = 0.5,
        backgroundMaterial: Material = .ultraThinMaterial) -> some View {
            modifier(STGenericPopupModifier(
                popupContent: content,
                backgroundEnable: backgroundEnabel,
                backgroundOpacity: backgroundOpacity,
                backgroundMaterial: backgroundMaterial))
    }
}

public struct STGenericPopupModifier<PopupView: View & Popable>: ViewModifier {
    
    let popupContent: PopupView
    let backgroundEnable: Bool
    var backgroundOpacity: CGFloat
    var backgroundMaterial: Material
    
    init(popupContent: PopupView, backgroundEnable: Bool, backgroundOpacity: CGFloat, backgroundMaterial: Material) {
        self.popupContent = popupContent
        self.backgroundEnable = backgroundEnable
        self.backgroundOpacity = backgroundOpacity
        self.backgroundMaterial = backgroundMaterial
    }

    public func body(content: Content) -> some View {
        ZStack {
            content
            if popupContent.isShow {
                
                if backgroundEnable == true {
                    Color.black.opacity(backgroundOpacity)
                        .edgesIgnoringSafeArea(.all)
                        .background(backgroundMaterial)
                        .zIndex(10)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)}
                
                popupContent
                    .zIndex(100)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .animation(.easeInOut, value: popupContent.isShow)
    }
}


