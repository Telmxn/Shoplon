//
//  ShopViewModel.swift
//  Shoplon
//
//  Created by Telman Yusifov on 23.06.25.
//

import Foundation

final class ShopViewModel: BaseViewModel {
    private let router: ShopRouter
    
    init(router: ShopRouter) {
        self.router = router
    }
    
    func navigateToProduct() {
        router.navigate(to: .product)
    }
}
