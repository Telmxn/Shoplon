//
//  DependencyContainer.swift
//  Shoplon
//
//  Created by Telman Yusifov on 22.05.25.
//

import Foundation

class DependencyContainer {
    static let shared = DependencyContainer()
    
    lazy var languageManager: LanguageManager = {
        return LanguageManager()
    }()
    
    lazy var firebaseManager: FirebaseManager = {
        return FirebaseManager(service: FirebaseAdapter())
    }()
    
    lazy var userDefaultsManager: UserDefaultsManager = {
        return UserDefaultsManager()
    }()
}
