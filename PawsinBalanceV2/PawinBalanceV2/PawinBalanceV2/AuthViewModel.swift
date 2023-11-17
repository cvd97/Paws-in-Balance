//
//  AuthViewModel.swift
//  PawinBalanceV2
//
//  Created by Cody Van Dyke on 11/16/23.
//
import FirebaseAuth
import FirebaseFirestore

class AuthViewModel: ObservableObject {
    @Published var isSignedIn = false

    func register(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Registration error: \(error.localizedDescription)")
                return
            }
            self.isSignedIn = true
        }
    }

    func login(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Login error: \(error.localizedDescription)")
                return
            }
            self.isSignedIn = true
        }
    }
    
    func saveUserInfo(userInfo: UserInfo) {
            guard let userID = Auth.auth().currentUser?.uid else { return }
            
            let db = Firestore.firestore()
            db.collection("users").document(userID).setData([
                "work": userInfo.work,
                "physicalStrain": userInfo.physicalStrain,
                "averageHoursADay": userInfo.averageHoursADay,
                "daysOffAWeek": userInfo.daysOffAWeek,
                "age": userInfo.age,
                "relationshipStatus": userInfo.relationshipStatus
            ]) { error in
                if let error = error {
                    print("Error saving user info: \(error)")
                } else {
                    print("User info successfully saved")
                    // Handle successful save, e.g., navigate to another view
                }
            }
        }
}
