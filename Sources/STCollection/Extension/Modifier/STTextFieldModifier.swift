//
//  TextFieldModifier.swift
//  SmartTrials
//
//  Created by JimmyChao on 2024/8/2.
//

import Foundation
import SwiftUI

struct STTextFeildModifier: ViewModifier {
    
    let keyboardType: UIKeyboardType
    
    func body(content: Content) -> some View {
        content
            .textInputAutocapitalization(.never)
            .keyboardType(keyboardType)
            .autocorrectionDisabled()
            .submitLabel(.done)
            .onTapGesture {}
    }
}

extension View {
    
    func fieldSetting(keyboardType: UIKeyboardType = .asciiCapable) -> some View {
        modifier(STTextFeildModifier(keyboardType: keyboardType))
    }
}
