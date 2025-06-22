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
            let vc = SignUpBuilder().build()
            vc.modalPresentationStyle = .overFullScreen
            view?.present(vc, animated: true)
        }
    }
}
