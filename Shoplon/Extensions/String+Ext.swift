//
//  String+Ext.swift
//  Shoplon
//
//  Created by Telman Yusifov on 03.06.25.
//

import UIKit

extension String {
    func isValidEmail() -> Bool {
        let emailRegex = "^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,64}$"
        let emailPredicate = NSPredicate(format: "SELF MATCHES[c] %@", emailRegex)
        return emailPredicate.evaluate(with: self)
    }
    
    func isValidPassword() -> Bool {
        let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[!@#$%^&*(),.?\":{}|<>]).{8,}$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordTest.evaluate(with: self)
    }
    
    func highlightText(with searchText: String) -> NSAttributedString {
        let mutableAttributedString = NSMutableAttributedString(string: self)
        let range = (self.lowercased() as NSString).range(of: searchText.lowercased())
        
        if range.location != NSNotFound {
            mutableAttributedString.addAttribute(.foregroundColor, value: UIColor.black, range: range)
        }

        return mutableAttributedString
    }
}
