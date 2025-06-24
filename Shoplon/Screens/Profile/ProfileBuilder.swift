//
//  ProfileBuilder.swift
//  Shoplon
//
//  Created by Telman Yusifov on 24.06.25.
//

import UIKit

final class ProfileBuilder {
    func build() -> UIViewController {
        let router = ProfileRouter()
        let viewModel = ProfileViewModel(router: router)
        let vc = ProfileViewController(viewModel: viewModel)
        router.view = vc
        return vc
    }
}
