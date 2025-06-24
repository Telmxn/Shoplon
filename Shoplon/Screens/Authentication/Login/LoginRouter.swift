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
    case home
}

final class LoginRouter {
    weak var view: UIViewController?
    
    func navigate(to route: LoginRoute) {
        switch route {
        case .forgotPassword:
            let vc = PasswordRecoveryBuilder().build()
            view?.navigationController?.pushViewController(vc, animated: true)
        case .signUp:
            let vc = SignUpBuilder().build()
            view?.navigationController?.setViewControllers([vc], animated: true)
        case .home:
            let tabBar = BaseTabBarController()
            view?.navigationController?.setViewControllers([tabBar], animated: true)
        }
    }
}
