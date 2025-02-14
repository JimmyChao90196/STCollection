//
//  Validator.swift
//  STCollection
//
//  Created by JimmyChao on 2024/12/2.
//

import SwiftUI
import Foundation

// MARK: Protocol -
@available(*, deprecated, message: "The validator protocol will not be supported in the future update.")
public protocol Validator {
    var type: STTextFieldType? { get set }
    
    var input: String { get set }
    var inputDate: Date { get set }
    
    func validate() -> (Bool, LocalizedStringKey?)
    func isEmpty() -> (Bool, LocalizedStringKey?)
    func stepValidate() -> [String: (LocalizedStringKey, Bool)]
}

public extension Validator {
    
    var input: String {
        get { "" }
        set {}
    }
    var inputDate: Date {
        get { .now }
        set {}
    }
    
    var type: STTextFieldType? {
        get { nil }
        set { }
    }
    
    func stepValidate() -> [String: (LocalizedStringKey, Bool)] {
        return [:]
    }
}
