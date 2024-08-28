//
//  TextFieldType.swift
//  SmartTrials
//
//  Created by JimmyChao on 2024/8/2.
//

import Foundation
import SwiftUI

// Define your custom TextFieldType
public enum STTextFieldType: Hashable {
    case name(title: String = "姓名", placeholder: String = "請輸入您的姓名")
    case birthday(title: String = "出生日期", placeholder: String = "請輸入您的出生日期")
    case id(title: String = "身分證字號", placeholder: String = "請輸入您的身分證字號")
    case healthId(title: String = "健保卡字號", placeholder: String = "請輸入您的健保卡字號")
    case email(title: String = "電子郵件", placeholder: String = "請輸入您的電子郵件")
    case cellphone(title: String = "手機號碼", placeholder: String = "請輸入您的手機號碼")
    case address(title: String = "地址", placeholder: String = "請輸入您的地址")
    case contact(title: String = "聯絡人", placeholder: String = "請輸入聯絡人姓名")
    case telephone(title: String = "家用電話", placeholder: String = "請輸入家用電話")
    case sex(title: String = "生理性別", placeholder: String = "請輸入您的生理性別")
    case password(title: String = "密碼", placeholder: String = "請輸入您的密碼")
    case currentPassword(title: String = "目前密碼", placeholder: String = "請輸入您目前的密碼")
    case newPassword(title: String = "新密碼", placeholder: String = "請輸入您的新密碼")
    case confirmPassword(title: String = "確認密碼", placeholder: String = "請再次輸入您的新密碼")
    
    var icon: Image? {
        switch self {
        case .email: Image("email", bundle: .module)
        case .password, .currentPassword, .confirmPassword: Image("lock", bundle: .module)
        default: nil
        }
    }
    
    var keyboardType: UIKeyboardType {
        switch self {
        case .name, .birthday, .address, .contact, .sex:
                .default
        case .id, .healthId, .password, .currentPassword, .newPassword, .confirmPassword, .email:
                .asciiCapable
        case .telephone: .numberPad
        default: .asciiCapable
        }
    }
    
    var placeholder: String {
        switch self {
        case .name(_, let placeholder),
             .birthday(_, let placeholder),
             .id(_, let placeholder),
             .healthId(_, let placeholder),
             .email(_, let placeholder),
             .cellphone(_, let placeholder),
             .address(_, let placeholder),
             .contact(_, let placeholder),
             .telephone(_, let placeholder),
             .sex(_, let placeholder),
             .password(_, let placeholder),
             .currentPassword(_, let placeholder),
             .newPassword(_, let placeholder),
             .confirmPassword(_, let placeholder):
            return placeholder
        }
    }
    
    var title: String {
        switch self {
        case .name(let title, _),
             .birthday(let title, _),
             .id(let title, _),
             .healthId(let title, _),
             .email(let title, _),
             .cellphone(let title, _),
             .address(let title, _),
             .contact(let title, _),
             .telephone(let title, _),
             .sex(let title, _),
             .password(let title, _),
             .currentPassword(let title, _),
             .newPassword(let title, _),
             .confirmPassword(let title, _) :
            return title
        }
    }

//    var placeholder: String {
//        
//        switch self {
//        case .name:
//            "請輸入您的姓名"
//        case .birthday:
//            "請輸入您的生日"
//        case .id:
//            "請輸入您的身分證字號"
//        case .healthId:
//            "請輸入您的健保卡號"
//        case .cellphone:
//            "請輸入您的手機"
//        case .address:
//            "請輸入您的地址"
//        case .contact:
//            "請輸入聯絡人姓名"
//        case .telephone:
//            "請輸入電話"
//        case .sex:
//            "請輸入您的性別"
//        case .password:
//            "請輸入您的密碼"
//        case .currentPassword:
//            "請輸入目前密碼"
//        case .newPassword:
//            "請輸入6位數以上的英數組合密碼"
//        case .confirmPassword:
//            "請再次輸入新密碼"
//        case .email:
//            "請輸入您的電子郵件"
//        }
//    }
}
