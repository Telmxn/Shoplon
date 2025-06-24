//
//  DiscoverViewModel.swift
//  Shoplon
//
//  Created by Telman Yusifov on 24.06.25.
//

import Foundation

final class DiscoverViewModel: BaseViewModel {
    private let router: DiscoverRouter
    
    init(router: DiscoverRouter) {
        self.router = router
    }
    
    func navigateToCategory() {
        router.navigate(to: .category)
    }
}
