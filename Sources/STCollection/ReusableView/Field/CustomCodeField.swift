//
//  CustomCodeField.swift
//  SmartTrials
//
//  Created by JimmyChao on 2024/8/13.
//

import SwiftUI

public struct STCodeField: View {
    
    @Binding var digits: [String]
    @FocusState private var focusedField: Int?
    
    var cornerRadius: CGFloat
    var spacing: CGFloat
    var strokeColor: Color
    
    public init(
        digits: Binding<[String]>,
        cornerRadius: CGFloat = 16,
        spacing: CGFloat = 30,
        strokeColor: Color = .black
    ) {
        self._digits = digits
        self.cornerRadius = cornerRadius
        self.spacing = spacing
        self.strokeColor = strokeColor
    }
    
    public var body: some View {
        HStack(spacing: spacing) {
            ForEach(0..<digits.count, id: \.self) { index in
                GeometryReader { proxy in
                    
                    TextField("", text: $digits[index])
                        .textFieldStyle(.plain)
                        .frame(maxWidth: .infinity)
                        .frame(height: proxy.size.width)
                        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
                        .multilineTextAlignment(.center)
                        .keyboardType(.numberPad)
                        .focused($focusedField, equals: index)
                        .onChange(of: digits[index]) { oldValue, newValue in
                            if newValue.count > 1 {
                                digits[index] = String(newValue.last!)
                            }
                            if newValue.count == 1 && index < digits.count - 1 {
                                focusedField = index + 1
                            } else if newValue.isEmpty && index > 0 {
                                focusedField = index - 1
                            }
                        }
                        .onSubmit {
                            if index < digits.count - 1 {
                                focusedField = index + 1
                            }
                        }
                        .overlay(
                            RoundedRectangle(cornerRadius: cornerRadius)
                                .stroke(strokeColor, lineWidth: 1.0)
                        )
                }
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            handleTap()
        }
        .padding(.horizontal)
    }
    
    private func handleTap() {
        // Find the first empty field
        if let firstEmptyIndex = digits.firstIndex(where: { $0.isEmpty }) {
            
            if digits.first!.isEmpty {
                focusedField = 0
            } else {
                focusedField = firstEmptyIndex - 1
            }
            
        } else {
            // If all fields are filled, focus the last one
            focusedField = digits.count - 1
        }
    }
}

#Preview {
    //STCodeField(digits: .constant(Array(repeating: "", count: 6)))
    STCodeField(digits: .constant(Array(repeating: "", count: 6)),
                cornerRadius: 10,
                spacing: 20)
}
