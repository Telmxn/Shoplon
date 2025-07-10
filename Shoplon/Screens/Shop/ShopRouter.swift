//
//  ShopRouter.swift
//  Shoplon
//
//  Created by Telman Yusifov on 23.06.25.
//

import UIKit

enum ShopRoute {
    case category
    case product
    case brand
}

final class ShopRouter {
    weak var view: UIViewController?
    
    func navigate(to route: ShopRoute, categoryInputData: CategoryProductsInputData?, brandInputData: BrandInputData?) {
        switch route {
        case .category:
            if let inputData = categoryInputData {
                let vc = CategoryProductsBuilder(inputData: inputData).build()
                view?.navigationController?.pushViewController(vc, animated: true)
            }
            
        case .product:
            let vc = SetUpPrivacyBuilder().build()
            view?.navigationController?.setViewControllers([vc], animated: true)
        case .brand:
            if let inputData = brandInputData {
                let vc = BrandBuilder(inputData: inputData).build()
                view?.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}
