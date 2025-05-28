//
//  LoginViewModel.swift
//  Shoplon
//
//  Created by Telman Yusifov on 22.05.25.
//

import Foundation

final class LoginViewModel: BaseViewModel {
    private let router: LoginRouter
    
    init(router: LoginRouter) {
        self.router = router
    }
    
    func navigateToForgotPassword() {
        router.navigate(to: .forgotPassword)
    }
    
    func navigateToSignUp() {
        router.navigate(to: .signUp)
    }
}
