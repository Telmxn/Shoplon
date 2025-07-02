//
//  VerifiedSuccessfullyViewModel.swift
//  Shoplon
//
//  Created by Telman Yusifov on 22.06.25.
//

import Foundation

final class VerifiedSuccessfullyViewModel: BaseViewModel {
    private let router: VerifiedSuccessfullyRouter
    
    init(router: VerifiedSuccessfullyRouter) {
        self.router = router
    }
    
    func navigateToSetPrivacy() {
        router.navigate(to: .setupPrivacy)
    }
}
