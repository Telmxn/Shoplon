//
//  BookmarkRouter.swift
//  Shoplon
//
//  Created by Telman Yusifov on 24.06.25.
//

import UIKit

enum BookmarkRoute {
    case product
}

final class BookmarkRouter {
    weak var view: UIViewController?
    
    func navigate(to route: BookmarkRoute) {
        switch route {
        case .product:
            print("Product")
        }
    }
}
