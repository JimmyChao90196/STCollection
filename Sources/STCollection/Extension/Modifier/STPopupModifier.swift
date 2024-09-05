//
//  PopupModifier.swift
//  SmartTrials
//
//  Created by JimmyChao on 2024/8/6.
//

import Foundation
import SwiftUI

public extension View {
    
    func popup<PopupView: View & Popable>( content: PopupView, _ backgroundEnabel: Bool = true, backgroundOpacity: CGFloat = 0.5) -> some View {
        modifier(STGenericPopupModifier(popupContent: content, backgroundEnable: backgroundEnabel, backgroundOpacity: backgroundOpacity))
    }
}

public struct STGenericPopupModifier<PopupView: View & Popable>: ViewModifier {
    
    let popupContent: PopupView
    let backgroundEnable: Bool
    var backgroundOpacity: CGFloat
    
    init(popupContent: PopupView, backgroundEnable: Bool = true, backgroundOpacity: CGFloat) {
        self.popupContent = popupContent
        self.backgroundEnable = backgroundEnable
        self.backgroundOpacity = backgroundOpacity
    }
    

    public func body(content: Content) -> some View {
        ZStack {
            content
            if popupContent.isShow {
                
                if backgroundEnable == true {
                    Color.black.opacity(backgroundOpacity)
                        .edgesIgnoringSafeArea(.all)
                        .background(.ultraThinMaterial)
                        .zIndex(10)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                
                
                popupContent
                    .zIndex(100)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .animation(.easeInOut, value: popupContent.isShow)
    }
}


