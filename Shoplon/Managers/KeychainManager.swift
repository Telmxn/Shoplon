//
//  KeychainManager.swift
//  Shoplon
//
//  Created by Telman Yusifov on 11.07.25.
//

import Foundation
import KeychainSwift

enum KeychainKeys: String {
    case email
}

final class KeychainManager {
    private let keychain: KeychainSwift
    
    init() {
        keychain = KeychainSwift()
    }
    
    func save(key: KeychainKeys, value: String) {
        keychain.set(value, forKey: key.rawValue)
    }
    
    func getString(key: KeychainKeys) -> String {
        return keychain.get(key.rawValue) ?? ""
    }
    
    func remove(key: UserDefaultKeys) {
        keychain.delete(key.rawValue)
    }
}
