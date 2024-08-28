//
//  ListModifier.swift
//  SmartTrials
//
//  Created by JimmyChao on 2024/7/31.
//

import Foundation
import SwiftUI

public struct STListRowModifier: ViewModifier {
    
    public func body(content: Content) -> some View {
        content
            .listRowSeparator(.hidden)
            .scrollContentBackground(.hidden)
            .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
            .listRowBackground(Color.clear)
            .background(.clear)
    }
}

public extension View {
    func primListRowStyle() -> some View {
        modifier(STListRowModifier())
    }
}
