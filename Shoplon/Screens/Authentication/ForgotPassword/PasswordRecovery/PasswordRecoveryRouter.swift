//
//  PasswordRecoveryRouter.swift
//  Shoplon
//
//  Created by Telman Yusifov on 22.05.25.
//

import UIKit

enum PasswordRecoveryRoute {
    case chooseVerificationMethod
    case login
}

final class PasswordRecoveryRouter {
    weak var view: UIViewController?
    
    func navigate(to route: PasswordRecoveryRoute) {
        switch route {
        case .chooseVerificationMethod:
            let vc = LoginBuilder().build()
            view?.navigationController?.setViewControllers([vc], animated: true)
        case .login:
            view?.navigationController?.popViewController(animated: true)
        }
    }
}
