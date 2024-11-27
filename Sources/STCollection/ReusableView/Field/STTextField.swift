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
    @State var isShowIcon: Bool = false
    var placeholder: String

    var foregroundColor: Color = Color.ST_595757
    var style: STFieldStyle = .normal
    let fieldType: STTextFieldType
    
    var onChange: ((String) -> Void)?
    
    public init(
            inputData: Binding<String>,
            placeholder: String,
            isShowIcon: Bool = true,
            foregroundColor: Color = Color.ST_595757,
            style: STFieldStyle = .normal,
            fieldType: STTextFieldType,
            onChange: ((String) -> Void)? = nil
    ) {
        self._inputData = inputData
        self.placeholder = placeholder
        self.isShowIcon = isShowIcon
        self.foregroundColor = foregroundColor
        self.style = style
        self.fieldType = fieldType
        self.onChange = onChange
    }
    
    public var body: some View {
        
        HStack {
            
            if fieldType.icon != nil && style != .original && isShowIcon {
                fieldType.icon
            }
            
            // MARK: - Normal textfield
            TextField("", text: $inputData)
                .placeholder(placeholder, when: inputData.isEmpty)
                .customDynamicSize(font: .callout, ...DynamicTypeSize.accessibility1)
                .fontWeight(.bold)
                .multilineTextAlignment(.leading)
                .padding(5)
                .frame(maxWidth: .infinity)
                .onChange(of: inputData) { _, newValue in
                    onChange?(newValue)
                }
        }
        .doubleIf(style == .normal, style == .original, then: { view in
            view
                .padding(.horizontal, 5)
                .innerShadow(.white, 5)
                .overlay {
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.black.opacity(0.25), lineWidth: 1)
                }
        }, elseIf: { view in
            view
        }, else: { view in
            view
                .padding(.horizontal, 10)
                .padding(.vertical)
                .bubbleStyle(.ST_CBD8E8, 20)
        })
        .fontWeight(.bold)
        .foregroundStyle(foregroundColor)
        .padding(.horizontal, 1.25)
    }
}
