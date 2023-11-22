//
//  ContentView.swift
//  gymguru
//
//  Created by Milind Contractor on 17/11/23.
//

import SwiftUI
import Forever

struct ContentView: View {
    @Forever("userdata") var userData: UserInfo = UserInfo(preferredWorkouts: [], timeToWorkout: 5.0, age: 16.0, height: 189.0, weight: 90.0, name: "Sam", challengeData: [], badges: [], exerciseData: [:])
    @Forever("showSetupModal") var showSetupModal = true

    
    var body: some View {
        TabView {
            HomeView()
                .tabItem { Label("Home", systemImage: "house.fill") }
            
            List {
                Text("Welcome back, \(userData.name)!")
                Text("You have \(userData.timeToWorkout) hr to workout everyday")
                Text("You are \(userData.weight) kg heavy")
                Text("You are \(userData.height) cm tall")
                Text("You are \(userData.age) years old")
            }
            .navigationTitle("Home")
            .tabItem { Label("Debug", systemImage: "ladybug") }
            
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

