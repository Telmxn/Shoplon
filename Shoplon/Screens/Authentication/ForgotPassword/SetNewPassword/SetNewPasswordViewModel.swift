//
//  SetNewPasswordViewModel.swift
//  Shoplon
//
//  Created by Telman Yusifov on 09.06.25.
//

import Foundation

final class SetNewPasswordViewModel: BaseViewModel {
    private let router: SetNewPasswordRouter
    
    private let inputData: SetNewPasswordInputData
    
    init(router: SetNewPasswordRouter, inputData: SetNewPasswordInputData) {
        self.router = router
        self.inputData = inputData
    }
    
    func navigateToSuccess() {
        router.navigate(to: .success)
    }
    
    func changePassword(password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        isLoading = true
        DependencyContainer.shared.firebaseManager.resetPassword(email: inputData.email, newPassword: password) { result in
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
