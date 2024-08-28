//
//  ConditionalModifier.swift
//  SmartTrials
//
//  Created by JimmyChao on 2024/7/29.
//

import Foundation
import SwiftUI

public extension View {

    @ViewBuilder
    func `if`<T: View, U: View>(
        _ condition: Bool,
        then modifierT: (Self) -> T,
        else modifierU: (Self) -> U
    ) -> some View {

        if condition { modifierT(self) }
        else { modifierU(self) }
    }
}

public extension View {

    @ViewBuilder
    func doubleIf<T: View, U: View, Z: View>(
        _ condition1: Bool,
        _ condition2: Bool,
        then modifierT: (Self) -> T,
        elseIf modifierU: (Self) -> U,
        else modifierZ: (Self) -> Z
    ) -> some View {

        if condition1 { modifierT(self) }
        else if condition2 { modifierU(self) }
        else { modifierZ(self) }
    }
}
