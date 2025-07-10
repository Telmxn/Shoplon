//
//  DiscoverRouter.swift
//  Shoplon
//
//  Created by Telman Yusifov on 24.06.25.
//

import UIKit

enum DiscoverRoute {
    case category
    case search
}

final class DiscoverRouter {
    weak var view: UIViewController?
    
    func navigate(to route: DiscoverRoute, categoryInputData: CategoryProductsInputData?, searchInputData: SearchInputData?) {
        switch route {
        case .category:
            if let inputData = categoryInputData {
                let vc = CategoryProductsBuilder(inputData: inputData).build()
                view?.navigationController?.pushViewController(vc, animated: true)
            }
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
