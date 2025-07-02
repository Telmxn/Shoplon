//
//  ProductModel.swift
//  Shoplon
//
//  Created by Telman Yusifov on 28.06.25.
//

import Foundation

struct ProductModel {
    let id: String
    let name: String
    let inStock: Bool
    let price: Double
    let rating: Double
    let discount: Double
    let brand: String
    let brandId: String
    let categoryId: String
    let colors: [ColorModel]
    let description: String
    let imageUrls: [String]
    let sizes: [String]
    
    struct ColorModel {
        let hex: String
        let name: String
    }
}
