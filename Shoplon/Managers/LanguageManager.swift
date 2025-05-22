//
//  LanguageManager.swift
//  Shoplon
//
//  Created by Telman Yusifov on 22.05.25.
//

import Foundation

enum Language: String {
    case az = "az"
    case en = "en"
    case tr = "tr"
    case ru = "ru"
    
    var title: String {
        switch self {
        case .az:
            return "Azərbaycanca"
        case .en:
            return "English"
        case .tr:
            return "Türkçe"
        case .ru:
            return "Русский"
        }
    }
}

class LanguageManager {
    private let applicationLanguageKey = "selectedLanguage"
    
    var delegate: LanguageManagerProtocol? = nil
    
    func change(language: String) {
        UserDefaults.standard.setValue(language, forKey: applicationLanguageKey)
        delegate?.didChangeLanguage()
    }
    
    func get() -> String {
        if let currentLanguage = UserDefaults.standard.value(forKey: applicationLanguageKey) as? String {
            return currentLanguage
        }
        return Language.az.rawValue
    }
}

protocol LanguageManagerProtocol {
    func didChangeLanguage()
}
