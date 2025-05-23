//
//  Keyboardable.swift
//  Shoplon
//
//  Created by Telman Yusifov on 21.05.25.
//

import UIKit
import SnapKit

protocol Keyboardable: AnyObject {
    var targetConstraint: Constraint? { get set }
    
    func startKeyboardObserve()
}


extension Keyboardable where Self: UIViewController {
    
    private func getHeight(userInfo: [AnyHashable: Any]?) -> CGFloat {
        if let keyboardRect = userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            return keyboardRect.height
        }
        return 0
    }
    
    func startKeyboardObserve() {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: nil) { [weak self] notification in
            let height = self?.getHeight(userInfo: notification.userInfo) ?? 0
            self?.targetConstraint?.update(offset: -height + 16)
            self?.view.layoutIfNeeded()
        }
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil) { [weak self] notification in
            self?.targetConstraint?.update(offset: -24)
            self?.view.layoutIfNeeded()
        }
    }
}
