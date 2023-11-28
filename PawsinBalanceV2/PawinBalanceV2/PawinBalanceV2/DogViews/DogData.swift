//
//  DogData.swift
//  PawinBalanceV2
//
//  Created by Cody Van Dyke on 11/21/23.
//

import Foundation

struct DogData: Identifiable, Codable {
    var id = UUID()
    var name: String = ""
    var breed: String = ""
    var age: String = ""
    var weight: String = ""
    var medication: String = ""
    var foodAmount: String = ""
    var foodFrequency: String = ""
}
