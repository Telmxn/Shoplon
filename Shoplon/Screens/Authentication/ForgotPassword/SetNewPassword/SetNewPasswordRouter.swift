//
//  SetNewPasswordRouter.swift
//  Shoplon
//
//  Created by Telman Yusifov on 09.06.25.
//

import UIKit

enum SetNewPasswordRoute {
    case success
}

final class SetNewPasswordRouter {
    weak var view: UIViewController?
    
    func navigate(to route: SetNewPasswordRoute) {
        switch route {
        case .success:
            let vc = LoginBuilder().build()
            view?.navigationController?.setViewControllers([vc], animated: true)
        }
    }
}
