//
//  TextFieldType.swift
//  SmartTrials
//
//  Created by JimmyChao on 2024/8/2.
//

import Foundation
import SwiftUI

// Define your custom TextFieldType
//public enum STTextFieldType: Hashable {
//    case name(title: String = "姓名", placeholder: String = "請輸入您的姓名")
//    case birthday(title: String = "出生日期", placeholder: String = "請輸入您的出生日期")
//    case id(title: String = "身分證字號", placeholder: String = "請輸入您的身分證字號")
//    case healthId(title: String = "健保卡字號", placeholder: String = "請輸入您的健保卡字號")
//    case email(title: String = "電子郵件", placeholder: String = "請輸入您的電子郵件")
//    case cellphone(title: String = "手機號碼", placeholder: String = "請輸入您的手機號碼")
//    case address(title: String = "地址", placeholder: String = "請輸入您的地址")
//    case contact(title: String = "聯絡人", placeholder: String = "請輸入聯絡人姓名")
//    case contactPersonPhone(title: String = "聯絡人電話", placeholder: String = "請輸入聯絡人電話")
//    case telephone(title: String = "家用電話", placeholder: String = "請輸入家用電話")
//    case sex(title: String = "生理性別", placeholder: String = "請輸入您的生理性別")
//    case accountName(title: String = "帳號", placeholder: String = "請輸入您的帳號")
//    case password(title: String = "密碼", placeholder: String = "請輸入您的密碼")
//    case currentPassword(title: String = "目前密碼", placeholder: String = "請輸入您目前的密碼")
//    case newPassword(title: String = "新密碼", placeholder: String = "請輸入您的新密碼")
//    case confirmPassword(title: String = "確認密碼", placeholder: String = "請再次輸入您的新密碼")
//    
//    case heartRate(title: String = "心跳", placeholder: String = "每分鐘次數（bpm）")
//    case bloodPressure(title: String = "血壓", placeholder: String = "mmHg")
//    case bodyTemp(title: String = "體溫", placeholder: String = "°C")
//    case bodyHeight(title: String = "身高", placeholder: String = "cm")
//    case bodyWeight(title: String = "體重", placeholder: String = "kg")
//    case waistCircumference(title: String = "腰圍", placeholder: String = "cm")
//    
//    var icon: Image? {
//        switch self {
//        case .email: Image("email", bundle: .module)
//        case .password, .currentPassword, .confirmPassword: Image("lock", bundle: .module)
//        default: nil
//        }
//    }
//    
//    var keyboardType: UIKeyboardType {
//        switch self {
//        case .name, .birthday, .address, .contact, .sex:
//                .default
//        case .id, .healthId, .accountName, .password, .currentPassword, .newPassword, .confirmPassword, .email:
//                .asciiCapable
//        case .telephone, .heartRate, .bloodPressure, .bodyTemp, .bodyHeight, .bodyWeight, .waistCircumference: .numberPad
//        default: .asciiCapable
//        }
//    }
//    
//    public var placeholder: String {
//        switch self {
//        case .name(_, let placeholder),
//             .birthday(_, let placeholder),
//             .id(_, let placeholder),
//             .healthId(_, let placeholder),
//             .email(_, let placeholder),
//             .cellphone(_, let placeholder),
//             .address(_, let placeholder),
//             .contact(_, let placeholder),
//             .telephone(_, let placeholder),
//             .sex(_, let placeholder),
//             .accountName(_, let placeholder),
//             .password(_, let placeholder),
//             .currentPassword(_, let placeholder),
//             .newPassword(_, let placeholder),
//             .confirmPassword(_, let placeholder),
//             .heartRate(_, let placeholder),
//             .bloodPressure(_, let placeholder),
//             .bodyTemp(_, let placeholder),
//             .bodyHeight(_, let placeholder),
//             .bodyWeight(_, let placeholder),
//             .waistCircumference(_, let placeholder),
//             .contactPersonPhone(_, let placeholder):
//            return placeholder
//        }
//    }
//    
//    public var title: String {
//        switch self {
//        case .name(let title, _),
//             .birthday(let title, _),
//             .id(let title, _),
//             .healthId(let title, _),
//             .email(let title, _),
//             .cellphone(let title, _),
//             .address(let title, _),
//             .contact(let title, _),
//             .telephone(let title, _),
//             .sex(let title, _),
//             .accountName(let title, _),
//             .password(let title, _),
//             .currentPassword(let title, _),
//             .newPassword(let title, _),
//             .confirmPassword(let title, _),
//             .heartRate(let title, _),
//             .bloodPressure(let title, _),
//             .bodyTemp(let title, _),
//             .bodyHeight(let title, _),
//             .bodyWeight(let title, _),
//             .waistCircumference(let title, _),
//             .contactPersonPhone(let title, _):
//            return title
//        }
//    }
//}
//
//

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
public struct CustomTextFieldType: STTextFieldTypeProtocol {
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
    public static let name = CustomTextFieldType(title: "姓名", placeholder: "請輸入您的姓名", keyboardType: .default)
    public static let birthday = CustomTextFieldType(title: "出生日期", placeholder: "請輸入您的出生日期", keyboardType: .default)
    public static let id = CustomTextFieldType(title: "身分證字號", placeholder: "請輸入您的身分證字號", keyboardType: .asciiCapable)
    public static let healthId = CustomTextFieldType(title: "健保卡字號", placeholder: "請輸入您的健保卡字號", keyboardType: .asciiCapable)
    public static let email = CustomTextFieldType(title: "電子郵件", placeholder: "請輸入您的電子郵件", icon: Image("email", bundle: .module), keyboardType: .asciiCapable)
    public static let cellphone = CustomTextFieldType(title: "手機號碼", placeholder: "請輸入您的手機號碼", keyboardType: .asciiCapable)
    public static let address = CustomTextFieldType(title: "地址", placeholder: "請輸入您的地址", keyboardType: .default)
    public static let contact = CustomTextFieldType(title: "聯絡人", placeholder: "請輸入聯絡人姓名", keyboardType: .default)
    public static let contactPersonPhone = CustomTextFieldType(title: "聯絡人電話", placeholder: "請輸入聯絡人電話", keyboardType: .asciiCapable)
    public static let telephone = CustomTextFieldType(title: "家用電話", placeholder: "請輸入家用電話", keyboardType: .numberPad)
    public static let sex = CustomTextFieldType(title: "生理性別", placeholder: "請輸入您的生理性別", keyboardType: .default)
    public static let accountName = CustomTextFieldType(title: "帳號", placeholder: "請輸入您的帳號", keyboardType: .asciiCapable)
    public static let password = CustomTextFieldType(title: "密碼", placeholder: "請輸入您的密碼", icon: Image("lock", bundle: .module), keyboardType: .asciiCapable)
    public static let currentPassword = CustomTextFieldType(title: "目前密碼", placeholder: "請輸入您目前的密碼", icon: Image("lock", bundle: .module), keyboardType: .asciiCapable)
    public static let newPassword = CustomTextFieldType(title: "新密碼", placeholder: "請輸入您的新密碼", icon: Image("lock", bundle: .module), keyboardType: .asciiCapable)
    public static let confirmPassword = CustomTextFieldType(title: "確認密碼", placeholder: "請再次輸入您的新密碼", icon: Image("lock", bundle: .module), keyboardType: .asciiCapable)
    public static let heartRate = CustomTextFieldType(title: "心跳", placeholder: "每分鐘次數（bpm）", keyboardType: .numberPad)
    public static let bloodPressure = CustomTextFieldType(title: "血壓", placeholder: "mmHg", keyboardType: .numberPad)
    public static let bodyTemp = CustomTextFieldType(title: "體溫", placeholder: "°C", keyboardType: .numberPad)
    public static let bodyHeight = CustomTextFieldType(title: "身高", placeholder: "cm", keyboardType: .numberPad)
    public static let bodyWeight = CustomTextFieldType(title: "體重", placeholder: "kg", keyboardType: .numberPad)
    public static let waistCircumference = CustomTextFieldType(title: "腰圍", placeholder: "cm", keyboardType: .numberPad)
}
