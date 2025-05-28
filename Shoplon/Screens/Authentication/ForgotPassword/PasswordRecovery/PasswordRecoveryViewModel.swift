//
//  PasswordRecoveryViewModel.swift
//  Shoplon
//
//  Created by Telman Yusifov on 22.05.25.
//

import Foundation

final class PasswordRecoveryViewModel: BaseViewModel {
    private let router: PasswordRecoveryRouter
    
    init(router: PasswordRecoveryRouter) {
        self.router = router
    }
    
    func navigateToLogin() {
        router.navigate(to: .login)
    }
    
    func navigateToChooseVerificationMethod() {
        router.navigate(to: .chooseVerificationMethod)
    }
}
