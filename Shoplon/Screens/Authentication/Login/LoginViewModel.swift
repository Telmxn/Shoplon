//
//  LoginViewModel.swift
//  Shoplon
//
//  Created by Telman Yusifov on 22.05.25.
//

import Foundation
import FirebaseAuth

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
    
    func login(with email: String, password: String, completion: @escaping (Result<User, Error>) -> ()) {
        isLoading = true
        DependencyContainer.shared.firebaseManager.login(email: email, password: password) { result in
            self.isLoading = false
            switch result {
            case .success(let success):
                completion(.success(success))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
}
