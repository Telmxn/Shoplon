//
//  ProfileRouter.swift
//  Shoplon
//
//  Created by Telman Yusifov on 24.06.25.
//

import UIKit

enum ProfileRoute {
    case orders
}

final class ProfileRouter {
    weak var view: UIViewController?
    
    func navigate(to route: ProfileRoute) {
        switch route {
        case .orders:
            print("Orders")
        }
    }
}
