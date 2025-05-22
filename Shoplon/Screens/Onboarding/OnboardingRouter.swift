//
//  OnboardingRouter.swift
//  Shoplon
//
//  Created by Telman Yusifov on 21.05.25.
//

import UIKit

enum OnboardingRoute {
    case welcome
}

final class OnboardingRouter {
    weak var view: UIViewController?
    
    func navigate(to route: OnboardingRoute) {
        switch route {
        case .welcome:
            let vc = SelectLanguageViewController()
            view?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
