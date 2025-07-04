//
//  DiscoverViewModel.swift
//  Shoplon
//
//  Created by Telman Yusifov on 24.06.25.
//

import Foundation

final class DiscoverViewModel: BaseViewModel {
    private let router: DiscoverRouter
    
    init(router: DiscoverRouter) {
        self.router = router
    }
    
    func navigateToCategory() {
        router.navigate(to: .category)
    }
    
    func fetchCategories(completion: @escaping (Result<[CategoryModel], Error>) -> ()) {
        isLoading = true
        DependencyContainer.shared.firebaseManager.fetchCategories { result in
            self.isLoading = false
            switch result {
            case .success(let success):
                completion(.success(success))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
}
