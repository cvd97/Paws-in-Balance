//
//  AuthViewModel.swift
//  Paws in Balance
//
//  Created by Cody Van Dyke on 11/15/23.
//

import SwiftUI
import FirebaseAuth

class AuthViewModel: ObservableObject {
    @Published var isSignedIn = false

    // Sign in with email and password
    func signIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            self?.isSignedIn = true
        }
    }

    // Sign up with email and password
    func signUp(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            self?.isSignedIn = true
        }
    }
}
