//
//  STTextField.swift
//  SmartTrials
//
//  Created by JimmyChao on 2024/8/1.
//

import Foundation
import SwiftUI

public struct STTextFeild: View {
    
    @Binding var inputData: String
    var placeholder: String
    var foregroundColor: Color = Color.ST_595757
    var style: STFieldStyle = .normal
    
    public init(
            inputData: Binding<String>,
            placeholder: String,
            foregroundColor: Color = Color.ST_595757,
            style: STFieldStyle = .normal
    ) {
        self._inputData = inputData
        self.placeholder = placeholder
        self.foregroundColor = foregroundColor
        self.style = style    
    }
    
    public var body: some View {
        
        // MARK: - Normal textfield
        TextField("", text: $inputData)
            .placeholder(placeholder, when: inputData.isEmpty)
            .customDynamicSize(font: .callout, ...DynamicTypeSize.accessibility1)
            .fontWeight(.bold)
            .multilineTextAlignment(.leading)
            .padding(5)
            .frame(maxWidth: .infinity)
            .if(style == .normal) { view in
                view
                    .innerShadow(.white, 5)
                    .overlay {
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.black.opacity(0.25), lineWidth: 1)
                    }
            } else: { view in
                view
                    .padding(.horizontal, 10)
                    .padding(.vertical)
                    .bubbleStyle(.ST_CBD8E8, 20)
            }
            .fontWeight(.bold)
            .foregroundStyle(foregroundColor)
            .padding(.horizontal, 1.25)

    }
}

#Preview {
    
    let placeholder = "請輸入資料"
    
    return STTextFeild(
        inputData: .constant(""),
        placeholder: placeholder, style: .block)
}
