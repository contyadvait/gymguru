//
//  ContentView.swift
//  gymguru
//
//  Created by Milind Contractor on 17/11/23.
//

import SwiftUI
import Forever

struct ContentView: View {
    @State var challengesAvailable = [ChallengeData(challengeName: "Stroll Stride", challengeDescription: "Go for a leisure walk for a few kilometers. You can walk around greenery, or walk around your city.", challengeItems: [ExerciseItem(workoutItem: .walk, workoutTrackType: .map, amount: 5)], badges: [], icon:"figure.walk"),
                                      ChallengeData(challengeName: "Chill Chase", challengeDescription: "Journey at a relaxed pace", challengeItems: [ExerciseItem(workoutItem: .jogging, workoutTrackType: .map, amount: 5)], badges: [Badge(badge: "Chill Chaser", sfIcon: "figure.walk.motion", obtainingExercise: .jogging, amountOfObtainingExercise: 10, obtained: false)], icon: "figure.walk.motion"),
                                      ChallengeData(challengeName: "Sprint Quest", challengeDescription: "For those who enjoy pushing their limits, this is the perfect challenge for them.", challengeItems: [ExerciseItem(workoutItem: .running, workoutTrackType: .map, amount: 10)], badges: [Badge(badge: "Sprint Quest Finisher", sfIcon: "figure.run", obtainingExercise: .running, amountOfObtainingExercise: 10, obtained: false)], icon: "figure.run"),
                                      ChallengeData(challengeName: "BlitzDash", challengeDescription: "Take a quick run for about 1 kilometer.", challengeItems: [ExerciseItem(workoutItem: .running, workoutTrackType: .map, amount: 1)], badges: [Badge(badge: "Quick Runner", sfIcon: "figure.run.square.stack", obtainingExercise: .running, amountOfObtainingExercise: 1, obtained: false)], icon: "figure.run"),
                                      ChallengeData(challengeName: "Star Leaps", challengeDescription: "Complete the allocated number of jumping jacks.", challengeItems: [ExerciseItem(workoutItem: .jumpingJacks, workoutTrackType: .counter, amount: 40)], badges: [Badge(badge: "Jumping Jacked", sfIcon: "figure.mixed.cardio", obtainingExercise: .jumpingJacks, amountOfObtainingExercise: 40, obtained: false)], icon: "figure.mixed.cardio"),
                                      ChallengeData(challengeName: "Burpee Burst", challengeDescription: "Complete the allocated number of burpees.", challengeItems: [ExerciseItem(workoutItem: .burpee, workoutTrackType: .counter, amount: 15)], badges: [Badge(badge: "Burpee Burst Finisher", sfIcon: "figure.wrestling", obtainingExercise: .burpee, amountOfObtainingExercise: 15, obtained: false)], icon: "figure.wrestling"),
                                      ChallengeData(challengeName: "Jump&Joy", challengeDescription: "Jump for joy as you jumprope!", challengeItems: [ExerciseItem(workoutItem: .jumpRope, workoutTrackType: .counter, amount: 50)], badges: [Badge(badge: "Jump for Joy", sfIcon: "figure.jumprope", obtainingExercise: .jumpRope, amountOfObtainingExercise: 50, obtained: false)], icon: "figure.jumprope"),
                                      ChallengeData(challengeName: "Summit Champion", challengeDescription: "This challenge is designed for people with a passion for hiking and conquering high peaks.", challengeItems: [ExerciseItem(workoutItem: .hiking, workoutTrackType: .map, amount: 3)], badges: [Badge(badge: "Summit Peaker", sfIcon: "figure.hiking", obtainingExercise: .hiking, amountOfObtainingExercise: 3, obtained: false)], icon: "figure.hiking"),
                                      ChallengeData(challengeName: "CycleQuest", challengeDescription: "This challenge is great for cycling enthusiasts", challengeItems: [ExerciseItem(workoutItem: .cycling, workoutTrackType: .map, amount: 6)], badges: [Badge(badge: "Cycling Master", sfIcon: "bicycle", obtainingExercise: .cycling, amountOfObtainingExercise: 6, obtained: false)], icon: "figure.outdoor.cycle"),
                                      ChallengeData(challengeName: "Peak Pursuit", challengeDescription: "[Higher-Level]Hiking experts can take up this challenge as it requires high levels of endurance.", challengeItems: [ExerciseItem(workoutItem: .hiking, workoutTrackType: .map, amount: 10)], badges: [Badge(badge: "KING of Hiking", sfIcon: "crown.fill", obtainingExercise: .hiking, amountOfObtainingExercise: 10, obtained: false)], icon: "figure.hiking"),
                                      ChallengeData(challengeName: "Step Saga", challengeDescription: "[Higher-Level]This puts your endurance to the test. Remember, try not taking breaks at all and complete this challenge in one shot!", challengeItems: [ExerciseItem(workoutItem: .walk, workoutTrackType: .map, amount: 15)], badges: [Badge(badge: "Walking Giant", sfIcon: "figure.walk.diamond.fill", obtainingExercise: .walk, amountOfObtainingExercise: 15, obtained: false)], icon: "figure.walk"),
                                      ChallengeData(challengeName: "Ultimate Jog Adventure", challengeDescription: "[Higher-Level]This will push the boundaries of your jogging limits!", challengeItems: [ExerciseItem(workoutItem: .jogging, workoutTrackType: .counter, amount: 15)], badges: [Badge(badge: "Jogging KING", sfIcon: "figure.walk.motion", obtainingExercise: .jogging, amountOfObtainingExercise: 15, obtained: false)], icon: "figure.walk.motion"),
                                      ChallengeData(challengeName: "APEX Cycling", challengeDescription: "[Higher-Level] This challenge ensures that your cycling endurance is tested to its maximum!", challengeItems: [ExerciseItem(workoutItem: .cycling, workoutTrackType: .map, amount: 12)], badges: [Badge(badge: "APEX Cycler", sfIcon: "figure.outdoor.cycle", obtainingExercise: .cycling, amountOfObtainingExercise: 12, obtained: false)], icon: "figure.outdoor.cycle"),
                                      ChallengeData(challengeName: "Xtreme Dash!", challengeDescription: "[Higher-Level] This dash is extreme indeed!", challengeItems: [ExerciseItem(workoutItem: .running, workoutTrackType: .map, amount: 20)], badges: [Badge(badge: "Xtreme Runner", sfIcon: "figure.run.circle.fill", obtainingExercise: .running, amountOfObtainingExercise: 20, obtained: false)], icon: "figure.run"),
                                      ChallengeData(challengeName: "JumpJack Juggernaut", challengeDescription: "[Higher-Level] Surpass your capabilities in doing jumping jacks, by completing this challenge! ", challengeItems: [ExerciseItem(workoutItem: .jumpingJacks, workoutTrackType: .counter, amount: 75)], badges: [Badge(badge: "Jumpernaut", sfIcon: "lightspectrum.horizontal", obtainingExercise: .jumpingJacks, amountOfObtainingExercise: 75, obtained: false)], icon: "figure.mixed.cardio"),
                                      ChallengeData(challengeName: "Elevated Leap", challengeDescription: "[Higher-Level] Compete against gravity and jump new heights!", challengeItems: [ExerciseItem(workoutItem: .jumpRope, workoutTrackType: .counter, amount: 10)], badges: [Badge(badge: "Leap for the Skies!", sfIcon: "cloud.circle", obtainingExercise: .jumpRope, amountOfObtainingExercise: 10, obtained: false)], icon: "figure.jumprope"),
                                      ChallengeData(challengeName: "Burpee Mastery", challengeDescription: "[Higher-Level] Become a master at burpees!", challengeItems: [ExerciseItem(workoutItem: .burpee, workoutTrackType: .counter, amount: 30)], badges: [Badge(badge: "Burpee Legend", sfIcon: "figure.dance", obtainingExercise: .burpee, amountOfObtainingExercise: 30, obtained: false)], icon: "figure.wrestling"),]
//    @DontDie("userData") var userData: UserInfo = UserInfo(preferredWorkouts: [],
//                                                           timeToWorkout: 5.0,
//                                                           age: 16.0,
//                                                           height: 189.0,
//                                                           weight: 90.0,
//                                                           name: "Sam",
//                                                           challengeData: [], dailyChallenge: ChallengeData(challengeName: "Generating Challenge", challengeDescription: "Fake challenge", challengeItems: [], badges: []),
//                                                           badges: [Badge(badge: "Newbie", sfIcon: "door.left.hand.open", obtainingExercise: .cycling, amountOfObtainingExercise: 0, obtained: true)],
//                                                           exerciseData: [])
    
    @StateObject var userDataManager = UserDataManager()
    
    @Forever("showSetupModal") var showSetupModal = true
    @AppStorage("challengeStreak") var challengeStreak = 0
    @AppStorage("lastUpdatedDate") var lastUpdatedDate: String = ""
    @AppStorage("showHelp") var showHelp = true
    let challengeManager = ChallengeManager()
    @Binding var refreshView: Bool
    @State var loading = true
    
    var body: some View {
        VStack {
            TabView {
                    HomeView(selectedWorkout: .cycling, userDataManager: userDataManager, challengeStreak: $challengeStreak, showHelp: $showHelp, refreshView: $refreshView)
                        .tabItem {
                            Label("Home", systemImage: "house.fill")
                        }
                
                BadgesView(userDataManager: userDataManager, currentChallenges: $challengesAvailable, loading: $loading)
                    .tabItem {
                        Label("Badges", systemImage: "star")
                    }
                    .onDisappear {
                        loading = true
                    }
                
                ChallengesView(userDataManager: userDataManager, currentChallenges: $challengesAvailable)
                    .tabItem {
                        Label("Challenges", systemImage: "trophy")
                    }
                
                SettingsView(userData: $userDataManager.userData, setup: $showSetupModal, showHelp: $showHelp)
                    .tabItem {
                        Label("Settings", systemImage: "gear")
                    }
            }
        }
        .fullScreenCover(isPresented: $showSetupModal) {
            OnboardingView(userDataManager: userDataManager)
        }
        .onAppear {
            let currentDate = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            
            print(lastUpdatedDate)
            
            let dateString = dateFormatter.string(from: currentDate)
            
            if lastUpdatedDate == "" {
                lastUpdatedDate = dateString
                userDataManager.userData.dailyChallenge = challengeManager.reRoll(userData: userDataManager.userData, challengeStreak: challengeStreak)
            }
            let dateNow = Date()
            if lastUpdatedDate != dateFormatter.string(from: dateNow) {
                if userDataManager.userData.dailyChallenge.challengeItems[0].completed/userDataManager.userData.dailyChallenge.challengeItems[0].amount == Float(1) {
                    if challengeStreak != 30 {
                        challengeStreak += 1
                    } else {
                        challengeStreak = 0
                    }
                } else {
                    challengeStreak = 0
                }
                userDataManager.userData.dailyChallenge = challengeManager.reRoll(userData: userDataManager.userData, challengeStreak: challengeStreak)
                lastUpdatedDate = dateFormatter.string(from: dateNow)
            }
            if challengeStreak == 30 {
                challengeStreak = 0
            }
            
            for (badgeIndex, badge) in userDataManager.userData.badges.enumerated() {
                userDataManager.userData.badges[badgeIndex].obtained = true
            }
            
            for (challengeIndex, challenge) in userDataManager.userData.challengeData.enumerated() {
                for (workoutIndex, workout) in challenge.challengeItems.enumerated() {
                    if workout.completed >= workout.amount {
                        userDataManager.userData.challengeData.remove(at: challengeIndex)
                    }
                }
            }
        }
    }
}
