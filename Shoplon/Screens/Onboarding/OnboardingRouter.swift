//
//  OnboardingRouter.swift
//  Shoplon
//
//  Created by Telman Yusifov on 21.05.25.
//

import UIKit

enum OnboardingRoute {
    case notificationPermission
}

final class OnboardingRouter {
    weak var view: UIViewController?
    
    func navigate(to route: OnboardingRoute) {
        switch route {
        case .notificationPermission:
            let vc = NotificationPermissionBuilder().build()
            view?.navigationController?.setViewControllers([vc], animated: true)
        }
    }
}
