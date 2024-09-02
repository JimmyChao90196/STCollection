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

public struct STVDivider: View {
    
    let color: Color
    let width: CGFloat
    let height: CGFloat
    
    public init(color: Color, width: CGFloat, height: CGFloat = 10) {
        self.color = color
        self.width = width
        self.height = height
    }
    
    public var body: some View {
        Rectangle()
            .fill(color)
            .frame(width: width, height: height)
            .clipShape(.rect(cornerRadius: 5))
    }
}
