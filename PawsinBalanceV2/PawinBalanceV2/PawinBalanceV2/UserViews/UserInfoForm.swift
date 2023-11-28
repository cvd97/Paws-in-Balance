//
//  UserInfoView.swift
//  PawinBalanceV2
//
//  Created by Cody Van Dyke on 11/21/23.
//

import SwiftUI

struct UserInfoForm: View {
    @State private var userData = UserData()
    @State private var userDataPhrase = ""
    @State private var isFormPresented = true
    var gradient: Array<Color> = [Color(#colorLiteral(red: 0.7294117647, green: 0.4588235294, blue: 1, alpha: 1)), Color(#colorLiteral(red: 0.2235294118, green: 0.07450980392, blue: 0.7215686275, alpha: 1))]
    
    
    var body: some View {
        if isFormPresented {
            Form {
                Section(header: Text("Personal Information")) {
                    TextField("Name", text: $userData.name)
                        .padding(10)
                    TextField("Age", text: $userData.age)
                        .padding(10)
                    TextField("Number of Dogs", text: $userData.numberOfDogs)
                        .padding(10)
                    TextField("Job Title", text: $userData.jobTitle)
                        .padding(10)
                    TextField("Hours worked per week", text: $userData.averageHours)
                        .padding(10)
                    Button("Save") {
                        userDataPhrase = formatUserDataPhrase(userData: userData)
                        isFormPresented = false // Close form
                        // Additional actions like saving to database can be added here
                    }
                    
                }
            }.frame(width: 300 )
                .frame(height: 440)
                .foregroundStyle(.primary, .white)
                .padding(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .strokeBorder(linearGradient)
                )
                .cornerRadius(20)
        }else {
            VStack {
                Text(userDataPhrase)
                Button("Edit") {
                    isFormPresented = true
                }
            }
        }
    }
}

private func formatUserDataPhrase(userData: UserData) -> String {
    return "Name: \(userData.name), Age: \(userData.age), Dogs: \(userData.numberOfDogs), Job: \(userData.jobTitle), Hours: \(userData.averageHours), Shift: \(userData.shift)"
}
var linearGradient: LinearGradient {
    LinearGradient(colors: [.clear, .primary.opacity(0.5), Color(#colorLiteral(red: 0.7294117647, green: 0.4588235294, blue: 1, alpha: 1))], startPoint: .topLeading, endPoint: .bottomTrailing)
}

struct UserInfoForm_Previews: PreviewProvider {
    static var previews: some View {
        UserInfoForm()
    }
}
