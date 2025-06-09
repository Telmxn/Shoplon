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
}
