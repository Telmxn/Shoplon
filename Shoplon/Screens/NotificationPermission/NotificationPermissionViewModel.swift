//
//  NotificationPermissionViewModel.swift
//  Shoplon
//
//  Created by Telman Yusifov on 22.05.25.
//

import Foundation

final class NotificationPermissionViewModel: BaseViewModel {
    private let router: NotificationPermissionRouter
    
    init(router: NotificationPermissionRouter) {
        self.router = router
    }
    
    func navigateToLanguageSelector() {
        router.navigate(to: .selectLanguage)
    }
}
