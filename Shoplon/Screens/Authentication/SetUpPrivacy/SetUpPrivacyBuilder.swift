//
//  SetUpPrivacyBuilder.swift
//  Shoplon
//
//  Created by Telman Yusifov on 22.06.25.
//

import UIKit

final class SetUpPrivacyBuilder {
    func build() -> UIViewController {
        let router = SetUpPrivacyRouter()
        let viewModel = SetUpPrivacyViewModel(router: router)
        let vc = SetUpPrivacyViewController(viewModel: viewModel)
        router.view = vc
        return vc
    }
}
