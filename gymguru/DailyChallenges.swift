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
        let workoutOfTheDay = userData.preferredWorkouts.randomElement() ?? Exercise.random()
        var amountOfWorkout = 0
        if !userData.timeToWorkout.isZero {
            print("This is running")
            print(workoutOfTheDay.workoutTime)
            print(userData.timeToWorkout)
            amountOfWorkout = Int(Double(userData.timeToWorkout*60)/workoutOfTheDay.workoutTime)
            if amountOfWorkout == 0 {
                if workoutOfTheDay == .jumpRope || workoutOfTheDay == .burpee || workoutOfTheDay == .jumpingJacks {
                    amountOfWorkout = Int.random(in: 5...25)
                } else {
                    if workoutOfTheDay == .hiking {
                        amountOfWorkout = Int.random(in: 2...5)
                    } else {
                        amountOfWorkout = Int.random(in: 5...10)
                    }
                }
            }
            print(amountOfWorkout)
        } else {
            if workoutOfTheDay == .jumpRope || workoutOfTheDay == .burpee || workoutOfTheDay == .jumpingJacks {
                amountOfWorkout = Int.random(in: 5...25)
            } else {
                if workoutOfTheDay == .hiking {
                    amountOfWorkout = Int.random(in: 2...5)
                } else {
                    amountOfWorkout = Int.random(in: 5...10)
                }
            }
        }
        
        if challengeStreak == 7 {
            return ChallengeData(challengeName: "Today's Challenge", challengeDescription: "Refreshes everyday", challengeItems: [ExerciseItem(workoutItem: workoutOfTheDay, amount: Float(amountOfWorkout))], badges: [Badge(badge: "7-Day Streak", sfIcon: "7.circle", obtainingExercise: .cycling, amountOfObtainingExercise: 10, obtained: false)], icon: "figure.outdoor.cycle")
        } else if challengeStreak == 30 {
            return ChallengeData(challengeName: "Today's Challenge", challengeDescription: "Refreshes everyday", challengeItems: [ExerciseItem(workoutItem: workoutOfTheDay, amount: Float(amountOfWorkout))], badges: [Badge(badge: "30-Day Streak", sfIcon: "7.circle", obtainingExercise: .cycling, amountOfObtainingExercise: 10, obtained: false)], icon: "figure.outdoor.cycle")
        } else {
            return ChallengeData(challengeName: "Today's Challenge", challengeDescription: "Refreshes everyday", challengeItems: [ExerciseItem(workoutItem: workoutOfTheDay, amount: Float(amountOfWorkout))], badges: [], icon: "figure.outdoor.cycle")
        }
    }
}
