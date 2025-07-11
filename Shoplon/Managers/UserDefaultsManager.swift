//
//  UserDefaultsManager.swift
//  Shoplon
//
//  Created by Telman Yusifov on 23.06.25.
//

import Foundation

enum UserDefaultKeys: String {
    case seenOnboarding
    case userLoggedIn
    case haveFaceOrTouchID
    case recentSearches = "RECENT_SEARCHES"
}

final class UserDefaultsManager {
    private let userDefaults: UserDefaults
    
    init() {
        self.userDefaults = UserDefaults.standard
    }
    
    func save(key: UserDefaultKeys, value: Bool) {
        userDefaults.setValue(value, forKey: key.rawValue)
        userDefaults.synchronize()
    }
    
    func save(key: UserDefaultKeys, value: [String]) {
        userDefaults.setValue(value, forKey: key.rawValue)
        userDefaults.synchronize()
    }
    
    func getBoolean(key: UserDefaultKeys) -> Bool {
        return userDefaults.bool(forKey: key.rawValue)
    }
    
    func getStringArray(key: UserDefaultKeys) -> [String] {
        return userDefaults.array(forKey: key.rawValue) as? [String] ?? []
    }
    
    func remove(key: UserDefaultKeys) {
        userDefaults.removeObject(forKey: key.rawValue)
        userDefaults.synchronize()
    }
}
