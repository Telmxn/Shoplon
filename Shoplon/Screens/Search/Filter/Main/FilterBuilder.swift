//
//  FilterBuilder.swift
//  Shoplon
//
//  Created by Telman Yusifov on 11.07.25.
//

import UIKit

final class FilterBuilder {
    
    private let inputData: FilterInputData
    
    init(inputData: FilterInputData) {
        self.inputData = inputData
    }
    
    func build() -> UIViewController {
        let router = FilterRouter()
        let viewModel = FilterViewModel(inputData: inputData, router: router)
        let vc = FilterViewController(viewModel: viewModel)
        let navVc = UINavigationController(rootViewController: vc)
        router.view = vc
        return navVc
    }
}
