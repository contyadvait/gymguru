//
//  ContentView.swift
//  gymguru
//
//  Created by Milind Contractor on 17/11/23.
//

import SwiftUI
import Forever

struct ContentView: View {
    @State var challengesAvailable = [ChallengeData(challengeName: "Stroll Stride", challengeDescription: "Go for a leisure walk for a few kilometers. You can walk around greenery, or walk around your city.", challengeItems: [ExerciseItem(workoutItem: .walk, workoutTrackType: .map, amount: 5)], badges: []),
                                      ChallengeData(challengeName: "Chill Chase", challengeDescription: "Journey at a relaxed pace", challengeItems: [ExerciseItem(workoutItem: .jogging, workoutTrackType: .map, amount: 10)], badges: []),
                                      ChallengeData(challengeName: "Sprint Quest", challengeDescription: "For those who enjoy pushing their limits, this is the perfect challenge for them.", challengeItems: [ExerciseItem(workoutItem: .running, workoutTrackType: .map, amount: 10)], badges: []),
                                      ChallengeData(challengeName: "BlitzDash", challengeDescription: "Take a quick run for about 1 kilometer.", challengeItems: [ExerciseItem(workoutItem: .running, workoutTrackType: .map, amount: 1)], badges: []),
                                      ChallengeData(challengeName: "Star Leaps", challengeDescription: "Complete the allocated number of jumping jacks.", challengeItems: [ExerciseItem(workoutItem: .jumpingJacks, workoutTrackType: .counter, amount: 40)], badges: []),
                                      ChallengeData(challengeName: "Burpee Burst", challengeDescription: "Complete the allocated number of burpees.", challengeItems: [ExerciseItem(workoutItem: .burpee, workoutTrackType: .counter, amount: 15)], badges: []),
                                      ChallengeData(challengeName: "Jump&Joy", challengeDescription: "Jump for joy as you jumprope!", challengeItems: [ExerciseItem(workoutItem: .jumpRope, workoutTrackType: .counter, amount: 50)], badges: []),
                                      ChallengeData(challengeName: "Summit Champion", challengeDescription: "This challenge is designed for people with a passion for hiking and conquering high peaks.", challengeItems: [ExerciseItem(workoutItem: .hiking, workoutTrackType: .map, amount: 3)], badges: []),
                                      ChallengeData(challengeName: "Sprint Quest", challengeDescription: "For those who enjoy pushing their limits, this is the perfect challenge for them.", challengeItems: [ExerciseItem(workoutItem: .running, workoutTrackType: .map, amount: 10)], badges: []),
                                      ChallengeData(challengeName: "CycleQuest", challengeDescription: "This challenge is great for cycling enthusiasts", challengeItems: [ExerciseItem(workoutItem: .cycling, workoutTrackType: .map, amount: 6)], badges: []),
                                      ChallengeData(challengeName: "Peak Pursuit", challengeDescription: "[Higher-Level]Hiking experts can take up this challenge as it requires high levels of endurance.", challengeItems: [ExerciseItem(workoutItem: .hiking, workoutTrackType: .map, amount: 10)], badges: []),
                                      ChallengeData(challengeName: "Step Saga", challengeDescription: "[Higher-Level]This puts your endurance to the test. Remember, try not taking breaks at all and complete this challenge in one shot!", challengeItems: [ExerciseItem(workoutItem: .walk, workoutTrackType: .map, amount: 15)], badges: []),
                                      ChallengeData(challengeName: "Ultimate Jog Adventure", challengeDescription: "[Higher-Level]This will push the boundaries of your jogging limits!", challengeItems: [ExerciseItem(workoutItem: .jogging, workoutTrackType: .counter, amount: 15)], badges: []),
                                      ChallengeData(challengeName: "APEX Cycling", challengeDescription: "[Higher-Level] This challenge ensures that your cycling endurance is tested to its maximum!", challengeItems: [ExerciseItem(workoutItem: .cycling, workoutTrackType: .map, amount: 12)], badges: []),
                                      ChallengeData(challengeName: "Xtreme Dash!", challengeDescription: "[Higher-Level] This dash is indeed extreme!", challengeItems: [ExerciseItem(workoutItem: .running, workoutTrackType: .map, amount: 20)], badges: []),
                                      ChallengeData(challengeName: "JumpJack Juggernaut", challengeDescription: "[Higher-Level] Surpass your capabilities in doing jumping jacks, by completing this challenge! ", challengeItems: [ExerciseItem(workoutItem: .jumpingJacks, workoutTrackType: .counter, amount: 75)], badges: []),
                                      ChallengeData(challengeName: "Elevated Leap", challengeDescription: "[Higher-Level] Defy gravity and jump new heights!", challengeItems: [ExerciseItem(workoutItem: .jumpRope, workoutTrackType: .counter, amount: 10)], badges: []),
                                      ChallengeData(challengeName: "Burpee Mastery", challengeDescription: "[Higher-Level] Become a master at burpees!", challengeItems: [ExerciseItem(workoutItem: .burpee, workoutTrackType: .counter, amount: 30)], badges: []),]
    @Forever("userdata") var userData: UserInfo = UserInfo(preferredWorkouts: [],
                                                           timeToWorkout: 5.0,
                                                           age: 16.0,
                                                           height: 189.0,
                                                           weight: 90.0,
                                                           name: "Sam",
                                                           challengeData: [], dailyChallenge: ChallengeData(challengeName: "aff", challengeDescription: "afa", challengeItems: [], badges: []),
                                                           badges: [Badge(badge: "Newbie", sfIcon: "door.left.hand.open", obtainingExercise: .cycling, amountOfObtainingExercise: 0, obtained: true),
                                                                    Badge(badge: "Cricketer", sfIcon: "figure.cricket", obtainingExercise: .running, amountOfObtainingExercise: 5, obtained: true),
                                                                    Badge(badge: "Xmas 23 Challenge Finisher", sfIcon: "tree.fill", obtainingExercise: .running, amountOfObtainingExercise: 10, obtained: false)],
                                                           exerciseData: [])
    @Forever("showSetupModal") var showSetupModal = false
    @AppStorage("challengeStreak") var challengeStreak = 30
    @AppStorage("lastUpdatedDate") var lastUpdatedDate: String = ""
    let challengeManager = ChallengeManager()
    
    
    var body: some View {
        TabView {
            HomeView(selectedWorkout: .cycling, userData: $userData, challengeStreak: $challengeStreak)
                .tabItem { Label("Home", systemImage: "house.fill") }
            
            BadgesView(userData: $userData, currentChallenges: $challengesAvailable)
                .tabItem { Label("Badges", systemImage: "star") }
            
            ChallengesView(userData: $userData, currentChallenges: $challengesAvailable)
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
        .onAppear {
            let currentDate = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            
            print(lastUpdatedDate)
            
            let dateString = dateFormatter.string(from: currentDate)
            
            if lastUpdatedDate == "" {
                lastUpdatedDate = dateString
                print("Found blank, overwriting now")
            }
            let dateNow = Date()
            if lastUpdatedDate != dateFormatter.string(from: dateNow) {
                print(lastUpdatedDate)
                print(dateFormatter.string(from: dateNow))
                userData.dailyChallenge = challengeManager.reRoll(userData: userData, challengeStreak: challengeStreak)
                lastUpdatedDate = dateFormatter.string(from: dateNow)
            }
            if challengeStreak == 30 {
                challengeStreak = 0
            }
        }
    }
}

#Preview {
    ContentView()
}

