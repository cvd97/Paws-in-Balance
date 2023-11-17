import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isRegistering: Bool = false

    var body: some View {
        if authViewModel.isSignedIn {
            MainView()
        } else {
            VStack {
                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                if isRegistering {
                    Button("Register") {
                        authViewModel.signUp(email: email, password: password)
                    }
                } else {
                    Button("Login") {
                        authViewModel.signIn(email: email, password: password)
                    }

                    Button("Register") {
                        isRegistering = true
                    }
                }
            }
            .padding()
        }
    }
}

struct MainView: View {
    var body: some View {
        Text("Welcome to Paws in Balance")
    }
}

