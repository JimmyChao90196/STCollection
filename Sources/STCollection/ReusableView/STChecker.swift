//
//  STChecker.swift
//  SmartTrials
//
//  Created by JimmyChao on 2024/8/12.
//

import SwiftUI

public struct STChecker: View {
    
    @Binding var isChecked: Bool
    
    var text: String = "記住我的密碼"
    var bgColor: Color = Color.clear
    var frameColor = Color.black
    var strokeWidth: CGFloat = 1
    var checkerSize: CGFloat = 13
    var cornerRadius: CGFloat = 2
    
    public init(
        isChecked: Binding<Bool>,
        text: String = "記住我的密碼",
        bgColor: Color = .clear,
        frameColor: Color = .black,
        strokeWidth: CGFloat = 1,
        checkerSize: CGFloat = 13,
        cornerRadius: CGFloat = 2
    ) {
        self._isChecked = isChecked
        self.text = text
        self.bgColor = bgColor
        self.frameColor = frameColor
        self.strokeWidth = strokeWidth
        self.checkerSize = checkerSize
        self.cornerRadius = cornerRadius
    }
    
    public var body: some View {
        HStack {
            
            Rectangle()
                .fill(bgColor)
                .frame(width: checkerSize, height: checkerSize)
                .clipShape(.rect(cornerRadius: cornerRadius))
                .overlay {
                    RoundedRectangle(cornerRadius: cornerRadius).stroke(frameColor, lineWidth: strokeWidth)
                    if isChecked {
                        Image(systemName: "checkmark")
                            .resizable()
                            .scaledToFit()
                            .frame(width: checkerSize * 0.85, height: checkerSize * 0.85)
                    }
                }
            
            Text(text)
                .customDynamicSize(font: .footnote, ...DynamicTypeSize.xxLarge)
        }
        .onTapGesture {
            isChecked.toggle()
        }
    }
}
