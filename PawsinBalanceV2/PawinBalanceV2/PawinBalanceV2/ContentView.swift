//
//  ContentView.swift
//  PawinBalanceV2
//
//  Created by Cody Van Dyke on 11/16/23.
import SwiftUI

struct ContentView: View {
    
    
    var body: some View {
        VStack {
            
            Text("Paws in Balance")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            
            ScrollView {
                UserInfoForm()
                DogInfoView()
                
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
