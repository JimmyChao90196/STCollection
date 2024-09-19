//
//  AlertView.swift
//  STCollection
//
//  Created by JimmyChao on 2024/9/19.
//

import SwiftUI

struct AlertView<Content: View>: View {
    
    @Binding var config: AlertConfig
    var tag: Int
    @ViewBuilder var content: () -> Content
    
    @State var showView: Bool = false
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                
                if config.enableBackgroundBlur {
                    Rectangle().fill(.ultraThinMaterial)
                } else {
                    Rectangle().fill(.primary.opacity(0.25))
                }
                
            }
            .ignoresSafeArea()
            .contentShape(.rect)
            .onTapGesture {
                if !config.disableOutSideTap {
                    config.dismiss()
                }
            }
            .opacity(showView ? 1: 0)
            
            if showView && config.transition == .slide {
                content()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .transition(.move(edge: .bottom))
            } else {
                content()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .opacity(showView ? 1: 0)
            }
        }
        .onAppear {
            withAnimation {
                config.showView = true
            }
        }
        .onChange(of: config.showView) { oldValue, newValue in
            withAnimation {
                showView = newValue
            }
        }
    }
}
