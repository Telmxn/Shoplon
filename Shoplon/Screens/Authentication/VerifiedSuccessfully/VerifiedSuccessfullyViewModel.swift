//
//  VerifiedSuccessfullyViewModel.swift
//  Shoplon
//
//  Created by Telman Yusifov on 22.06.25.
//

import Foundation
import LocalAuthentication

final class VerifiedSuccessfullyViewModel: BaseViewModel {
    private let router: VerifiedSuccessfullyRouter
    
    init(router: VerifiedSuccessfullyRouter) {
        self.router = router
    }
    
    func navigateToSetPrivacy() {
        let context = LAContext()
        switch context.biometricType {
        case .none:
            router.navigate(to: .home)
        case .touchID:
            router.navigate(to: .setupPrivacy)
        case .faceID:
            router.navigate(to: .setupPrivacy)
        }
        
    }
}
