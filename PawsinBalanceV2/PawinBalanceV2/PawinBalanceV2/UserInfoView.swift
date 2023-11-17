//
//  UserInfoView.swift
//  PawinBalanceV2
//
//  Created by Cody Van Dyke on 11/16/23.
//

import SwiftUI

struct UserInfoView: View {
    @State private var userInfo = UserInfo(work: "", physicalStrain: "", averageHoursADay: 0, daysOffAWeek: 0, age: 0, relationshipStatus: "")
    @EnvironmentObject var authViewModel: AuthViewModel // Use EnvironmentObject to access ViewModel

    var body: some View {
        Form {
            TextField("Work", text: $userInfo.work)
            TextField("Physical Strain", text: $userInfo.physicalStrain)
            // Add TextFields for other UserInfo properties

            Button("Save") {
                authViewModel.saveUserInfo(userInfo: userInfo)
            }
        }
    }
}
