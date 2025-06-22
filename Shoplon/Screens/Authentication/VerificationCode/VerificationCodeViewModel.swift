//
//  VerificationCodeViewModel.swift
//  Shoplon
//
//  Created by Telman Yusifov on 29.05.25.
//

import Foundation

final class VerificationCodeViewModel: BaseViewModel {
    private let router: VerificationCodeRouter
    
    private let inputData: VerificationCodeInputData
    
    init(inputData: VerificationCodeInputData, router: VerificationCodeRouter) {
        self.inputData = inputData
        self.router = router
    }
    
    func navigateToPasswordRecovery() {
        router.navigate(to: .passwordRecovery, inputData: nil)
    }
    
    func navigateToSetNewPassword() {
        router.navigate(to: .setNewPassword, inputData: .init(email: inputData.email))
    }
    
    func navigateToVerifiedSuccessfully() {
        router.navigate(to: .successfullVerification, inputData: nil)
    }
    
    func navigateToRegister() {
        router.navigate(to: .register, inputData: nil)
    }
    
    func fetchInputData(completion: (VerificationCodeInputData)->()) {
        completion(inputData)
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
    
    func verifyOTP(email: String, code: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        isLoading = true
        DependencyContainer.shared.firebaseManager.verifyOTP(email: email, code: code) { result in
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
