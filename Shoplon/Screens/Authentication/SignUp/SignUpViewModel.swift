//
//  SignUpViewModel.swift
//  Shoplon
//
//  Created by Telman Yusifov on 17.06.25.
//

import Foundation
import FirebaseAuth

final class SignUpViewModel: BaseViewModel {
    private let router: SignUpRouter
    
    init(router: SignUpRouter) {
        self.router = router
    }
    
    func navigateToLogin() {
        router.navigate(to: .login)
    }
    
    func navigateToTermsOfServices() {
        router.navigate(to: .termsOfService)
    }
    
    func navigateToSetupProfile() {
        router.navigate(to: .setupProfile)
    }
    
    func signUpUser(with email: String, password: String, completion: @escaping (Result<User, Error>) -> ()) {
        isLoading = true
        DependencyContainer.shared.firebaseManager.signUp(email: email, password: password) { result in
            self.isLoading = false
            switch result {
            case .success(let success):
                completion(.success(success))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func signOutUser() {
        DependencyContainer.shared.firebaseManager.logoutUser()
    }
}
