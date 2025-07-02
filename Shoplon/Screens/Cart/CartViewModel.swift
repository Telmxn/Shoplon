//
//  CartViewModel.swift
//  Shoplon
//
//  Created by Telman Yusifov on 24.06.25.
//

import Foundation

final class CartViewModel: BaseViewModel {
    private let router: CartRouter
    
    init(router: CartRouter) {
        self.router = router
    }
    
    func navigateToProduct() {
        router.navigate(to: .product)
    }
}
