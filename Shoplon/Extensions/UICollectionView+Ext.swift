//
//  UICollectionView+Ext.swift
//  Shoplon
//
//  Created by Telman Yusifov on 29.05.25.
//

import UIKit

extension UICollectionView {
    func dequeueCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        let bareCell = self.dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath)
        guard let cell = bareCell as? T else {
            fatalError("Failed to dequeue a cell with identifier: \(T.identifier)")
        }
        return cell
    }
}
