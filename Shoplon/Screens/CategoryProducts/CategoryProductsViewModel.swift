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
    
    func fetchCategoryProducts(completion: @escaping (Result<[ProductModel], Error>) -> ()) {
        isLoading = true
        DependencyContainer.shared.firebaseManager.fetchProductsForCategory(categoryId: inputData.categoryId) { result in
            self.isLoading = false
            switch result {
            case .success(let success):
                completion(.success(success))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
}
