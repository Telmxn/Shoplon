//
//  BrandInMapViewModel.swift
//  Shoplon
//
//  Created by Telman Yusifov on 07.07.25.
//

import Foundation

final class BrandInMapViewModel: BaseViewModel {
    private let inputData: BrandInMapInputData
    
    init(inputData: BrandInMapInputData) {
        self.inputData = inputData
    }
    
    func fetchData() -> BrandInMapInputData {
        return inputData
    }
}
