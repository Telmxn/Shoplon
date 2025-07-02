//
//  DiscoverBuilder.swift
//  Shoplon
//
//  Created by Telman Yusifov on 24.06.25.
//

import UIKit

final class DiscoverBuilder {
    func build() -> UIViewController {
        let router = DiscoverRouter()
        let viewModel = DiscoverViewModel(router: router)
        let vc = DiscoverViewController(viewModel: viewModel)
        router.view = vc
        return vc
    }
}
