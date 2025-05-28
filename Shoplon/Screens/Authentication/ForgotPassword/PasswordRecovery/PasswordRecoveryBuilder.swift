//
//  PasswordRecoveryBuilder.swift
//  Shoplon
//
//  Created by Telman Yusifov on 22.05.25.
//

import UIKit

class PasswordRecoveryBuilder {
    
    func build() -> UIViewController {
        let router = PasswordRecoveryRouter()
        let viewModel = PasswordRecoveryViewModel(router: router)
        let vc = PasswordRecoveryViewController(viewModel: viewModel)
        router.view = vc
        return vc
    }
    
}
