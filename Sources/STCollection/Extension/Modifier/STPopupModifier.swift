//
//  PopupModifier.swift
//  SmartTrials
//
//  Created by JimmyChao on 2024/8/6.
//

import Foundation
import SwiftUI

@available(*, deprecated, message: "The popup extension method will not be supported in the future update.", renamed: "stAlert")
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

public extension View {
    @ViewBuilder
    func stAlert<Content: View>(alertConfig: Binding<AlertConfig>, @ViewBuilder content: @escaping () -> Content) -> some View {
        self.modifier(AlertModifier(config: alertConfig, alertContent: content))
    }
}



@available(*, deprecated, message: "The popup modifier will not be supported in the future update.", renamed: "AlertModifier")
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


public struct AlertModifier<AlertContent: View>: ViewModifier {
    
    @Binding var config: AlertConfig
    @ViewBuilder var alertContent: () -> AlertContent
    /// Scene Delegate
    @Environment(STSceneDelegate.self) private var sceneDelegate
    
    /// View Tag
    @State private var viewTag: Int = 0
    public func body(content: Content) -> some View {
        content
            .onChange(of: config.show, initial: false) { oldValue, newValue in
                if newValue {
                    
                    sceneDelegate.alert(config: $config, content: alertContent) { tag in
                        viewTag = tag
                    }
                } else {
                    
                    guard let alertWindow = sceneDelegate.overlayWindow else { return }
                    
                    if config.showView {
                        withAnimation {
                            config.showView = false
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                            if sceneDelegate.alerts.isEmpty {
                                alertWindow.rootViewController = nil
                                alertWindow.isHidden = true
                                alertWindow.isUserInteractionEnabled = false
                            } else {
                                
                                if let first = sceneDelegate.alerts.first {
                                    
                                    alertWindow.rootViewController?.view.subviews.forEach({ view in
                                        view.removeFromSuperview()
                                    })
                                    
                                    alertWindow.rootViewController?.view.addSubview(first)
                                    sceneDelegate.alerts.removeFirst()
                                }
                            }
                        }
                        
                    } else {
                        print("View is Not Appear")
                        sceneDelegate.alerts.removeAll {
                            $0.tag == viewTag
                        }
                    }
                }
            }
    }
}

