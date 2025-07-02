//
//  SetupProfileBuilder.swift
//  Shoplon
//
//  Created by Telman Yusifov on 20.06.25.
//

import UIKit

final class SetupProfileBuilder {
    func build() -> UIViewController {
        let router = SetupProfileRouter()
        let viewModel = SetupProfileViewModel(router: router)
        let vc = SetupProfileViewController(viewModel: viewModel)
        router.view = vc
        return vc
    }
}
