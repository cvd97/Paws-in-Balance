//
//  ContentView.swift
//  PawinBalanceV2
//
//  Created by Cody Van Dyke on 11/16/23.
import SwiftUI

struct ContentView: View {
    @StateObject var authViewModel = AuthViewModel()

    var body: some View {
        if authViewModel.isAuthenticated {
            VStack {
                
                Text("Paws in Balance")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                
                ScrollView {
                    UserInfoForm()
                    DogInfoView()
                    Button("Logout") {
                                    authViewModel.signOut()
                                }
                                .padding()
                                .background(Color.red)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                    
                }
            }
        }else {
            SignInView(authViewModel: authViewModel)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
