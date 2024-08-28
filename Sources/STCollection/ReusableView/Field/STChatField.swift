//
//  STChatField.swift
//  SmartTrials
//
//  Created by JimmyChao on 2024/8/22.
//

import Foundation
import SwiftUI

public struct STChatField: View {
    let placeholder: String
    @Binding var inputText: String
    var sentAction: (String) -> Void
    
    public init(
        placeholder: String,
        inputText: Binding<String>,
        sentAction: @escaping (String) -> Void
    ) {
        self.placeholder = placeholder
        self._inputText = inputText
        self.sentAction = sentAction
    }
    
    public var body: some View {
        
        HStack {
            HStack(spacing: 0) {
                Group {
                    ZStack {
                        TextField("", text: $inputText)
                            .textFieldStyle(PlainTextFieldStyle())
                            .placeholder(when: inputText.isEmpty) {
                                Text(placeholder)
                                    .foregroundStyle(Color.black.opacity(0.2))
                                    .fontWeight(.bold)
                            }
                            .customDynamicSize(font: .callout, ...DynamicTypeSize.xxxLarge)
                            .autocorrectionDisabled()
                    }
                }
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .multilineTextAlignment(.leading)
                .padding(5)
                .frame(maxWidth: .infinity)
                .background(.clear)
                
                Image(systemName: "paperclip")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .padding(.trailing, 5)
                
            }
            .padding(.horizontal, 15)
            .frame(height: 40)
            .bubbleStyle(.white, 50)
            .overlay {
                RoundedRectangle(cornerRadius: 50)
                    .stroke(Color.black.opacity(0.2), lineWidth: 1.25)
            }
            
            
            if !inputText.isEmpty {
                Button {
                    sentAction(inputText)
                } label: {
                    Text("送出")
                        .foregroundStyle(.white)
                        .customDynamicSize(font: .callout, ...DynamicTypeSize.xxLarge)
                        .fontWeight(.heavy)
                        .lineLimit(1)
                        .minimumScaleFactor(0.1)
                        .padding(.horizontal, 25)
                        .frame(height: 40)
                        .bubbleStyle(.ST_1B0851, 50)
                }
            }
        }
    }
    
    enum FieldToFocus {
        case secureField, textField
    }
}

#Preview {
    return STChatField(
        placeholder: "請輸入文字",
        inputText: .constant("")) { _ in }
}
