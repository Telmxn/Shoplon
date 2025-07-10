//
//  CategoryProductsRouter.swift
//  Shoplon
//
//  Created by Telman Yusifov on 27.06.25.
//

import UIKit

enum CategoryProductsRoute {
    case product
    case search
}

final class CategoryProductsRouter {
    weak var view: UIViewController?
    
    func navigate(to route: CategoryProductsRoute, searchInputData: SearchInputData?) {
        switch route {
        case .product:
            print("Product")
        case .search:
            if let inputData = searchInputData {
                let vc = SearchBuilder(inputData: inputData).build()
                vc.modalPresentationStyle = .overFullScreen
                vc.modalTransitionStyle = .crossDissolve
                view?.present(vc, animated: true)
            }
        }
    }
}
