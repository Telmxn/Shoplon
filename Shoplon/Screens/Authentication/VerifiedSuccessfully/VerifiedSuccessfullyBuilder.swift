//
//  VerifiedSuccessfullyBuilder.swift
//  Shoplon
//
//  Created by Telman Yusifov on 22.06.25.
//

import UIKit

final class VerifiedSuccessfullyBuilder {
    func build() -> UIViewController {
        let router = VerifiedSuccessfullyRouter()
        let viewModel = VerifiedSuccessfullyViewModel(router: router)
        let vc = VerifiedSuccessfullyViewController(viewModel: viewModel)
        router.view = vc
        return vc
    }
}
