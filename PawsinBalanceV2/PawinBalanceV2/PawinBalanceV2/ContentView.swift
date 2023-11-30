//
//  ContentView.swift
//  PawinBalanceV2
//
//  Created by Cody Van Dyke on 11/16/23.
import SwiftUI
import FirebaseAuth

struct ContentView: View {
    @StateObject var authViewModel = AuthViewModel()
    @StateObject var apiViewModel = ApiViewModel()
    @State private var userDataPhrase: String = ""
    @State private var dogDataPhrase: String = ""
    @State private var showPreviousSchedule = false
    
    var gradient: Array<Color> = [Color(#colorLiteral(red: 0.7294117647, green: 0.4588235294, blue: 1, alpha: 1)), Color(#colorLiteral(red: 0.2235294118, green: 0.07450980392, blue: 0.7215686275, alpha: 1))]
    
    @State var isTapped = false
    @State var isTappedTrash = false
    
    var body: some View {
        if authViewModel.isAuthenticated {
            VStack {
                
                Text("Paws in Balance")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                
                ScrollView {
                    UserInfoForm(userDataPhrase: $userDataPhrase)
                    DogInfoView(dogDataPhrase: $dogDataPhrase)
                    
                    // Check if a previous schedule exists and display it
                    if !apiViewModel.generatedText.isEmpty {
                        VStack {
                            Text(apiViewModel.generatedText)
                                .padding()
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(10)
                            Image(systemName: isTappedTrash ? "trash" : "trash.fill")
                                .frame(width: 84)
                                .frame(height: 84)
                                .background(LinearGradient(gradient: Gradient(colors: gradient), startPoint: .leading, endPoint: .trailing))
                                .cornerRadius(16)
                                .foregroundColor(.white)
                                .padding(20)
                            .onTapGesture {
                                withAnimation(.bouncy) {
                                    isTappedTrash.toggle()
                                    apiViewModel.generatedText.removeAll()
                                }
                            }
                        }
                    }
                    
    
                    
                    if !showPreviousSchedule {
                        Button("Generate Schedule") {
                            apiViewModel.generateSchedule(for: userDataPhrase, dogString: dogDataPhrase)
                            isTapped = true
                        }
                        .font(.title2)
                        .frame(width: 340, height: 84)
                        .background(LinearGradient(gradient: Gradient(colors: gradient), startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(16)
                        .foregroundColor(.black)
                        .padding(.bottom, 80)
                    } else {
                        Text("Prompt sent to API:")
                            .font(.headline)
                            .padding(.top, 20)
                        Text("User information: \(userDataPhrase), Dog information: \(dogDataPhrase)")
                            .padding()
                        Text("API Response:")
                            .font(.headline)
                            .padding(.top, 20)
                        Text(apiViewModel.generatedText)
                            .padding()
                    }
                    
                    if isTapped {
                        Button("Save Schedule") {
                            if let userId = Auth.auth().currentUser?.uid {
                                apiViewModel.saveScheduleToFirestore(userId: userId, schedule: apiViewModel.generatedText)
                            }
                        }
                        .font(.title2)
                        .frame(width: 340, height: 84)
                        .background(LinearGradient(gradient: Gradient(colors: gradient), startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(16)
                        .foregroundColor(.black)
                        .padding(.bottom, 80)
                    }
                    
                    
                    Button("Logout") {
                        authViewModel.signOut()
                    }
                    .font(.title2)
                    .frame(width: 140)
                    .frame(height: 84)
                    .background(LinearGradient(gradient: Gradient(colors: [Color(.red), Color(.white), Color(.red)]), startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(16)
                    .foregroundColor(.black)
                    
                }
            }
            .onAppear {
                if let userId = Auth.auth().currentUser?.uid {
                    apiViewModel.fetchPreviousSchedule(userId: userId)
                }
            }
            .padding(20)
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
