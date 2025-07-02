//
//  ShopRouter.swift
//  Shoplon
//
//  Created by Telman Yusifov on 23.06.25.
//

import UIKit

enum ShopRoute {
    case product
}

final class ShopRouter {
    weak var view: UIViewController?
    
    func navigate(to route: ShopRoute) {
        switch route {
        case .product:
            let vc = SetUpPrivacyBuilder().build()
            view?.navigationController?.setViewControllers([vc], animated: true)
        }
    }
}
