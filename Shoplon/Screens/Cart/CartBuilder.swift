//
//  CartBuilder.swift
//  Shoplon
//
//  Created by Telman Yusifov on 24.06.25.
//

import UIKit

final class CartBuilder {
    func build() -> UIViewController {
        let router = CartRouter()
        let viewModel = CartViewModel(router: router)
        let vc = CartViewController(viewModel: viewModel)
        router.view = vc
        return vc
    }
}
