//
//  SignUpBuilder.swift
//  Shoplon
//
//  Created by Telman Yusifov on 17.06.25.
//

import UIKit

final class SignUpBuilder {
    func build() -> UIViewController {
        let router = SignUpRouter()
        let viewModel = SignUpViewModel(router: router)
        let vc = SignUpViewController(viewModel: viewModel)
        router.view = vc
        return vc
    }
}
