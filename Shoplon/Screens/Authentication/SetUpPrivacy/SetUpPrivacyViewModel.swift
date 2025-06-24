//
//  SetUpPrivacyViewModel.swift
//  Shoplon
//
//  Created by Telman Yusifov on 22.06.25.
//

import Foundation

final class SetUpPrivacyViewModel: BaseViewModel {
    private let router: SetUpPrivacyRouter
    
    init(router: SetUpPrivacyRouter) {
        self.router = router
    }
    
    func navigateToHome() {
        router.navigate(to: .home)
    }
}
