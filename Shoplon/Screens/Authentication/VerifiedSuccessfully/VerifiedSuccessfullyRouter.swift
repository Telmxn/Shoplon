//
//  VerifiedSuccessfullyRouter.swift
//  Shoplon
//
//  Created by Telman Yusifov on 22.06.25.
//

import UIKit

enum VerifiedSuccessfullyRoute {
    case setupPrivacy
}

final class VerifiedSuccessfullyRouter {
    weak var view: UIViewController?
    
    func navigate(to route: VerifiedSuccessfullyRoute) {
        switch route {
        case .setupPrivacy:
            let vc = SetUpPrivacyBuilder().build()
            view?.navigationController?.setViewControllers([vc], animated: true)
        }
    }
}
