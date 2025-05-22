//
//  NotificationPermissionRouter.swift
//  Shoplon
//
//  Created by Telman Yusifov on 22.05.25.
//

import UIKit

enum NotificationPermissionRoute {
    case selectLanguage
}

final class NotificationPermissionRouter {
    weak var view: UIViewController?
    
    func navigate(to route: NotificationPermissionRoute) {
        switch route {
        case .selectLanguage:
            let vc = SelectLanguageViewController()
            view?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
