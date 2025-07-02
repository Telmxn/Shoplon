//
//  SelectLanguageRouter.swift
//  Shoplon
//
//  Created by Telman Yusifov on 21.05.25.
//

import UIKit

enum SelectLanguageRoute {
    case login
}

final class SelectLanguageRouter {
    weak var view: UIViewController?
    
    func navigate(to route: SelectLanguageRoute) {
        switch route {
        case .login:
            let vc = LoginBuilder().build()
            view?.navigationController?.setViewControllers([vc], animated: true)
        }
    }
}
