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
    
    public init(
        digits: Binding<[String]>
    ) {
        self._digits = digits
    }
    
    public var body: some View {
        HStack(spacing: 30) {
            ForEach(0..<digits.count, id: \.self) { index in
                TextField("", text: $digits[index])
                    .textFieldStyle(.plain)
                    .frame(width: 65, height: 65)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
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
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.black, lineWidth: 1.0)
                    )
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            handleTap()
        }
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
