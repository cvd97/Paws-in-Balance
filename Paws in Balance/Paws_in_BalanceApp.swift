//
//  Paws_in_BalanceApp.swift
//  Paws in Balance
//
//  Created by Cody Van Dyke on 10/18/23.
//
import SwiftUI
import Firebase

@main
struct PawsInBalanceApp: App {
    @StateObject var authViewModel = AuthViewModel()

    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authViewModel)
        }
    }
}
