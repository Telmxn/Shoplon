//
//  BrandInMapBuilder.swift
//  Shoplon
//
//  Created by Telman Yusifov on 07.07.25.
//

import UIKit

final class BrandInMapBuilder {
    private let inputData: BrandInMapInputData
    
    init(inputData: BrandInMapInputData) {
        self.inputData = inputData
    }
    
    func build() -> UIViewController {
        let viewModel = BrandInMapViewModel(inputData: inputData)
        let vc = BrandInMapViewController(viewModel: viewModel)
        return vc
    }
}
