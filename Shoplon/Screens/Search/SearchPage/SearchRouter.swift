//
//  SearchRouter.swift
//  Shoplon
//
//  Created by Telman Yusifov on 08.07.25.
//

import UIKit

enum SearchRoute {
    case recentSearches
    case result
}

final class SearchRouter {
    weak var view: UIViewController?
    
    func navigate(to route: SearchRoute) {
        switch route {
        case .result:
            print("Product")
        case .recentSearches:
            print("Recent Searches")
        }
    }
}
