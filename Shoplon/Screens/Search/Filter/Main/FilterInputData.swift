//
//  FilterInputData.swift
//  Shoplon
//
//  Created by Telman Yusifov on 11.07.25.
//

import Foundation

enum SortBy: String {
    case priceLowToHigh = "priceLowToHigh"
    case priceHightToLow = "priceHighToLow"
    case new = "new"
    case highestRated = "highestRated"
    case az = "A-Z"
    case za = "Z-A"
}

struct FilterInputData {
    let isAvailableInStock: Bool
    let colors: [String]
    let size: [String]
    let brand: [String]
    let minPrice: Double
    let maxPrice: Double
    let sortBy: SortBy
}
