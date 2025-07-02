//
//  SetupProfileViewModel.swift
//  Shoplon
//
//  Created by Telman Yusifov on 20.06.25.
//

import UIKit
import FirebaseAuth
import FirebaseCore

final class SetupProfileViewModel: BaseViewModel {
    
    private let router: SetupProfileRouter
    
    init(router: SetupProfileRouter) {
        self.router = router
    }
    
    func navigateToVerificationCode() {
        router.navigate(to: .verificationCode, email: Auth.auth().currentUser?.email ?? "")
    }
    
    func saveUserData(fullName: String?, dateOfBirth: Date, image: UIImage?) {
        isLoading = true
        DependencyContainer.shared.firebaseManager.uploadProfileImage(image: image ?? .placeholder) { result in
            switch result {
            case .success(let success):
                let data: [String: Any] = [
                    "fullName": fullName ?? "",
                    "email": Auth.auth().currentUser?.email ?? "",
                    "dob": Timestamp(date: dateOfBirth),
                    "profileImageURL": success,
                    "isVerified": false
                ]
                DependencyContainer.shared.firebaseManager.saveUserData(uid: Auth.auth().currentUser?.uid ?? "No-user-id", data: data) { error in
                    self.isLoading = false
                    if let error = error {
                        print("Error while saving user data:",error)
                    }
                    self.sendOTPMail(to: Auth.auth().currentUser?.email ?? "")
                    self.navigateToVerificationCode()
                }
            case .failure(let failure):
                self.isLoading = false
                print("Failure:", failure.localizedDescription)
            }
        }
    }
    
    func sendOTPMail(to email: String) {
        isLoading = true
        DependencyContainer.shared.firebaseManager.sendOTP(to: email) { result in
            self.isLoading = false
        }
    }
}
