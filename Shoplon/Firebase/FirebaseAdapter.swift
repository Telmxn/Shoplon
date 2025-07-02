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
import MapKit


class FirebaseAdapter: FirebaseService {
    private let auth = Auth.auth()
    private lazy var functions = Functions.functions()
    private let db = Firestore.firestore()
    
    func login(email: String, password: String, completion: @escaping (Result<User, any Error>) -> Void) {
        auth.signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(.failure(error))
            } else if let user = result?.user {
                DependencyContainer.shared.userDefaultsManager.save(key: .userLoggedIn, value: true)
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
    
    func fetchCategories(completion: @escaping (Result<[CategoryModel], Error>) -> Void) {
        db.collection("categories").getDocuments { (querySnapshot, error) in
            if let error = error {
                completion(.failure(error))
            } else if let snapshot = querySnapshot {
                let categories: [CategoryModel] = snapshot.documents.map { document in
                    let data = document.data()
                    return .init(id: document.documentID, name: data["name"] as! String, imageUrl: data["imageUrl"] as! String, iconUrl: data["iconUrl"] as! String)
                }
                completion(.success(categories))
            }
        }
    }
    
    func fetchBrands(completion: @escaping (Result<[BrandModel], Error>) -> Void) {
        db.collection("brands").getDocuments { querySnapshot, error in
            if let error = error {
                completion(.failure(error))
            } else if let snapshot = querySnapshot {
                let brands: [BrandModel] = snapshot.documents.map { document in
                    let data = document.data()
                    let location = data["location"] as! GeoPoint
                    return .init(id: document.documentID, name: data["name"] as! String, logoUrl: data["logoUrl"] as! String, description: data["description"] as! String, location: .init(latitude: location.latitude, longitude: location.longitude))
                }
                completion(.success(brands))
            }
        }
    }
    
    func fetchBrand(brandId: String, completion: @escaping (Result<BrandModel, Error>) -> Void) {
        let docRef = db.collection("brands").document(brandId)
        docRef.getDocument { documentSnapShot, error in
            if let error = error {
                completion(.failure(error))
            } else if let snapshot = documentSnapShot {
                let data = snapshot.data()
                let location = data?["location"] as? GeoPoint
                if let location = location {
                    completion(.success(.init(id: snapshot.documentID, name: data?["name"] as! String, logoUrl: data?["logoUrl"] as! String, description: data?["description"] as! String, location: .init(latitude: location.latitude, longitude: location.longitude))))
                }
            }
        }
    }
    
    func fetchProductItems(completion: @escaping (Result<[ProductModel], Error>) -> Void) {
        db.collection("products").getDocuments {
            querySnapshot,
            error in
            if let error = error {
                completion(.failure(error))
                print("Error getting documents: \(error)")
            } else if let snapshot = querySnapshot {
                let products: [ProductModel] = snapshot.documents.compactMap { document in
                    let data = document.data()
                    
                    guard let name = data["name"] as? String,
                        let inStock = data["inStock"] as? Bool,
                        let price = data["price"] as? Double,
                        let rating = data["rating"] as? Double,
                        let discount = data["discount"] as? Double,
                        let brand = data["brand"] as? String,
                        let brandId = data["brandId"] as? String,
                        let categoryId = data["categoryId"] as? String,
                        let description = data["description"] as? String,
                        let imageUrls = data["imageUrls"] as? [String],
                        let sizes = data["sizes"] as? [String]
                    else {
                        print("Error: Missing or incorrect data in document with ID: \(document.documentID)")
                        return nil
                    }
                    
                    guard let colorsArray = data["colors"] as? [[String: String]] else {
                        print("Error: Colors data is missing or of incorrect format")
                        return nil
                    }
                    
                    let colors = colorsArray.compactMap { colorDict -> ProductModel.ColorModel? in
                        guard let hex = colorDict["hex"],
                            let name = colorDict["name"] else {
                                print("Error: Missing color data")
                                return nil
                            }
                        return ProductModel.ColorModel(hex: hex, name: name)
                    }
                    
                    return .init(id: document.documentID, name: name, inStock: inStock, price: price, rating: rating, discount: discount, brand: brand, brandId: brandId, categoryId: categoryId, colors: colors, description: description, imageUrls: imageUrls, sizes: sizes)
                }
                completion(.success(products))
            }
        }
    }

}
