//
//  DailyChallenges.swift
//  gymguru
//
//  Created by Brian Joseph on 27/11/23.
//

import Foundation
import SwiftUI
import Forever

class ChallengeManager {

    
    func reRoll(userData: UserInfo, challengeStreak: Int) -> ChallengeData {
        if userData.preferredWorkouts == [] {
            if challengeStreak == 7 {
                return ChallengeData(challengeName: "Today's Challenge", challengeDescription: "Refreshes every day", challengeItems: [ExerciseItem(workoutItem: Exercise.random(), amount: Float(Int.random(in: 5...10)))], badges: [Badge(badge: "Week Streak Maintainer", sfIcon: "7.circle", obtainingExercise: .cycling, amountOfObtainingExercise: 10, obtained: false)])
                
            } else if challengeStreak == 30 {
                return ChallengeData(challengeName: "Today's Challenge", challengeDescription: "Refreshes every day", challengeItems: [ExerciseItem(workoutItem: Exercise.random(), amount: Float(Int.random(in: 5...10)))], badges: [Badge(badge: "Month Streak Maintainer", sfIcon: "30.circle", obtainingExercise: .cycling, amountOfObtainingExercise: 10, obtained: false)])
            } else {
                return ChallengeData(challengeName: "Today's Challenge", challengeDescription: "Refreshes every day", challengeItems: [ExerciseItem(workoutItem: Exercise.random(), amount: Float(Int.random(in: 5...10)))], badges: [])
            }
        } else {
            if challengeStreak == 7 {
                return ChallengeData(challengeName: "Today's Challenge", challengeDescription: "Refreshes every day", challengeItems: [ExerciseItem(workoutItem: userData.preferredWorkouts.randomElement() ?? Exercise.random(), amount: Float(Int.random(in: 5...10)))], badges: [Badge(badge: "Week Streak Maintainer", sfIcon: "7.circle", obtainingExercise: .cycling, amountOfObtainingExercise: 10, obtained: false)])
                
            } else if challengeStreak == 30 {
                return ChallengeData(challengeName: "Today's Challenge", challengeDescription: "Refreshes every day", challengeItems: [ExerciseItem(workoutItem: userData.preferredWorkouts.randomElement() ?? Exercise.random(), amount: Float(Int.random(in: 5...10)))], badges: [Badge(badge: "Month Streak Maintainer", sfIcon: "30.circle", obtainingExercise: .cycling, amountOfObtainingExercise: 10, obtained: false)])
            } else {
                return ChallengeData(challengeName: "Today's Challenge", challengeDescription: "Refreshes every day", challengeItems: [ExerciseItem(workoutItem: userData.preferredWorkouts.randomElement() ?? Exercise.random(), amount: Float(Int.random(in: 5...10)))], badges: [])
            }
        }
    }
}
