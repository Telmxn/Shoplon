//
//  UIView+Ext.swift
//  Shoplon
//
//  Created by Telman Yusifov on 21.05.25.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        for view in views {
            self.addSubview(view)
        }
    }
}
