//
//  ContentView.swift
//  gymguru
//
//  Created by Milind Contractor on 17/11/23.
//

import SwiftUI
import Forever

struct ContentView: View {
    @Forever("userdata") var userData: UserInfo = UserInfo(preferredWorkouts: [],
                                                           timeToWorkout: 5.0,
                                                           age: 16.0,
                                                           height: 189.0,
                                                           weight: 90.0,
                                                           name: "Sam",
                                                                     challengeData: [], dailyChallenge: ChallengeData(challengeName: "aff", challengeDescription: "afa", challengeItems: [], badges: []),
                                                           badges: [Badge(badge: "Newbie", sfIcon: "door.left.hand.open", obtainingExercise: .none, amountOfObtainingExercise: 0, obtained: true),
                                                                     Badge(badge: "Cricketer", sfIcon: "figure.cricket", obtainingExercise: .burpee, amountOfObtainingExercise: 5, obtained: true),
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

