//
//  UITableView+Ext.swift
//  Shoplon
//
//  Created by Telman Yusifov on 25.06.25.
//

import UIKit

extension UITableView {
    func dequeueCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        let bareCell = self.dequeueReusableCell(withIdentifier: T.identifier, for: indexPath)
        guard let cell = bareCell as? T else {
            fatalError("Failed to dequeue a cell with identifier: \(T.identifier)")
        }
        return cell
    }
}
