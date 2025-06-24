//
//  CartRouter.swift
//  Shoplon
//
//  Created by Telman Yusifov on 24.06.25.
//

import UIKit

enum CartRoute {
    case product
}

final class CartRouter {
    weak var view: UIViewController?
    
    func navigate(to route: CartRoute) {
        switch route {
        case .product:
            print("Product")
        }
    }
}
