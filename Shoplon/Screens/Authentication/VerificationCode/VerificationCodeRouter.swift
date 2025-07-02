//
//  VerificationCodeRouter.swift
//  Shoplon
//
//  Created by Telman Yusifov on 29.05.25.
//

import UIKit

enum VerificationCodeRoute {
    case passwordRecovery
    case setNewPassword
    case successfullVerification
    case register
}

final class VerificationCodeRouter {
    weak var view: UIViewController?
    
    func navigate(to route: VerificationCodeRoute, inputData: SetNewPasswordInputData?) {
        switch route {
        case .passwordRecovery:
            view?.navigationController?.popViewController(animated: true)
        case .setNewPassword:
            let vc = SetNewPasswordBuilder(inputData: inputData ?? .init(email: "")).build()
            view?.navigationController?.pushViewController(vc, animated: true)
        case .successfullVerification:
            let vc = VerifiedSuccessfullyBuilder().build()
            view?.navigationController?.setViewControllers([vc], animated: true)
        case .register:
            let vc = SignUpBuilder().build()
            view?.navigationController?.setViewControllers([vc], animated: true)
        }
    }
}
