//
//  ContentView.swift
//  gymguru
//
//  Created by Milind Contractor on 17/11/23.
//

import SwiftUI
import Forever




struct ContentView: View {
    @State var challengesAvailable = [ChallengeData(challengeName: "Christmas Calorie Loss", challengeDescription: "Lose some calories to consume extra for christmas!", challengeItems: [ExerciseItem(workoutItem: .running, workoutTrackType: .counter, amount: 10)], badges: []),
                                      ChallengeData(challengeName: "Chill Chase", challengeDescription: "Journey at a relaxed pace", challengeItems: [ExerciseItem(workoutItem: .running, workoutTrackType: .counter, amount: 10)], badges: []),
                                      ChallengeData(challengeName: "Sprint Quest", challengeDescription: "For those who enjoy pushing their limits, this is the perfect challenge for them.", challengeItems: [ExerciseItem(workoutItem: .running, workoutTrackType: .counter, amount: 10)], badges: [])]
    @Forever("userdata") var userData: UserInfo = UserInfo(preferredWorkouts: [],
                                                           timeToWorkout: 5.0,
                                                           age: 16.0,
                                                           height: 189.0,
                                                           weight: 90.0,
                                                           name: "Sam",
                                                                     challengeData: [], dailyChallenge: ChallengeData(challengeName: "aff", challengeDescription: "afa", challengeItems: [], badges: []),
                                                           badges: [Badge(badge: "Newbie", sfIcon: "door.left.hand.open", obtainingExercise: .none, amountOfObtainingExercise: 0, obtained: true),
                                                                     Badge(badge: "Cricketer", sfIcon: "figure.cricket", obtainingExercise: .running, amountOfObtainingExercise: 5, obtained: true),
                                                                    Badge(badge: "Xmas 23 Challenge Finisher", sfIcon: "tree.fill", obtainingExercise: .running, amountOfObtainingExercise: 10, obtained: false)],
                                                           exerciseData: [])
    @Forever("showSetupModal") var showSetupModal = false

    
    var body: some View {
        TabView {
            HomeView(selectedWorkout: .none, userData: $userData)
                .tabItem { Label("Home", systemImage: "house.fill") }
            
            BadgesView(userData: $userData)
                .tabItem { Label("Badges", systemImage: "star") }
            
            ChallengesView(userData: $userData)
                .tabItem {
                    Label("Challenges", systemImage: "trophy")
                }
            
            SettingsView(item: $userData, setup: $showSetupModal)
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
            
        }
        .fullScreenCover(isPresented: $showSetupModal) {
            OnboardingView(userData: $userData)
        }
    }
}

#Preview {
    ContentView()
}

