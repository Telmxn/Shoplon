//
//  BrandViewModel.swift
//  Shoplon
//
//  Created by Telman Yusifov on 02.07.25.
//

import Foundation

final class BrandViewModel: BaseViewModel {
    private let router: BrandRouter
    
    private let inputData: BrandInputData
    
    init(router: BrandRouter, inputData: BrandInputData) {
        self.router = router
        self.inputData = inputData
    }
    
    func navigateToProduct() {
        router.navigate(to: .product)
    }
    
    func navigateToCart() {
        router.navigate(to: .cart)
    }
    
    func fetchBrand(completion: @escaping (Result<BrandModel, Error>) -> ()) {
        isLoading = true
        DependencyContainer.shared.firebaseManager.fetchBrand(brandId: inputData.brandId) { result in
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
