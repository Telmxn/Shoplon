//
//  SelectLanguageViewModel.swift
//  Shoplon
//
//  Created by Telman Yusifov on 21.05.25.
//

import Foundation

final class SelectLanguageViewModel: BaseViewModel {
    private let router: SelectLanguageRouter
    
    init(router: SelectLanguageRouter) {
        self.router = router
    }
    
    func navigateToLogin() {
        router.navigate(to: .login)
    }
}
