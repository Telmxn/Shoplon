//
//  CategoryProductsViewModel.swift
//  Shoplon
//
//  Created by Telman Yusifov on 27.06.25.
//

import Foundation

final class CategoryProductsViewModel: BaseViewModel {
    private let router: CategoryProductsRouter
    
    private let inputData: CategoryProductsInputData
    
    init(router: CategoryProductsRouter, inputData: CategoryProductsInputData) {
        self.router = router
        self.inputData = inputData
    }
    
    func navigateToProduct() {
        router.navigate(to: .product)
    }
    
    func fetchCategoryProducts() {
        
    }
}
