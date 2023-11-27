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
    
    var distanceRange: ClosedRange<Double> = 5...10
    
    func reRoll(userData: UserInfo) -> ChallengeData {
        // Array of workout challenge functions
        let workoutChallengeFunctions: [(UserInfo) -> ChallengeData] = [
            createRunningChallenge,
            createCyclingChallenge,
            createHikingChallenge,
            createWalkChallenge,
            createJoggingChallenge,
            createStairClimbingChallenge,
            createBlankWorkoutChallenge
        ]
        
        // Randomly choose a workout challenge function
        let randomIndex = Int.random(in: 0..<workoutChallengeFunctions.count)
        let selectedFunction = workoutChallengeFunctions[randomIndex]
        
        // Call the selected function with user data to generate the challenge
        return selectedFunction(userData)
    }
    
    // Functions representing different workout challenges
    private func createRunningChallenge(userData: UserInfo) -> ChallengeData {
        return ChallengeData(challengeType: .daily, challengeName: "Running", challengeDescription: "Run for the allocated distance.", challengeItems: [ExerciseItem(workoutItem: .running, workoutTrackType: .map, amount: 5)], badges: [])
    }
    
    private func createCyclingChallenge(userData: UserInfo) -> ChallengeData {
        // Implement cycling challenge creation logic
        return ChallengeData(challengeType: .daily, challengeName: "Cycling", challengeDescription: "Cycle for the allocated distance.", challengeItems: [ExerciseItem(workoutItem: .cycling, workoutTrackType: .map, amount: 5)], badges: [])
    }
    
    private func createHikingChallenge(userData: UserInfo) -> ChallengeData {
        // Implement hiking challenge creation logic
        return ChallengeData(challengeType: .daily, challengeName: "Hiking", challengeDescription: "Hike for the allocated distance.", challengeItems: [ExerciseItem(workoutItem: .hiking, workoutTrackType: .map, amount: 2)], badges: [])
    }
    
    
    private func createWalkChallenge(userData: UserInfo) -> ChallengeData {
        return ChallengeData(challengeType: .daily, challengeName: "Walking", challengeDescription: "Walk for the allocated distance.", challengeItems: [ExerciseItem(workoutItem: .walk, workoutTrackType: .map, amount: 7)], badges: [])
    }
   
    private func createJoggingChallenge(userData: UserInfo) -> ChallengeData {
        return ChallengeData(challengeType: .daily, challengeName: "Jogging", challengeDescription: "Jog for the allocated distance.", challengeItems: [ExerciseItem(workoutItem: .jogging, workoutTrackType: .map, amount: 6)], badges: [])
    }
    private func createStairClimbingChallenge(userData: UserInfo) -> ChallengeData {
        return ChallengeData(challengeType: .daily, challengeName: "StairClimbing", challengeDescription: "Stairclimb for the allocated distance.", challengeItems: [ExerciseItem(workoutItem: .walk, workoutTrackType: .map, amount: 1)], badges: [])
    }
    private func createBlankWorkoutChallenge(userData: UserInfo) -> ChallengeData {
        // Implement blank workout challenge creation logic
        return ChallengeData(challengeType: .daily, challengeName: "Running", challengeDescription: "Run for the allocated distance.(This challenge is random. You can choose to start/continue your workout with this challenge", challengeItems: [ExerciseItem(workoutItem: .running, workoutTrackType: .map, amount: 5)], badges: [])
    }
}
