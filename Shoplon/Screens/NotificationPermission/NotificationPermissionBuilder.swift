//
//  NotificationPermissionBuilder.swift
//  Shoplon
//
//  Created by Telman Yusifov on 22.05.25.
//

import UIKit

final class NotificationPermissionBuilder {
    
    func build() -> UIViewController {
        let router = NotificationPermissionRouter()
        let viewModel = NotificationPermissionViewModel(router: router)
        let vc = NotificationPermissionViewController(viewModel: viewModel)
        router.view = vc
        return vc
    }
}
