//
//  AuthViewModel.swift
//  PawinBalanceV2
//
//  Created by Cody Van Dyke on 11/28/23.
//

import SwiftUI

import FirebaseAuth

class AuthViewModel: ObservableObject {
    @Published var isAuthenticated = false

    init() {
        isAuthenticated = Auth.auth().currentUser != nil
    }

    func signIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] _, error in
            if let error = error {
                print("Sign in failed: \(error.localizedDescription)")
            } else {
                self?.isAuthenticated = true
            }
        }
    }

    func signUp(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] _, error in
            if let error = error {
                print("Sign up failed: \(error.localizedDescription)")
            } else {
                self?.isAuthenticated = true
            }
        }
    }
    
    func signOut() {
            do {
                try Auth.auth().signOut()
                isAuthenticated = false
            } catch let signOutError as NSError {
                print("Error signing out: %@", signOutError)
            }
        }
}
