//
//  FirebaseService.swift
//  Shoplon
//
//  Created by Telman Yusifov on 28.05.25.
//

import FirebaseAuth
import UIKit

protocol FirebaseService {
    func login(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void)
    func signUp(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void)
    func uploadProfileImage(image: UIImage, completion: @escaping (Result<String, any Error>) -> Void)
    func logoutUser()
    func isEmailVerified() -> Bool
    func sendOTP(to email: String, completion: @escaping (Result<Void, Error>) -> Void)
    func verifyOTP(email: String, code: String, completion: @escaping (Result<Bool, Error>) -> Void)
    func resetPassword(email: String, newPassword: String, completion: @escaping (Result<Void, Error>) -> Void)
    func saveUserData(uid: String, data: [String: Any], completion: @escaping (Error?) -> Void)
    func fetchUserData(uid: String, completion: @escaping (Result<[String: Any], Error>) -> Void)
    func fetchUserData(byEmail email: String, completion: @escaping (Result<[String: Any], Error>) -> Void)
}
