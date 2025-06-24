//
//  BookmarkViewModel.swift
//  Shoplon
//
//  Created by Telman Yusifov on 24.06.25.
//

import Foundation

final class BookmarkViewModel: BaseViewModel {
    private let router: BookmarkRouter
    
    init(router: BookmarkRouter) {
        self.router = router
    }
    
    func navigateToProduct() {
        router.navigate(to: .product)
    }
}
