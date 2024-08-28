//
//  PopupModifier.swift
//  SmartTrials
//
//  Created by JimmyChao on 2024/8/6.
//

import Foundation
import SwiftUI

public extension View {
    
    func popup<PopupView: View & Popable>( content: PopupView, _ backgroundEnabel: Bool = true) -> some View {
        modifier(STGenericPopupModifier(popupContent: content, backgroundEnable: backgroundEnabel))
    }
}

public struct STGenericPopupModifier<PopupView: View & Popable>: ViewModifier {
    
    let popupContent: PopupView
    let backgroundEnable: Bool
    
    init(popupContent: PopupView, backgroundEnable: Bool = true) {
        self.popupContent = popupContent
        self.backgroundEnable = backgroundEnable
    }
    

    public func body(content: Content) -> some View {
        ZStack {
            content
            if popupContent.isShow {
                
                if backgroundEnable == true {
                    Color.black.opacity(0.5)
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


