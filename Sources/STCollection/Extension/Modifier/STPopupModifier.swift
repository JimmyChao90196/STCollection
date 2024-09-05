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
        _ materialEnabel: Bool = true,
        backgroundOpacity: CGFloat = 0.5,
        backgroundMaterial: Material = .ultraThinMaterial) -> some View {
            modifier(STGenericPopupModifier(
                popupContent: content,
                materialEnable: materialEnabel, 
                backgroundEnable: backgroundEnabel,
                backgroundOpacity: backgroundOpacity,
                backgroundMaterial: backgroundMaterial))
    }
}

public struct STGenericPopupModifier<PopupView: View & Popable>: ViewModifier {
    
    let popupContent: PopupView
    let backgroundEnable: Bool
    let materialEnable: Bool
    var backgroundOpacity: CGFloat
    var backgroundMaterial: Material
    
    init(popupContent: PopupView, materialEnable: Bool, backgroundEnable: Bool, backgroundOpacity: CGFloat, backgroundMaterial: Material) {
        self.popupContent = popupContent
        self.materialEnable = materialEnable
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
                        .if(materialEnable, then: { view in
                            view.background(backgroundMaterial)
                        }, else: { view in
                            view
                        })
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


