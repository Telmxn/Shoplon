//
//  BookmarkBuilder.swift
//  Shoplon
//
//  Created by Telman Yusifov on 24.06.25.
//

import UIKit

final class BookmarkBuilder {
    func build() -> UIViewController {
        let router = BookmarkRouter()
        let viewModel = BookmarkViewModel(router: router)
        let vc = BookmarkViewController(viewModel: viewModel)
        router.view = vc
        return vc
    }
}
