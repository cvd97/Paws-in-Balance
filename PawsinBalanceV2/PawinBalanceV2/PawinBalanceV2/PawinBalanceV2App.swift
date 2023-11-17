//
//  PawinBalanceV2App.swift
//  PawinBalanceV2
//
//  Created by Cody Van Dyke on 11/16/23.
//
import SwiftUI
import Firebase

@main
struct PawsInBalanceApp: App {
    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
