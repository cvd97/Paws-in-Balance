//
//  SignInView.swift
//  PawinBalanceV2
//
//  Created by Cody Van Dyke on 11/28/23.
//
import SwiftUI

struct SignInView: View {
    @ObservedObject var authViewModel: AuthViewModel
    var gradient: Array<Color> = [Color(#colorLiteral(red: 0.7294117647, green: 0.4588235294, blue: 1, alpha: 1)), Color(#colorLiteral(red: 0.2235294118, green: 0.07450980392, blue: 0.7215686275, alpha: 1))]
    @State private var email = ""
    @State private var password = ""

    var body: some View {
        VStack {
            TextField("Email", text: $email)
                .frame(width: 340, height: 44)
                .cornerRadius(16)
                .padding(14)
            SecureField("Password", text: $password)
                .frame(width: 340, height: 44)
                .cornerRadius(16)
                .padding(14)
            Button("Sign In") {
                authViewModel.signIn(email: email, password: password) {
                }
            }
            .font(.title2)
            .frame(width: 140, height: 44)
            .background(LinearGradient(gradient: Gradient(colors: gradient), startPoint: .leading, endPoint: .trailing))
            .cornerRadius(16)
            .foregroundColor(.black)
            .padding(14)
            
            Button("Sign Up") {
                authViewModel.signUp(email: email, password: password)
            }
            .font(.title2)
            .frame(width: 140, height: 44)
            .background(LinearGradient(gradient: Gradient(colors: gradient), startPoint: .leading, endPoint: .trailing))
            .cornerRadius(16)
            .foregroundColor(.black)
            .padding(14)
        }
        .padding()
    }
}
