//
//  SearchRouter.swift
//  Shoplon
//
//  Created by Telman Yusifov on 08.07.25.
//

import UIKit

enum SearchRoute {
    case recentSearches
    case filter
}

final class SearchRouter {
    weak var view: UIViewController?
    
    func navigate(to route: SearchRoute, filterInputData: FilterInputData?) {
        switch route {
        case .recentSearches:
            print("Recent Searches")
        case .filter:
            if let inputData = filterInputData {
                let vc = FilterBuilder(inputData: inputData).build()
                self.view?.present(vc, animated: true)
            }
        }
    }
}
