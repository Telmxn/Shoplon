//
//  FirebaseAdapter.swift
//  Shoplon
//
//  Created by Telman Yusifov on 28.05.25.
//

import UIKit
import FirebaseAuth
import FirebaseFunctions
import FirebaseFirestore
import FirebaseStorage


class FirebaseAdapter: FirebaseService {
    private let auth = Auth.auth()
    private lazy var functions = Functions.functions()
    private let db = Firestore.firestore()
    
    func login(email: String, password: String, completion: @escaping (Result<User, any Error>) -> Void) {
        auth.signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(.failure(error))
            } else if let user = result?.user {
                completion(.success(user))
            }
        }
    }
    
    func signUp(email: String, password: String, completion: @escaping (Result<User, any Error>) -> Void) {
        auth.createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(.failure(error))
            } else if let user = result?.user {
                completion(.success(user))
            }
        }
    }
    
    func uploadProfileImage(image: UIImage, completion: @escaping (Result<String, any Error>) -> Void) {
        let compressedImage = image.fixedOrientation().resizedToJPEGCompatible()
        
        guard let imageData = compressedImage.jpegData(compressionQuality: 0.75) else {
            let error = NSError(domain: "ImageConversion", code: -1, userInfo: [
                NSLocalizedDescriptionKey: "Image conversion to JPEG failed."
            ])
            completion(.failure(error))
            return
        }
        
        guard let uid = auth.currentUser?.uid else {
            let error = NSError(domain: "FirebaseAuth", code: -1, userInfo: [
                NSLocalizedDescriptionKey: "No authenticated user found."
            ])
            completion(.failure(error))
            return
        }
        
        let ref = Storage.storage().reference().child("profileImages/\(uid).jpg")
        
        ref.putData(imageData, metadata: nil) { _, error in
            if let error = error {
                completion(.failure(error))
            } else {
                ref.downloadURL { url, error in
                    if let error = error {
                        completion(.failure(error))
                    } else if let url = url {
                        completion(.success(url.absoluteString))
                    } else {
                        let error = NSError(domain: "FirebaseStorage", code: -1, userInfo: [
                            NSLocalizedDescriptionKey: "Download URL not available."
                        ])
                        completion(.failure(error))
                    }
                }
            }
        }
    }

    
    func logoutUser() {
        try? auth.signOut()
    }
    
    func isEmailVerified() -> Bool {
        return auth.currentUser?.isEmailVerified ?? false
    }
    
    func sendOTP(to email: String, completion: @escaping (Result<Void, any Error>) -> Void) {
        let data = ["email": email]
        functions.httpsCallable("sendOTP").call(data) { result, error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
    func verifyOTP(email: String, code: String, completion: @escaping (Result<Bool, any Error>) -> Void) {
        let data = ["email": email, "otp": code]
        functions.httpsCallable("verifyOTP").call(data) { result, error in
            if let error = error {
                completion(.failure(error))
            } else if let response = result?.data as? [String: Any],
                        let verified = response["verified"] as? Bool {
                completion(.success(verified))
            } else {
                completion(.success(false))
            }
        }
    }
    
    func resetPassword(email: String, newPassword: String, completion: @escaping (Result<Void, any Error>) -> Void) {
        let data = ["email": email, "newPassword": newPassword]
        functions.httpsCallable("resetPassword").call(data) { result, error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(()))
                }
            }
    }
    
    func saveUserData(uid: String, data: [String : Any], completion: @escaping ((any Error)?) -> Void) {
        db.collection("users").document(uid).setData(data, merge: true, completion: completion)
    }
    
    func fetchUserData(uid: String, completion: @escaping (Result<[String : Any], any Error>) -> Void) {
        db.collection("users").document(uid).getDocument { snapshot, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = snapshot?.data() {
                completion(.success(data))
            } else {
                completion(.failure(NSError(domain: "Firestore", code: -1, userInfo: [NSLocalizedDescriptionKey: "No user data found."])))
            }
        }
    }
    
    func fetchUserData(byEmail email: String, completion: @escaping (Result<[String: Any], Error>) -> Void) {
        db.collection("users")
            .whereField("email", isEqualTo: email)
            .limit(to: 1)
            .getDocuments { snapshot, error in
                if let error = error {
                    completion(.failure(error))
                } else if let document = snapshot?.documents.first {
                    completion(.success(document.data()))
                } else {
                    let error = NSError(domain: "Firestore", code: -1, userInfo: [
                        NSLocalizedDescriptionKey: "No user found with that email."
                    ])
                    completion(.failure(error))
                }
            }
    }

}
