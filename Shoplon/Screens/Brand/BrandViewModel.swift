//
//  BrandViewModel.swift
//  Shoplon
//
//  Created by Telman Yusifov on 02.07.25.
//

import Foundation

final class BrandViewModel: BaseViewModel {
    
    @Published var brand: BrandModel?
    
    @Published var products: [ProductCollectionViewCell.Item] = []
    
    private let router: BrandRouter
    
    private let inputData: BrandInputData
    
    init(router: BrandRouter, inputData: BrandInputData) {
        self.router = router
        self.inputData = inputData
    }
    
    func navigateToProduct() {
        router.navigate(to: .product, mapInputData: nil, searchInputData: nil)
    }
    
    func navigateToCart() {
        router.navigate(to: .cart, mapInputData: nil, searchInputData: nil)
    }
    
    func navigateToMap(inputData: BrandInMapInputData) {
        router.navigate(to: .map, mapInputData: inputData, searchInputData: nil)
    }
    
    func showSearch(inputData: SearchInputData) {
        router.navigate(to: .search, mapInputData: nil, searchInputData: inputData)
    }
    
    func fetchBrand() {
        isLoading = true
        DependencyContainer.shared.firebaseManager.fetchBrand(brandId: inputData.brandId) { result in
            self.isLoading = false
            switch result {
            case .success(let brandModel):
                self.brand = brandModel
            case .failure(let failure):
                self.error = failure
            }
        }
    }
    
    func fetchBrandProducts() {
        isLoading = true
        DependencyContainer.shared.firebaseManager.fetchProductsForBrand(brandId: inputData.brandId) { result in
            switch result {
            case .success(let products):
                let productItems: [ProductCollectionViewCell.Item] = products.map { product in
                        .init(name: product.name, price: product.price, discount: product.discount, brand: product.brand, imageUrl: product.imageUrls.first ?? "")
                }
                self.products = productItems
            case .failure(let failure):
                self.error = failure
            }
        }
    }
}
