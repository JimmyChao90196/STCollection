
import Foundation
import SwiftUI

// Define your custom TextFieldType
public protocol STTextFieldTypeProtocol: Hashable {
    var title: String { get }
    var placeholder: String { get }
    var icon: Image? { get }
    var keyboardType: UIKeyboardType { get }
}

// Default implementation for optional properties
public extension STTextFieldTypeProtocol {
    var icon: Image? { nil }
    var keyboardType: UIKeyboardType { .default }
}

// Generic struct conforming to the protocol for custom use
public struct STTextFieldType: STTextFieldTypeProtocol {
    public var title: String
    public var placeholder: String
    public var icon: Image?
    public var keyboardType: UIKeyboardType
    
    public init(title: String, placeholder: String, icon: Image? = nil, keyboardType: UIKeyboardType = .default) {
        self.title = title
        self.placeholder = placeholder
        self.icon = icon
        self.keyboardType = keyboardType
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(title)
    }
}

// Struct managing all text field types with static properties
public struct TextFieldTypeRegistry {
    public static let name = STTextFieldType(title: "姓名", placeholder: "請輸入您的姓名", keyboardType: .default)
    public static let birthday = STTextFieldType(title: "出生日期", placeholder: "請輸入您的出生日期", keyboardType: .default)
    public static let id = STTextFieldType(title: "身分證字號", placeholder: "請輸入您的身分證字號", keyboardType: .asciiCapable)
    public static let healthId = STTextFieldType(title: "健保卡字號", placeholder: "請輸入您的健保卡字號", keyboardType: .asciiCapable)
    public static let email = STTextFieldType(title: "電子郵件", placeholder: "請輸入您的電子郵件", icon: Image("email", bundle: .module), keyboardType: .asciiCapable)
    public static let cellphone = STTextFieldType(title: "手機號碼", placeholder: "請輸入您的手機號碼", keyboardType: .asciiCapable)
    public static let address = STTextFieldType(title: "地址", placeholder: "請輸入您的地址", keyboardType: .default)
    public static let contact = STTextFieldType(title: "聯絡人", placeholder: "請輸入聯絡人姓名", keyboardType: .default)
    public static let contactPersonPhone = STTextFieldType(title: "聯絡人電話", placeholder: "請輸入聯絡人電話", keyboardType: .asciiCapable)
    public static let telephone = STTextFieldType(title: "家用電話", placeholder: "請輸入家用電話", keyboardType: .numberPad)
    public static let sex = STTextFieldType(title: "生理性別", placeholder: "請輸入您的生理性別", keyboardType: .default)
    public static let accountName = STTextFieldType(title: "帳號", placeholder: "請輸入您的帳號", keyboardType: .asciiCapable)
    public static let password = STTextFieldType(title: "密碼", placeholder: "請輸入您的密碼", icon: Image("lock", bundle: .module), keyboardType: .asciiCapable)
    public static let currentPassword = STTextFieldType(title: "目前密碼", placeholder: "請輸入您目前的密碼", icon: Image("lock", bundle: .module), keyboardType: .asciiCapable)
    public static let newPassword = STTextFieldType(title: "新密碼", placeholder: "請輸入您的新密碼", icon: Image("lock", bundle: .module), keyboardType: .asciiCapable)
    public static let confirmPassword = STTextFieldType(title: "確認密碼", placeholder: "請再次輸入您的新密碼", icon: Image("lock", bundle: .module), keyboardType: .asciiCapable)
    public static let heartRate = STTextFieldType(title: "心跳", placeholder: "每分鐘次數（bpm）", keyboardType: .numberPad)
    public static let bloodPressure = STTextFieldType(title: "血壓", placeholder: "mmHg", keyboardType: .numberPad)
    public static let bodyTemp = STTextFieldType(title: "體溫", placeholder: "°C", keyboardType: .numberPad)
    public static let bodyHeight = STTextFieldType(title: "身高", placeholder: "cm", keyboardType: .numberPad)
    public static let bodyWeight = STTextFieldType(title: "體重", placeholder: "kg", keyboardType: .numberPad)
    public static let waistCircumference = STTextFieldType(title: "腰圍", placeholder: "cm", keyboardType: .numberPad)
}
