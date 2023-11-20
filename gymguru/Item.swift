//
//  Item.swift
//  gymguru
//
//  Created by Milind Contractor on 17/11/23.
//

import Foundation
import SwiftData

enum Exercise: Codable {
    case burpee, jumpRope, running, cycling, swimming, jogging, hiking, stairclimbing, rockclimbing
}

@Model
final class UserData {
    var preferredExercises: [Exercise]
    var timeToWorkout: Float
    var age: Float
    var height: Float
    var weight: Float
    var name: String

    init(preferredExercises: [Exercise], timeToWorkout: Float, age: Float, height: Float, weight: Float, name: String) {
        self.preferredExercises = preferredExercises
        self.timeToWorkout = timeToWorkout
        self.age = age
        self.height = height
        self.weight = weight
        self.name = name
    }
}
