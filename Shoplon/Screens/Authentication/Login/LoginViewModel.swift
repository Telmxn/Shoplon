//
//  LoginViewModel.swift
//  Shoplon
//
//  Created by Telman Yusifov on 22.05.25.
//

import Foundation
import FirebaseAuth
import LocalAuthentication

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
    
    func navigateToHome() {
        router.navigate(to: .home)
    }
    
    func navigateToHomeDirect() {
        let context = LAContext()
        var error: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Please authorize with touch id!"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { [weak self] success, error in
                DispatchQueue.main.async {
                    guard success, error == nil else {
                        return
                    }
                    self?.router.navigate(to: .home)
                }
            }
        }
    }
    
    func login(with email: String, password: String, completion: @escaping (Result<User, Error>) -> ()) {
        isLoading = true
        DependencyContainer.shared.firebaseManager.login(email: email, password: password) { result in
            self.isLoading = false
            switch result {
            case .success(let success):
                DependencyContainer.shared.keychainManager.save(key: .email, value: email)
                completion(.success(success))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
}
