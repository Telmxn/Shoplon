//
//  DiscoverRouter.swift
//  Shoplon
//
//  Created by Telman Yusifov on 24.06.25.
//

import UIKit

enum DiscoverRoute {
    case category
}

final class DiscoverRouter {
    weak var view: UIViewController?
    
    func navigate(to route: DiscoverRoute) {
        switch route {
        case .category:
            print("Discover")
        }
    }
}
