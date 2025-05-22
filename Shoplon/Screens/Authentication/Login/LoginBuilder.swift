//
//  LoginBuilder.swift
//  Shoplon
//
//  Created by Telman Yusifov on 22.05.25.
//

import UIKit

class LoginBuilder {
    func build() -> UIViewController {
        let router = LoginRouter()
        let viewModel = LoginViewModel(router: router)
        let vc = LoginViewController(viewModel: viewModel)
        router.view = vc
        return vc
    }
}
