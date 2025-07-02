//
//  SetUpPrivacyRouter.swift
//  Shoplon
//
//  Created by Telman Yusifov on 22.06.25.
//

import UIKit

enum SetUpPrivacyRoute {
    case home
}

final class SetUpPrivacyRouter {
    weak var view: UIViewController?
    
    func navigate(to route: SetUpPrivacyRoute) {
        switch route {
        case .home:
            let vc = SignUpBuilder().build()
            view?.navigationController?.setViewControllers([vc], animated: true)
        }
    }
}
