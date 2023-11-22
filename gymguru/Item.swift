//
//  Item.swift
//  gymguru
//
//  Created by Milind Contractor on 17/11/23.
//

import Foundation

enum Exercise: Codable {
    case burpee, jumpRope, jumpingJacks, running, cycling, planks, swimming, jogging, hiking, stairclimbing, rockclimbing, walk, none
}

struct UserInfo: Codable, Identifiable {
    let id = UUID()
    
    var preferredWorkouts: [Exercise]
    var timeToWorkout: Float
    var age: Float
    var height: Float
    var weight: Float
    var name: String
    var challengeData: [ChallengeData]
    var medals: [Medal]
    var exerciseData: [Exercise: Float]
}

enum ChallengeType: Codable {
    case daily, seasonal
}

struct ChallengeData: Codable, Identifiable {
    let id = UUID()
    
    var challengeType: ChallengeType
    var challengeName: String
    var challengeDescription: String
    var challengeItems: [ExerciseItem]
}

enum WorkoutTrack: Codable {
    case map, counter, timer
}

struct ExerciseItem: Codable, Identifiable {
    let id = UUID()
    
    var workoutItem: Exercise
    var workoutTrackType: WorkoutTrack
    var amount: Int
}

struct Medal: Codable, Identifiable {
    let id = UUID()
    var medal: String
    var sfIcon: String
    var obtainingExercise: Exercise
    var amountOfObtainingExercise: Float
    // To be changed to custom Images in v2 (major update in about a month after app's release
}
