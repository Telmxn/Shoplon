//
//  UITextField+Ext.swift
//  Shoplon
//
//  Created by Telman Yusifov on 09.06.25.
//

import UIKit

enum tfType {
    case email
    case password
    case otpCode
    case fullName
    case phoneNumber
    case date
    case text
}

//extension UITextField {
//    func validate(type: tfType) -> Bool {
//        let text = self.text?.trimmingCharacters(in: .whitespacesAndNewlines)
//        if text == "" {
//            return false
//        } else {
//            switch type {
//            case .email:
//                return text?.isValidEmail() ?? true ? true : false
//            case .password:
//                <#code#>
//            case .otpCode:
//                <#code#>
//            case .fullName:
//                <#code#>
//            case .phoneNumber:
//                <#code#>
//            case .date:
//                <#code#>
//            case .text:
//                <#code#>
//            }
//        }
//    }
//}
