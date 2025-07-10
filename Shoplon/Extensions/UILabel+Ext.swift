//
//  UILabel+Ext.swift
//  Shoplon
//
//  Created by Telman Yusifov on 22.05.25.
//

import UIKit

extension UILabel {
    func halfTextColorChange (fullText : String , changeText : String, color: UIColor, font: UIFont?) {
        let strNumber: NSString = fullText as NSString
        let range = (strNumber).range(of: changeText)
        let attribute = NSMutableAttributedString.init(string: fullText); attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range:NSRange(location: range.location, length: range.length) )
        if let font = font {
            attribute.addAttribute(NSAttributedString.Key.font, value: font, range:NSRange(location: range.location, length: range.length))
        }
        self.attributedText = attribute
    }
}
