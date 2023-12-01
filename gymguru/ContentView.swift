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
                                      ChallengeData(challengeName: "Chill Chase", challengeDescription: "Journey at a relaxed pace", challengeItems: [ExerciseItem(workoutItem: .jogging, workoutTrackType: .map, amount: 5)], badges: [Badge(badge: "Chill Chaser", sfIcon: "figure.walk.motion", obtainingExercise: .jogging, amountOfObtainingExercise: 10, obtained: false)]),
                                      ChallengeData(challengeName: "Sprint Quest", challengeDescription: "For those who enjoy pushing their limits, this is the perfect challenge for them.", challengeItems: [ExerciseItem(workoutItem: .running, workoutTrackType: .map, amount: 10)], badges: [Badge(badge: "Sprint Quest Finisher", sfIcon: "figure.run", obtainingExercise: .running, amountOfObtainingExercise: 10, obtained: false)]),
                                      ChallengeData(challengeName: "BlitzDash", challengeDescription: "Take a quick run for about 1 kilometer.", challengeItems: [ExerciseItem(workoutItem: .running, workoutTrackType: .map, amount: 1)], badges: [Badge(badge: "Quick Runner", sfIcon: "figure.run.square.stack", obtainingExercise: .running, amountOfObtainingExercise: 1, obtained: false)]),
                                      ChallengeData(challengeName: "Star Leaps", challengeDescription: "Complete the allocated number of jumping jacks.", challengeItems: [ExerciseItem(workoutItem: .jumpingJacks, workoutTrackType: .counter, amount: 40)], badges: [Badge(badge: "Jumping Jacked", sfIcon: "figure.mixed.cardio", obtainingExercise: .jumpingJacks, amountOfObtainingExercise: 40, obtained: false)]),
                                      ChallengeData(challengeName: "Burpee Burst", challengeDescription: "Complete the allocated number of burpees.", challengeItems: [ExerciseItem(workoutItem: .burpee, workoutTrackType: .counter, amount: 15)], badges: [Badge(badge: "Burpee Burst Finisher", sfIcon: "figure.wrestling", obtainingExercise: .burpee, amountOfObtainingExercise: 15, obtained: false)]),
                                      ChallengeData(challengeName: "Jump&Joy", challengeDescription: "Jump for joy as you jumprope!", challengeItems: [ExerciseItem(workoutItem: .jumpRope, workoutTrackType: .counter, amount: 50)], badges: [Badge(badge: "Jump for Joy", sfIcon: "figure.jumprope", obtainingExercise: .jumpRope, amountOfObtainingExercise: 50, obtained: false)]),
                                      ChallengeData(challengeName: "Summit Champion", challengeDescription: "This challenge is designed for people with a passion for hiking and conquering high peaks.", challengeItems: [ExerciseItem(workoutItem: .hiking, workoutTrackType: .map, amount: 3)], badges: [Badge(badge: "Summit Peaker", sfIcon: "figure.hiking", obtainingExercise: .hiking, amountOfObtainingExercise: 3, obtained: false)]),
                                      ChallengeData(challengeName: "CycleQuest", challengeDescription: "This challenge is great for cycling enthusiasts", challengeItems: [ExerciseItem(workoutItem: .cycling, workoutTrackType: .map, amount: 6)], badges: [Badge(badge: "Cycling Master", sfIcon: "bicycle", obtainingExercise: .cycling, amountOfObtainingExercise: 6, obtained: false)]),
                                      ChallengeData(challengeName: "Peak Pursuit", challengeDescription: "[Higher-Level]Hiking experts can take up this challenge as it requires high levels of endurance.", challengeItems: [ExerciseItem(workoutItem: .hiking, workoutTrackType: .map, amount: 10)], badges: [Badge(badge: "KING of Hiking", sfIcon: "crown.fill", obtainingExercise: .hiking, amountOfObtainingExercise: 10, obtained: false)]),
                                      ChallengeData(challengeName: "Step Saga", challengeDescription: "[Higher-Level]This puts your endurance to the test. Remember, try not taking breaks at all and complete this challenge in one shot!", challengeItems: [ExerciseItem(workoutItem: .walk, workoutTrackType: .map, amount: 15)], badges: [Badge(badge: "Walking Giant", sfIcon: "figure.walk.diamond.fill", obtainingExercise: .walk, amountOfObtainingExercise: 15, obtained: false)]),
                                      ChallengeData(challengeName: "Ultimate Jog Adventure", challengeDescription: "[Higher-Level]This will push the boundaries of your jogging limits!", challengeItems: [ExerciseItem(workoutItem: .jogging, workoutTrackType: .counter, amount: 15)], badges: [Badge(badge: "Jogging KING", sfIcon: "figure.walk.motion", obtainingExercise: .jogging, amountOfObtainingExercise: 15, obtained: false)]),
                                      ChallengeData(challengeName: "APEX Cycling", challengeDescription: "[Higher-Level] This challenge ensures that your cycling endurance is tested to its maximum!", challengeItems: [ExerciseItem(workoutItem: .cycling, workoutTrackType: .map, amount: 12)], badges: [Badge(badge: "APEX Cycler", sfIcon: "figure.outdoor.cycle", obtainingExercise: .cycling, amountOfObtainingExercise: 12, obtained: false)]),
                                      ChallengeData(challengeName: "Xtreme Dash!", challengeDescription: "[Higher-Level] This dash is extreme indeed!", challengeItems: [ExerciseItem(workoutItem: .running, workoutTrackType: .map, amount: 20)], badges: [Badge(badge: "Xtreme Runner", sfIcon: "figure.run.circle.fill", obtainingExercise: .running, amountOfObtainingExercise: 20, obtained: false)]),
                                      ChallengeData(challengeName: "JumpJack Juggernaut", challengeDescription: "[Higher-Level] Surpass your capabilities in doing jumping jacks, by completing this challenge! ", challengeItems: [ExerciseItem(workoutItem: .jumpingJacks, workoutTrackType: .counter, amount: 75)], badges: [Badge(badge: "Jumpernaut", sfIcon: "lightspectrum.horizontal", obtainingExercise: .jumpingJacks, amountOfObtainingExercise: 75, obtained: false)]),
                                      ChallengeData(challengeName: "Elevated Leap", challengeDescription: "[Higher-Level] Compete against gravity and jump new heights!", challengeItems: [ExerciseItem(workoutItem: .jumpRope, workoutTrackType: .counter, amount: 10)], badges: [Badge(badge: "Leap for the Skies!", sfIcon: "cloud.circle", obtainingExercise: .jumpRope, amountOfObtainingExercise: 10, obtained: false)]),
                                      ChallengeData(challengeName: "Burpee Mastery", challengeDescription: "[Higher-Level] Become a master at burpees!", challengeItems: [ExerciseItem(workoutItem: .burpee, workoutTrackType: .counter, amount: 30)], badges: [Badge(badge: "Burpee Legend", sfIcon: "figure.dance", obtainingExercise: .burpee, amountOfObtainingExercise: 30, obtained: false)]),]
    @Forever("userdata") var userData: UserInfo = UserInfo(preferredWorkouts: [],
                                                           timeToWorkout: 5.0,
                                                           age: 16.0,
                                                           height: 189.0,
                                                           weight: 90.0,
                                                           name: "Sam",
                                                           challengeData: [], dailyChallenge: ChallengeData(challengeName: "Generating Challenge", challengeDescription: "Fake challenge", challengeItems: [], badges: []),
                                                           badges: [Badge(badge: "Newbie", sfIcon: "door.left.hand.open", obtainingExercise: .cycling, amountOfObtainingExercise: 0, obtained: true)],
                                                           exerciseData: [])
    @Forever("showSetupModal") var showSetupModal = false
    @AppStorage("challengeStreak") var challengeStreak = 0
    @AppStorage("lastUpdatedDate") var lastUpdatedDate: String = ""
    @AppStorage("showHelp") var showHelp = true
    let challengeManager = ChallengeManager()
    
    
    var body: some View {
        VStack {
            TabView {
                HomeView(selectedWorkout: .cycling, userData: $userData, challengeStreak: $challengeStreak, showHelp: $showHelp)
                    .tabItem {
                        Label("Home", systemImage: "house.fill")
                    }
                
                BadgesView(userData: $userData, currentChallenges: $challengesAvailable)
                    .tabItem {
                        Label("Badges", systemImage: "star")
                    }
                
                ChallengesView(userData: $userData, currentChallenges: $challengesAvailable)
                    .tabItem {
                        Label("Challenges", systemImage: "trophy")
                    }
                
                SettingsView(item: $userData, setup: $showSetupModal, showHelp: $showHelp)
                    .tabItem {
                        Label("Settings", systemImage: "gear")
                    }
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
                userData.dailyChallenge = challengeManager.reRoll(userData: userData, challengeStreak: challengeStreak)
            }
            let dateNow = Date()
            if lastUpdatedDate != dateFormatter.string(from: dateNow) {
                print(lastUpdatedDate)
                print(dateFormatter.string(from: dateNow))
                if userData.dailyChallenge.challengeItems[0].percentage == Float(1) {
                    if challengeStreak != 30 {
                        challengeStreak += 1
                    } else {
                        challengeStreak = 0
                    }
                } else {
                    challengeStreak = 0
                }
                userData.dailyChallenge = challengeManager.reRoll(userData: userData, challengeStreak: challengeStreak)
                lastUpdatedDate = dateFormatter.string(from: dateNow)
            }
            if challengeStreak == 30 {
                challengeStreak = 0
            }
            
            var itemsToCount = 0
            
            for (challengeIndex, challenge) in userData.challengeData.enumerated() {
                for (workoutIndex, workout) in challenge.challengeItems.enumerated() {
                    if workout.percentage == Float(1) {
                        itemsToCount += 1
                    }
                }
                if challenge.challengeItems.count == itemsToCount {
                    userData.challengeData.remove(at: challengeIndex)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

