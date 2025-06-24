//
//  ProfileViewModel.swift
//  Shoplon
//
//  Created by Telman Yusifov on 24.06.25.
//

import Foundation

final class ProfileViewModel: BaseViewModel {
    private let router: ProfileRouter
    
    init(router: ProfileRouter) {
        self.router = router
    }
    
    func navigateToOrders() {
        router.navigate(to: .orders)
    }
}
