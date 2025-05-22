//
//  OnboardingViewModel.swift
//  Shoplon
//
//  Created by Telman Yusifov on 21.05.25.
//

import Foundation

final class OnboardingViewModel {
    private let router: OnboardingRouter
    
    init(router: OnboardingRouter) {
        self.router = router
    }
    
    func navigateToWelcome() {
        router.navigate(to: .welcome)
    }
}
