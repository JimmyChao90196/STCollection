//
//  Divider.swift
//  SmartTrials
//
//  Created by JimmyChao on 2024/8/1.
//

import SwiftUI

public struct STHDivider: View {
    
    let color: Color
    let height: CGFloat
    
    public init(color: Color, height: CGFloat) {
        self.color = color
        self.height = height
    }
    
    public var body: some View {
        Rectangle()
            .fill(color)
            .frame(height: height)
    }
}
