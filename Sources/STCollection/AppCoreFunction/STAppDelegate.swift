//
//  Untitled.swift
//  STCollection
//
//  Created by JimmyChao on 2024/9/19.
//

import SwiftUI

@Observable
public class STAppDelegate: NSObject, UIApplicationDelegate {
    public func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions) -> UISceneConfiguration {
            let config = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
            config.delegateClass = STSceneDelegate.self
            return config
    }
}

@Observable
public class STSceneDelegate: NSObject, UIWindowSceneDelegate {
    weak var windowScene: UIWindowScene?
    var overlayWindow: UIWindow?
    var tag: Int = 0
    var alerts: [UIView] = []
    
    public func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        windowScene = scene as? UIWindowScene
        setupOverlayWindow()
    }
    
    func setupOverlayWindow() {
        guard let windowScene = windowScene else { return }
        let window = UIWindow(windowScene: windowScene)
        window.isHidden = true
        window.isUserInteractionEnabled = false
        self.overlayWindow = window
    }
    
    func alert<Content: View>(
        config: Binding<AlertConfig>,
        @ViewBuilder content: @escaping () -> Content,
        viewTag: @escaping (Int) -> ()) {
            
            guard let alertWindow = overlayWindow else { return }
            
            let viewController = UIHostingController(rootView: AlertView(config: config, tag: tag, content: {
                content()
            }))
            
            viewController.view.backgroundColor = .clear
            viewController.view.tag = tag
            viewTag(tag)
            tag += 1
            
            if alertWindow.rootViewController == nil {
                alertWindow.rootViewController = viewController
                alertWindow.isHidden = false
                alertWindow.isUserInteractionEnabled = true
            } else {
                print("Existing alert is still presented")
                viewController.view.frame = alertWindow.rootViewController?.view.frame ?? .zero
                alerts.append(viewController.view)
            }
            
        }
}
