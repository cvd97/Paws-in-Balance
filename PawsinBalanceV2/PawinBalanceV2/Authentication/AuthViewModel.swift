//
//  AuthViewModel.swift
//  PawinBalanceV2
//
//  Created by Cody Van Dyke on 11/28/23.
//
// API SECRET KEY
// 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
//

import SwiftUI

import FirebaseAuth
import FirebaseFirestore

class AuthViewModel: ObservableObject {
    @Published var isAuthenticated = false
    @Published var previousSchedule: String? = nil


    init() {
        isAuthenticated = Auth.auth().currentUser != nil
    }

    // Handles the signin authetication ie checking the text in the username text field and password text field
    func signIn(email: String, password: String, completion: @escaping () -> Void) {
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] _, error in
                if let error = error {
                    print("Sign in failed: \(error.localizedDescription)")
                } else {
                    self?.isAuthenticated = true
                    completion()
                }
            }
        }
    
    // Handles the signup login save the text as a new user
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
    func fetchPreviousSchedule(userId: String) {
            let db = Firestore.firestore()
            db.collection("schedules").document(userId).getDocument { [weak self] document, error in
                if let error = error {
                    print("Error fetching schedule: \(error.localizedDescription)")
                } else if let document = document, document.exists {
                    let data = document.data()
                    let schedule = data?["schedule"] as? String
                    DispatchQueue.main.async {
                        self?.previousSchedule = schedule
                    }
                } else {
                    print("No previous schedule found")
                    DispatchQueue.main.async {
                        self?.previousSchedule = nil
                    }
                }
            }
        }
    }
