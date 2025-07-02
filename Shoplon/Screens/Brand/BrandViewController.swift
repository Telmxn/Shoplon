//
//  BrandViewController.swift
//  Shoplon
//
//  Created by Telman Yusifov on 02.07.25.
//

import UIKit

final class BrandViewController: BaseViewController<BrandViewModel> {
    
    private var brand: BrandModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hidesBottomBarWhenPushed = true
        
        viewModel.fetchBrand { result in
            switch result {
            case .success(let brand):
                self.brand = brand
                print(brand)
            case .failure(let failure):
                self.showErrorAlertAction(message: failure.localizedDescription)
            }
        }
    }
    
    override func bindViewModel() {
        super.bindViewModel()
    }
}
