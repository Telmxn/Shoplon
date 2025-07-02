//
//  SetNewPasswordBuilder.swift
//  Shoplon
//
//  Created by Telman Yusifov on 09.06.25.
//

import UIKit

final class SetNewPasswordBuilder {
    private let inputData: SetNewPasswordInputData
    
    init(inputData: SetNewPasswordInputData) {
        self.inputData = inputData
    }
    
    func build() -> UIViewController {
        let router = SetNewPasswordRouter()
        let viewModel = SetNewPasswordViewModel(router: router, inputData: inputData)
        let vc = SetNewPasswordViewController(viewModel: viewModel)
        router.view = vc
        return vc
    }
}
