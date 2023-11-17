//
//  SignInView.swift
//  PawinBalanceV2
//
//  Created by Cody Van Dyke on 11/16/23.
//

import SwiftUI

struct SignInView: View {
    @StateObject var authViewModel = AuthViewModel()
    @State private var email = ""
    @State private var password = ""

    var body: some View {
        VStack {
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
                .keyboardType(.emailAddress)

            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            Button("Sign In") {
                authViewModel.login(email: email, password: password)
            }

            Button("Register") {
                authViewModel.register(email: email, password: password)
            }
        }
        .padding()
    }
}
