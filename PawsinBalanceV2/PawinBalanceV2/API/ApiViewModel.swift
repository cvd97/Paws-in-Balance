//
//  apiUIView.swift
//  PawinBalanceV2
//
//  Created by Cody Van Dyke on 11/28/23.
//
import SwiftUI
import Firebase
import FirebaseFirestore

class ApiViewModel: ObservableObject {
    @Published var generatedText: String = ""
    @Published var previousSchedule: String = ""
    private let openAIService = OpenAIService()
    private var db = Firestore.firestore()
    
    // generate the schdule in the format need to get proper resonse from api
    func generateSchedule(for userString: String, dogString: String) {
        let formattedPrompt = """
    Based on the following details, please create a comprehensive and detailed weekly care schedule for a dog:

    User Information:
    - Free time available: \(userString)

    Dog Information: \(dogString)
    - Name: [Dog's Name]
    - Breed: [Dog's Breed]
    - Age: [Dog's Age]
    - Specific breed characteristics and needs: [Any special needs or characteristics of the breed]

    The schedule should include daily feeding times, exercise sessions, training periods, and other activities suitable for the dog's breed and age. Incorporate activities that would be beneficial for the dog's physical health and mental stimulation.

    Please format the schedule as follows and only return the schedule:
    - Monday:
      - 7:00 AM: Morning feeding
      - [Include other activities with specific times, e.g., 10:00 AM: Walk in the park]
      - 6:00 PM: Evening feeding
      - [Other activities]
    - [Continue with the rest of the week in a similar format]

    Ensure that the activities vary each day to provide a balanced routine for the dog and align with the user's available free time. Activities can include but are not limited to walks, playtime, training sessions, socialization opportunities, and rest periods.
"""
        
        openAIService.generateText(userInput: formattedPrompt) { [weak self] response in
            self?.generatedText = response
        }
    }
    
    // save the schedule to the users account
    func saveScheduleToFirestore(userId: String, schedule: String) {
            let db = Firestore.firestore()
            db.collection("schedules").document(userId).setData(["schedule": schedule]) { error in
                if let error = error {
                    print("Error saving schedule to Firestore: \(error.localizedDescription)")
                } else {
                    print("Schedule successfully saved.")
                }
            }
        }
}

