//
//  TitleProtocol.swift
//  SmartTrials
//
//  Created by JimmyChao on 2024/7/31.
//

import Foundation
import SwiftUI

public protocol TitleProtocol: Identifiable {
    var title: String { get }
    var id: UUID { get }
    var selectedIcon: Image? { get set }
    var nonSelectedIcon: Image? { get set }
    
}

extension TitleProtocol {
    var selectedIcon: Image? {
        get { nil }
        set {}
    }
    var nonSelectedIcon: Image? {
        get { nil }
        set {}
    }
}

