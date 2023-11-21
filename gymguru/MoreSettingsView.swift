//
//  MoreSettingsView.swift
//  gymguru
//
//  Created by Milind Contractor on 21/11/23.
//

import SwiftUI
import CompactSlider

struct MoreSettingsView: View {
    @Binding var userData: UserInfo
    var body: some View {
        VStack {
            HStack {
                Text("More User Settings")
                    .font(.title)
                Spacer()
                Button {
                    
                } label: {
                    
                }
            }
            .padding()
        }
        .ignoresSafeArea()
    }
}

#Preview {
    MoreSettingsView(userData: .constant(UserInfo(preferredWorkouts: [], timeToWorkout: 0.5, age: 10, height: 150, weight: 75, name: "Sean", challengeData: [])))
}
