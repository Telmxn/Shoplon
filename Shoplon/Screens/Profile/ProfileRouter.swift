//
//  ProfileRouter.swift
//  Shoplon
//
//  Created by Telman Yusifov on 24.06.25.
//

import UIKit

enum ProfileRoute {
    case orders
    case login
}

final class ProfileRouter {
    weak var view: UIViewController?
    
    func navigate(to route: ProfileRoute) {
        switch route {
        case .orders:
            print("Orders")
        case .login:
            let vc = LoginBuilder().build()
            view?.navigationController?.setViewControllers([vc], animated: true)
        }
    }
}
