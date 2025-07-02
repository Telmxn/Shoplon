//
//  BrandRouter.swift
//  Shoplon
//
//  Created by Telman Yusifov on 02.07.25.
//


import UIKit

enum BrandRoute {
    case product
    case cart
}

final class BrandRouter {
    weak var view: UIViewController?
    
    func navigate(to route: BrandRoute) {
        switch route {
        case .product:
            view?.navigationController?.popViewController(animated: true)
        case .cart:
            view?.navigationController?.popViewController(animated: true)
        }
    }
}
