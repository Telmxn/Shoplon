//
//  CategoryProductsRouter.swift
//  Shoplon
//
//  Created by Telman Yusifov on 27.06.25.
//

import UIKit

enum CategoryProductsRoute {
    case product
}

final class CategoryProductsRouter {
    weak var view: UIViewController?
    
    func navigate(to route: CategoryProductsRoute) {
        switch route {
        case .product:
            print("Product")
        }
    }
}
