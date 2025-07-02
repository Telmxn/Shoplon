//
//  String+Localize.swift
//  Shoplon
//
//  Created by Telman Yusifov on 22.05.25.
//

import Foundation

extension String {
    func localized() -> String {
        if let path = Bundle.main.path(forResource: DependencyContainer.shared.languageManager.get(), ofType: "lproj"),
           let bundle = Bundle(path: path) {
            return NSLocalizedString(self, bundle: bundle, comment: "")
        }
        return self
    }
}
