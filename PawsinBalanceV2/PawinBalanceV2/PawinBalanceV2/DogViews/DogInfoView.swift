//
//  DogInfoView.swift
//  PawinBalanceV2
//
//  Created by Cody Van Dyke on 11/21/23.
//
import SwiftUI

struct DogInfoView: View {
    @State private var dogData = DogData()
    @State private var dogDataPhrase = ""
    @State private var isFormPresented = true
    var gradient: Array<Color> = [Color(#colorLiteral(red: 0.7294117647, green: 0.4588235294, blue: 1, alpha: 1)), Color(#colorLiteral(red: 0.2235294118, green: 0.07450980392, blue: 0.7215686275, alpha: 1))]
    
    @State var isTapped = false
    
    var body: some View {
        TimelineView(.animation) { context in
            layout
                .frame(maxWidth: 393)
                .dynamicTypeSize(.xSmall ... .xLarge)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.vertical, 10)
                .background(.blue.opacity(0.001))
            
        }
    }
    
    var layout: some View {
        VStack {
            add
                .frame(width: isTapped ? 300 : 80 )
                .frame(height: isTapped ? nil : 80)
                .foregroundStyle(.primary, .white)
                .padding(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .strokeBorder(linearGradient)
                )
                .cornerRadius(20)
        }
    }
    
    var linearGradient: LinearGradient {
        LinearGradient(colors: [.clear, .primary.opacity(0.5), Color(#colorLiteral(red: 0.7294117647, green: 0.4588235294, blue: 1, alpha: 1))], startPoint: .topLeading, endPoint: .bottomTrailing)
    }
    
    
    var add: some View {
        VStack(spacing: 10) {
            Image(systemName: isTapped ? "dog" : "plus.diamond.fill")
                .frame(width: 54)
                .frame(height: 54)
                .background(LinearGradient(gradient: Gradient(colors: gradient), startPoint: .leading, endPoint: .trailing))
                .cornerRadius(16)
                .foregroundColor(.white)
                .onTapGesture {
                    withAnimation(.bouncy) {
                        isTapped.toggle()
                        
                    }
                }
            
            if isTapped {
                if isFormPresented {
                    Form {
                        Section(
                            header: Text("Puppy Information")
                                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                
                        ) {
                            TextField("Name", text: $dogData.name)
                                .padding(10)
                            TextField("Age", text: $dogData.age)
                                .padding(10)
                            TextField("Breed", text: $dogData.breed)
                                .padding(10)
                            TextField("Weight in lbs", text: $dogData.weight)
                                .padding(10)
                            TextField("Food Amount", text: $dogData.foodAmount)
                                .padding(10)
                            TextField("Food Frequency", text: $dogData.foodFrequency)
                                .padding(10)
                        }
                        Button("Save") {
                            dogDataPhrase = formatDogDataPhrase(dogData: dogData)
                            isFormPresented = false // Close form
                            // Additional actions like saving to database can be added here
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
                } else {
                    VStack {
                        Text(dogDataPhrase)
                        Button("Edit") {
                            isFormPresented = true
                        }
                    }
                }
            }
        }
    }
}

private func formatDogDataPhrase(dogData: DogData) -> String {
    
    var dogPhrase: String = "Name: \(dogData.name) Age: \(dogData.age) Breed \(dogData.breed) Weight of \(dogData.weight) Amount of food \(dogData.foodAmount) Feeding Frequency \(dogData.foodFrequency) "
    
    
    return dogPhrase
}
#Preview {
    DogInfoView()
}
