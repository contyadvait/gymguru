//
//  CounterTrackingView.swift
//  gymguru
//
//  Created by Milind Contractor on 23/11/23.
//

import SwiftUI

struct CounterTrackingView: View {
    @Binding var userData: UserInfo
    @State var amount = 0
    @State var showOnlyPlus = true
    @Namespace var namespace
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
    @Binding var exercise: Exercise
    @State var showAlert = false
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button {
                    showAlert = true
                } label: {
                    Text("Exit")
                }
                .padding(.horizontal, 20)
            }
            Spacer()
            Text(String(amount))
                .font(.system(size: 80))
                .textCase(.uppercase)
                .fontWidth(.expanded)
            Text(exercise.workoutLabel)
                .textCase(.uppercase)
                .fontWidth(.expanded)
            
            HStack {
                if showOnlyPlus {
                    Button {
                        amount += 1
                        withAnimation {
                            showOnlyPlus = false
                        }
                    } label: {
                        Image(systemName: "plus")
                            .frame(width: 30, height: 30)
                    }
                    .buttonStyle(.borderedProminent)
                    .matchedGeometryEffect(id: "Plus", in: namespace)
                } else {
                    Button {
                        amount -= 1
                        if amount == 0 {
                            withAnimation {
                                showOnlyPlus = true
                            }
                        }
                    } label: {
                        Image(systemName: "minus")
                            .frame(width: 30, height: 30)
                    }
                    .buttonStyle(.bordered)
                    
                    Button {
                        amount += 1
                    } label: {
                        Image(systemName: "plus")
                            .frame(width: 30, height: 30)
                    }
                    .buttonStyle(.borderedProminent)
                    .matchedGeometryEffect(id: "Plus", in: namespace)
                }
            }
            .alert("Are you sure you want to end this workout?", isPresented: $showAlert) {
                Button("OK", role: .destructive) {
                    
                    for (challengeIndex, challenge) in userData.challengeData.enumerated() {
                        for (workoutIndex, workout) in challenge.challengeItems.enumerated() {
                            if workout.workoutItem == exercise {
                                userData.challengeData[challengeIndex].challengeItems[workoutIndex].completed += Float(amount)
                            }
                        }
                    }
                    
                    for (dailyChallengeIndex, dailyChallenge) in userData.dailyChallenge.challengeItems.enumerated() {
                        if dailyChallenge.workoutItem == exercise {
                            userData.dailyChallenge.challengeItems[dailyChallengeIndex].completed += Float(amount)
                        }
                    }
                    dismiss()
                }
                
                Button("Cancel", role: .cancel) {  }
            }
            .buttonStyle(.bordered)
            Spacer()
        }
    }
}
