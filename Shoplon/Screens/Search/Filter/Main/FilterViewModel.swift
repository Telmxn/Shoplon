//
//  FilterViewModel.swift
//  Shoplon
//
//  Created by Telman Yusifov on 11.07.25.
//

import Foundation

final class FilterViewModel: BaseViewModel {
    private let inputData: FilterInputData
    
    private let router: FilterRouter
    
    @Published var productColors: [ProductModel.ColorModel: Int] = [:]
    
    @Published var productSizes: [String: Int] = [:]
    
    @Published var productBrands: [String: Int] = [:]
    
    @Published var productPrices: [String: Int] = [
        "0-25": 0, "25-50": 0, "50-100": 0, "100-200": 0, "200-300": 0, "300-1000": 0
    ]
    
    @Published var products: [ProductModel] = []
    
    init(inputData: FilterInputData, router: FilterRouter) {
        self.inputData = inputData
        self.router = router
    }
    
    func fetchProducts() {
        DependencyContainer.shared.firebaseManager.fetchProductItems { result in
            switch result {
            case .success(let products):
                self.products = products
            case .failure(let failure):
                self.error = failure
            }
        }
    }
    
    func fetchProductColors() {
        for product in products {
            for color in product.colors {
                let colorCount = self.productColors[color] ?? 0
                self.productColors.updateValue(colorCount + 1, forKey: color)
            }
        }
    }
    
    func fetchProductSizes() {
        for product in products {
            for size in product.sizes {
                let sizeCount = self.productSizes[size] ?? 0
                self.productSizes.updateValue(sizeCount + 1, forKey: size)
            }
        }
    }
    
    func fetchProductBrands() {
        for product in products {
            let brandCount = self.productBrands[product.brand] ?? 0
            self.productBrands.updateValue(brandCount + 1, forKey: product.brand)
        }
    }
    
    func fetchProductPrices() {
        for product in products {
            for price in productPrices.keys {
                let minPrice = Double(price.split(separator: "-")[0])
                let maxPrice = Double(price.split(separator: "-")[1])
                let productPrice = Double(product.price - (product.price * (product.discount * 0.01)))
                if productPrice >= minPrice! && productPrice <= maxPrice! {
                    let priceCount = self.productPrices[price] ?? 0
                    self.productPrices.updateValue(priceCount + 1, forKey: price)
                }
            }
        }
    }
}
