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
}

final class VerificationCodeRouter {
    weak var view: UIViewController?
    
    func navigate(to route: VerificationCodeRoute) {
        switch route {
        case .passwordRecovery:
            view?.navigationController?.popViewController(animated: true)
        case .setNewPassword:
            view?.navigationController?.popViewController(animated: true)
        }
    }
}
