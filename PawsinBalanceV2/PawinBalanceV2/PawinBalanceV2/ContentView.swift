//
//  ContentView.swift
//  PawinBalanceV2
//
//  Created by Cody Van Dyke on 11/16/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var authViewModel = AuthViewModel()

    var body: some View {
        if authViewModel.isSignedIn {
            UserInfoView().environmentObject(authViewModel)
        } else {
            SignInView(authViewModel: authViewModel)
        }
    }
}

