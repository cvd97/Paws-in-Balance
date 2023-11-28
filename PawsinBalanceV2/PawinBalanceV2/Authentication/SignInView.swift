//
//  SignInView.swift
//  PawinBalanceV2
//
//  Created by Cody Van Dyke on 11/28/23.
//
import SwiftUI

struct SignInView: View {
    @ObservedObject var authViewModel: AuthViewModel
    @State private var email = ""
    @State private var password = ""

    var body: some View {
        VStack {
            TextField("Email", text: $email)
            SecureField("Password", text: $password)
            Button("Sign In") {
                authViewModel.signIn(email: email, password: password)
            }
            Button("Sign Up") {
                authViewModel.signUp(email: email, password: password)
            }
        }
        .padding()
    }
}
