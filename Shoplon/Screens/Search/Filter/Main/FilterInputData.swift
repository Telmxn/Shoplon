//
//  FilterInputData.swift
//  Shoplon
//
//  Created by Telman Yusifov on 11.07.25.
//

import Foundation

enum SortBy: String, CaseIterable {
    case priceLowToHigh = "priceLowToHigh"
    case priceHightToLow = "priceHighToLow"
    case new = "new"
    case highestRated = "highestRated"
    case az = "A-Z"
    case za = "Z-A"
}

struct FilterInputData {
    var isAvailableInStock: Bool
    var colors: [String]
    var size: [String]
    var brands: [String]
    var minPrice: Double
    var maxPrice: Double
    var sortBy: SortBy
}
