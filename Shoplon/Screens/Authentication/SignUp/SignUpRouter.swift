//
//  SignUpRouter.swift
//  Shoplon
//
//  Created by Telman Yusifov on 17.06.25.
//

import UIKit

enum SignUpRoute {
    case termsOfService
    case login
    case setupProfile
}

final class SignUpRouter {
    weak var view: UIViewController?
    
    func navigate(to route: SignUpRoute) {
        switch route {
        case .termsOfService:
            let vc = TermsOfServicesViewController()
            view?.navigationController?.pushViewController(vc, animated: true)
        case .login:
            let vc = LoginBuilder().build()
            view?.navigationController?.setViewControllers([vc], animated: true)
        case .setupProfile:
            let vc = SetupProfileBuilder().build()
            view?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
