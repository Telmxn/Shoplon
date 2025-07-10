//
//  SearchBuilder.swift
//  Shoplon
//
//  Created by Telman Yusifov on 08.07.25.
//

import UIKit

final class SearchBuilder {
    private let inputData: SearchInputData
    
    init(inputData: SearchInputData) {
        self.inputData = inputData
    }
    
    func build() -> UIViewController {
        let router = SearchRouter()
        let viewModel = SearchViewModel(router: router, inputData: inputData)
        let vc = UINavigationController(rootViewController: SearchViewController(viewModel: viewModel))
        router.view = vc
        
        return vc
    }
}
