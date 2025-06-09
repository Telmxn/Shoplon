//
//  PasswordRecoveryRouter.swift
//  Shoplon
//
//  Created by Telman Yusifov on 22.05.25.
//

import UIKit

enum PasswordRecoveryRoute {
    case verificationCode
    case login
}

final class PasswordRecoveryRouter {
    weak var view: UIViewController?
    
    func navigate(to route: PasswordRecoveryRoute, inputData: VerificationCodeInputData?) {
        switch route {
        case .verificationCode:
            let vc = VerificationCodeBuilder(inputData: inputData ?? .init(email: "")).build()
            view?.navigationController?.pushViewController(vc, animated: true)
        case .login:
            view?.navigationController?.popViewController(animated: true)
        }
    }
}
