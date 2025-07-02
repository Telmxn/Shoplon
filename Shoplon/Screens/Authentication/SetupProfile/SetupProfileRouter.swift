//
//  SetupProfileRouter.swift
//  Shoplon
//
//  Created by Telman Yusifov on 20.06.25.
//

import UIKit

enum SetupProfileRoute {
    case verificationCode
}

final class SetupProfileRouter {
    weak var view: UIViewController?
    
    func navigate(to route: SetupProfileRoute, email: String) {
        switch route {
        case .verificationCode:
            let vc = VerificationCodeBuilder(inputData: .init(email: email, isVerified: false)).build()
            view?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
