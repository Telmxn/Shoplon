//
//  ProfileViewModel.swift
//  Shoplon
//
//  Created by Telman Yusifov on 24.06.25.
//

import Foundation
import FirebaseAuth

enum ProfileCell {
    case header(ProfileCollectionViewCell.Item)
    case item(ProfileSection)
}

struct ProfileSection {
    let title: String
    let items: [ProfileItemCollectionViewCell.Item]
}

final class ProfileViewModel: BaseViewModel {
    private let router: ProfileRouter
    
    var headerCell: ProfileCollectionViewCell.Item?
    
    var accountCells: [ProfileItemCollectionViewCell.Item] = [
        .init(title: "orders".localized(), leftImage: .orders),
        .init(title: "returns".localized(), leftImage: .returns),
        .init(title: "wishlist".localized(), leftImage: .wishlist),
        .init(title: "addresses".localized(), leftImage: .adresses),
        .init(title: "payment".localized(), leftImage: .payments),
        .init(title: "wallet".localized(), leftImage: .wallet, isLast: true)
    ]
    
    var personalizationCells: [ProfileItemCollectionViewCell.Item] = [
        .init(title: "notification".localized(), leftImage: .notification),
        .init(title: "preferences".localized(), leftImage: .preferences, isLast: true)
    ]
    
    var settingsCells: [ProfileItemCollectionViewCell.Item] = [
        .init(title: "language".localized(), leftImage: .language),
        .init(title: "location".localized(), leftImage: .location, isLast: true)
    ]
    
    var helpSupportCells: [ProfileItemCollectionViewCell.Item] = [
        .init(title: "getHelp".localized(), leftImage: .gethelp),
        .init(title: "faq".localized(), leftImage: .faq, isLast: true)
    ]
    
    var logoutCells: [ProfileItemCollectionViewCell.Item] = [
        .init(title: "logout".localized(), leftImage: .logout, isLogout: true)
    ]
    
    init(router: ProfileRouter) {
        self.router = router
    }
    
    func navigateToOrders() {
        router.navigate(to: .orders)
    }
    
    func fetchData(completion: @escaping (Result<[String: Any], Error>) -> Void) {
        DependencyContainer.shared.firebaseManager.fetchUserData(uid: Auth.auth().currentUser?.uid ?? "") { result in
            switch result {
            case .success(let model):
                self.headerCell = .init(leftImageUrl: model["profileImageURL"] as! String, name: model["fullName"] as! String, email: model["email"] as! String)
                completion(.success(model))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func logout() {
        DependencyContainer.shared.keychainManager.remove(key: .email)
        DependencyContainer.shared.firebaseManager.logoutUser()
        router.navigate(to: .login)
    }
}
