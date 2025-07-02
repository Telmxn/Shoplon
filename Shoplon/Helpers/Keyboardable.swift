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
    
    var imageHeight: Int? { get set }
    var keyboardableImageView: UIImageView? { get set }
    
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
            guard let self = self else { return }
            let height = self.getHeight(userInfo: notification.userInfo)
            self.targetConstraint?.update(offset: -height + 16)
            
            if let imageView = keyboardableImageView {
                imageView.snp.updateConstraints { make in
                    make.height.equalTo(1)
                }
                imageView.alpha = 0
            }
            
            self.view.layoutIfNeeded()
        }
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil) { [weak self] notification in
            guard let self = self else { return }
            self.targetConstraint?.update(offset: -24)
            
            if let imageView = keyboardableImageView {
                imageView.snp.updateConstraints { make in
                    make.height.equalTo(self.imageHeight ?? 250)
                }
                imageView.alpha = 1
            }
            
            self.view.layoutIfNeeded()
        }
    }
}
