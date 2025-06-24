//
//  ShopBuilder.swift
//  Shoplon
//
//  Created by Telman Yusifov on 23.06.25.
//

import UIKit

final class ShopBuilder {
    func build() -> UIViewController {
        let router = ShopRouter()
        let viewModel = ShopViewModel(router: router)
        let vc = ShopViewController(viewModel: viewModel)
        router.view = vc
        return vc
    }
}
