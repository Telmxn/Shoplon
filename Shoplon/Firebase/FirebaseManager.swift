//
//  FirebaseManager.swift
//  Shoplon
//
//  Created by Telman Yusifov on 28.05.25.
//

import Foundation
import FirebaseAuth
import UIKit

class FirebaseManager {
    private let service: FirebaseService
    
    init(service: FirebaseService) {
        self.service = service
    }
    
    func login(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        service.login(email: email, password: password, completion: completion)
    }
    
    func signUp(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        service.signUp(email: email, password: password, completion: completion)
    }
    
    func uploadProfileImage(image: UIImage, completion: @escaping (Result<String, any Error>) -> Void) {
        service.uploadProfileImage(image: image, completion: completion)
    }
    
    func logoutUser() {
        service.logoutUser()
    }
    
    func isEmailVerified() -> Bool {
        service.isEmailVerified()
    }
    
    func sendOTP(to email: String, completion: @escaping (Result<Void, Error>) -> Void) {
        service.sendOTP(to: email, completion: completion)
    }
    
    func verifyOTP(email: String, code: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        service.verifyOTP(email: email, code: code, completion: completion)
    }
    
    func resetPassword(email: String, newPassword: String, completion: @escaping (Result<Void, Error>) -> Void) {
        service.resetPassword(email: email, newPassword: newPassword, completion: completion)
    }
    
    func saveUserData(uid: String, data: [String: Any], completion: @escaping (Error?) -> Void) {
        service.saveUserData(uid: uid, data: data, completion: completion)
    }
    
    func fetchUserData(uid: String, completion: @escaping (Result<[String: Any], Error>) -> Void) {
        service.fetchUserData(uid: uid, completion: completion)
    }
    
    func fetchUserData(byEmail email: String, completion: @escaping (Result<[String: Any], Error>) -> Void) {
        service.fetchUserData(byEmail: email, completion: completion)
    }
    
    func fetchCategories(completion: @escaping (Result<[CategoryModel], Error>) -> Void) {
        service.fetchCategories(completion: completion)
    }
}
