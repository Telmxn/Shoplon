//
//  SelectLanguageBuilder.swift
//  Shoplon
//
//  Created by Telman Yusifov on 21.05.25.
//

import UIKit

final class SelectLanguageBuilder {
    
    func build() -> UIViewController {
        let router = SelectLanguageRouter()
        let viewModel = SelectLanguageViewModel(router: router)
        let vc = SelectLanguageViewController(viewModel: viewModel)
        router.view = vc
        return vc
    }
}
