//
//  ShopViewModel.swift
//  Shoplon
//
//  Created by Telman Yusifov on 23.06.25.
//

import Foundation

final class ShopViewModel: BaseViewModel {
    private let router: ShopRouter
    
    init(router: ShopRouter) {
        self.router = router
    }
    
    func navigateToProduct() {
        router.navigate(to: .product, categoryInputData: nil, brandInputData: nil)
    }
    
    func navigateToCategory(inputData: CategoryProductsInputData) {
        router.navigate(to: .category, categoryInputData: inputData, brandInputData: nil)
    }
    
    func navigateToBrand(inputData: BrandInputData) {
        router.navigate(to: .brand, categoryInputData: nil, brandInputData: inputData)
    }
    
    func fetchCategories(completion: @escaping (Result<[CategoryModel], Error>) -> ()) {
        isLoading = true
        DependencyContainer.shared.firebaseManager.fetchCategories { result in
            self.isLoading = false
            switch result {
            case .success(let success):
                completion(.success(success))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func fetchProducts(completion: @escaping (Result<[ProductModel], Error>) -> ()) {
        isLoading = true
        DependencyContainer.shared.firebaseManager.fetchProductItems { result in
            self.isLoading = false
            switch result {
            case .success(let success):
                completion(.success(success))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func fetchBrands(completion: @escaping (Result<[BrandModel], Error>) -> ()) {
        isLoading = true
        DependencyContainer.shared.firebaseManager.fetchBrands { result in
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
