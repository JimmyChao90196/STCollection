//
//  STNewPopup.swift
//  STCollection
//
//  Created by JimmyChao on 2024/12/5.
//

import SwiftUI
import Foundation

public extension View {
    @ViewBuilder
    func stAlert<Content: View>(alertConfig: Binding<AlertConfig>, @ViewBuilder content: @escaping () -> Content) -> some View {
        self.modifier(AlertModifier(config: alertConfig, alertContent: content))
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

