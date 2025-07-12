//
//  SearchViewModel.swift
//  Shoplon
//
//  Created by Telman Yusifov on 08.07.25.
//

import Foundation

final class SearchViewModel: BaseViewModel {
    private let router: SearchRouter
    
    private let inputData: SearchInputData
    
    init(router: SearchRouter, inputData: SearchInputData) {
        self.router = router
        self.inputData = inputData
    }
    
    func navigateToRecentSearches() {
        router.navigate(to: .recentSearches, filterInputData: nil)
    }
    
    func showFilter(inputData: FilterInputData) {
        router.navigate(to: .filter, filterInputData: inputData)
    }
    
    func fetchProductTitles(completion: @escaping (Result<[ProductModel], Error>) -> ()) {
        DependencyContainer.shared.firebaseManager.fetchProductItems { result in
            switch result {
            case .success(let success):
                completion(.success(success))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
}
