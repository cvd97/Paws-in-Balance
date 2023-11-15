//
//  Paws_in_BalanceApp.swift
//  Paws in Balance
//
//  Created by Cody Van Dyke on 10/18/23.
//

import SwiftUI

import Firebase

@main
struct Paws_in_BalanceApp: App {
    
    let persistenceController = PersistenceController.shared
    

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
