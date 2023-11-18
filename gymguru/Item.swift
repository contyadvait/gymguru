//
//  Item.swift
//  gymguru
//
//  Created by Milind Contractor on 17/11/23.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}

enum Exercise: Codable {
    case burpee, jumpRope, jumpingJacks, running, cycling
}

@Model
final class UserData {
    var preferredExercises: [Exercise]
    var timeToWorkout: Double
    var age: Int
    var height: Int
    var weight: Int
    var name: String
    
    init(preferredExercises: [Exercise], timeToWorkout: Double, age: Int, height: Int, weight: Int, name: String) {
        self.preferredExercises = preferredExercises
        self.timeToWorkout = timeToWorkout
        self.age = age
        self.height = height
        self.weight = weight
        self.name = name
    }
}
