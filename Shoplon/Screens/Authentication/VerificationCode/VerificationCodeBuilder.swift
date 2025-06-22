//
//  VerificationCodeBuilder.swift
//  Shoplon
//
//  Created by Telman Yusifov on 29.05.25.
//

import UIKit

final class VerificationCodeBuilder {
    private let inputData: VerificationCodeInputData
    
    init(inputData: VerificationCodeInputData) {
        self.inputData = inputData
    }
    
    func build() -> UIViewController {
        let router = VerificationCodeRouter()
        let viewModel = VerificationCodeViewModel(inputData: inputData, router: router)
        let vc = VerificationCodeViewController(viewModel: viewModel)
        router.view = vc
        return vc
    }
}
