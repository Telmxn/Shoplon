//
//  BaseViewModel.swift
//  Shoplon
//
//  Created by Telman Yusifov on 28.05.25.
//

import Foundation
import Combine

class BaseViewModel {
    @Published var isLoading: Bool = false
    @Published var error: Error?
}
