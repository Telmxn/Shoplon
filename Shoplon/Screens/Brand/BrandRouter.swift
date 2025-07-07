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
    case map
}

final class BrandRouter {
    weak var view: UIViewController?
    
    func navigate(to route: BrandRoute, mapInputData: BrandInMapInputData?) {
        switch route {
        case .product:
            view?.navigationController?.popViewController(animated: true)
        case .cart:
            view?.navigationController?.popViewController(animated: true)
        case .map:
            let vc = BrandInMapBuilder(inputData: mapInputData ?? .init(name: "", coordinates: .init(latitude: 0, longitude: 0))).build()
            view?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
