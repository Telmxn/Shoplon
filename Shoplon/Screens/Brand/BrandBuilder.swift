//
//  BrandBuilder.swift
//  Shoplon
//
//  Created by Telman Yusifov on 02.07.25.
//

import UIKit

final class BrandBuilder {
    private let inputData: BrandInputData
    
    init(inputData: BrandInputData) {
        self.inputData = inputData
    }
    
    func build() -> UIViewController {
        let router = BrandRouter()
        let viewModel = BrandViewModel(router: router, inputData: inputData)
        let vc = BrandViewController(viewModel: viewModel)
        router.view = vc
        return vc
    }
}
