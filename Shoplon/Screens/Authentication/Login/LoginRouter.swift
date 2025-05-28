//
//  LoginRouter.swift
//  Shoplon
//
//  Created by Telman Yusifov on 22.05.25.
//

import UIKit

enum LoginRoute {
    case forgotPassword
    case signUp
}

final class LoginRouter {
    weak var view: UIViewController?
    
    func navigate(to route: LoginRoute) {
        switch route {
        case .forgotPassword:
            let vc = PasswordRecoveryBuilder().build()
            view?.navigationController?.pushViewController(vc, animated: true)
        case .signUp:
            let vc = PasswordRecoveryBuilder().build()
            view?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
