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
        router.navigate(to: .login, inputData: nil)
    }
    
    func navigateToVerificationCode(with inputData: VerificationCodeInputData) {
        router.navigate(to: .verificationCode, inputData: inputData)
    }
    
    func sendOTPMail(to email: String, completion: @escaping (Result<Void, Error>) -> Void) {
        isLoading = true
        DependencyContainer.shared.firebaseManager.sendOTP(to: email) { result in
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
