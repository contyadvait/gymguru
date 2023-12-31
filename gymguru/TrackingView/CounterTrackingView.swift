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
    @State var crash = false
    
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
                    var workoutsFinished = 0
                    
                    for (challengeIndex, challenge) in userData.challengeData.enumerated() {
                        for (workoutIndex, workout) in challenge.challengeItems.enumerated() {
                            if workout.workoutItem == exercise {
                                let checkItem = userData.challengeData[challengeIndex].challengeItems[workoutIndex].completed + Float(amount)
                                userData.challengeData[challengeIndex].challengeItems[workoutIndex].completed = Float(checkItem)
                            }
                            
                            if workout.completed >= workout.amount {
                                for (badgeIndex, badge) in challenge.badges.enumerated() {
                                    userData.badges.append(badge)
                                }
                                for (badgeIndex, badge) in userData.badges.enumerated() {
                                    userData.badges[badgeIndex].obtained = true
                                }
                            }
                        }
                    }
                    
                    for (dailyChallengeIndex, dailyChallenge) in userData.dailyChallenge.challengeItems.enumerated() {
                        if dailyChallenge.workoutItem == exercise {
                            userData.dailyChallenge.challengeItems[dailyChallengeIndex].completed += Float(amount)
                        }
                        if dailyChallenge.amount <= dailyChallenge.completed {
                            for badge in userData.dailyChallenge.badges {
                                userData.badges.append(badge)
                            }
                        }
                    }
                    
                    for (badgeIndex, badge) in userData.badges.enumerated() {
                        userData.badges[badgeIndex].obtained = true
                    }
                    
                    
                    dismiss()
                }
                
                Button("Cancel", role: .cancel) {  }
            }
            .alert("This app will crash to successfully record your progress. Please re-launch the app once you leave it", isPresented: $crash) {
                Button("OK", role: .cancel) { exit(0) }
            }
            .buttonStyle(.bordered)
            Spacer()
        }
    }
}
