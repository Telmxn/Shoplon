//
//  CategoryProductsBuilder.swift
//  Shoplon
//
//  Created by Telman Yusifov on 27.06.25.
//

import UIKit

final class CategoryProductsBuilder {
    
    private let inputData: CategoryProductsInputData
    
    init(inputData: CategoryProductsInputData) {
        self.inputData = inputData
    }
    
    func build() -> UIViewController {
        let router = CategoryProductsRouter()
        let viewModel = CategoryProductsViewModel(router: router, inputData: inputData)
        let vc = CategoryProductsViewController(viewModel: viewModel)
        router.view = vc
        return vc
    }
}
