//
//  String+Ext.swift
//  Shoplon
//
//  Created by Telman Yusifov on 03.06.25.
//

import Foundation

extension String {
    func isValidEmail() -> Bool {
        let emailRegex = "^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,64}$"
        let emailPredicate = NSPredicate(format: "SELF MATCHES[c] %@", emailRegex)
        return emailPredicate.evaluate(with: self)
    }
}
