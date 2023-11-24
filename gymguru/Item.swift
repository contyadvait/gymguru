//
//  Item.swift
//  gymguru
//
//  Created by Milind Contractor on 17/11/23.
//

import Foundation
import MapKit

enum Exercise: Codable {
    case burpee, jumpRope, jumpingJacks, running, cycling, planks, swimming, jogging, hiking, stairclimbing, rockclimbing, walk, none
    
    var workoutLabel: String {
        switch self {
        case .burpee: 
            return "Burpee"
        case .jumpRope:
            return "Jump Rople"
        case .jumpingJacks:
            return "Jumping jacks"
        case .running:
            return "Running"
        case .cycling:
            return "Cycling"
        case .planks:
            return "Planks"
        case .swimming:
            return "Swimming"
        case .jogging:
            return "Jogging"
        case .hiking:
            return "Hiking"
        case .stairclimbing:
            return "Stair Climbing"
        case .rockclimbing:
            return "Rock Climbing"
        case .walk:
            return "Walk"
        case .none:
            return "Blank workout"
        }
    }
    
    var unit: String {
        switch self {
            
        case .burpee:
            return ""
        case .jumpRope:
            return ""
        case .jumpingJacks:
            return ""
        case .running:
            return "km"
        case .cycling:
            return "km"
        case .planks:
            return "min"
        case .swimming:
            return "km"
        case .jogging:
            return "km"
        case .hiking:
            return "km"
        case .stairclimbing:
            return "steps"
        case .rockclimbing:
            return "m"
        case .walk:
            return "km"
        case .none:
            return ""
        }
    }
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
    var badges: [Badge]
    var exerciseData: [Exercise: Float]
}

enum ChallengeType: Codable {
    case daily, seasonal
}

struct ChallengeData: Codable, Identifiable {
    let id = UUID()
    
    var challengeType: ChallengeType = .seasonal
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

struct Badge: Codable, Identifiable {
    let id = UUID()
    var badge: String
    var sfIcon: String
    var obtainingExercise: Exercise
    var amountOfObtainingExercise: Float
    // To be changed to custom Images in v2 (major update in about a month after app's release
}

// Locations
let bukitTimah = CLLocationCoordinate2D(latitude: 1.3465883130043526, longitude: 103.77604065339969)
let macRitche = CLLocationCoordinate2D(latitude: 1.3458229246791371, longitude: 103.83649719859652)
let chestnut = CLLocationCoordinate2D(latitude: 1.3762283876989791, longitude: 103.78107189714665)
let upperSeletarPark = CLLocationCoordinate2D(latitude: 1.4000913361610738, longitude: 103.80755310734715)
let uluSembawangpcn = CLLocationCoordinate2D(latitude: 1.4220192268941243, longitude: 103.79279714442339)
let coneyWest = CLLocationCoordinate2D(latitude: 1.417322304701359, longitude: 103.91497350863645)
let coneyEast = CLLocationCoordinate2D(latitude: 1.401403545319283, longitude: 103.92976256731562)
let pulauUbin = CLLocationCoordinate2D(latitude: 1.4113312119533952, longitude: 103.95638259812203)
let chekJawaWetlands = CLLocationCoordinate2D(latitude: 1.4093623752137738, longitude: 103.99119817430204)
let jurrasicMile = CLLocationCoordinate2D(latitude: 1.3358355690024537, longitude: 103.98330100852492)
let eastCoastPark = CLLocationCoordinate2D(latitude: 1.3014352845819575, longitude: 103.91226622380609)
let gardensByTheBay = CLLocationCoordinate2D(latitude: 1.2815531939092515, longitude: 103.86351903594476)
let railCorridor = CLLocationCoordinate2D(latitude: 1.3529920875083605, longitude: 103.77050832562517)
let bukitBatok = CLLocationCoordinate2D(latitude: 1.3484888544578277, longitude: 103.76408333440817)
let clementiForest = CLLocationCoordinate2D(latitude: 1.3295609216855464, longitude: 103.78114615645318)
let dairyFarm = CLLocationCoordinate2D(latitude: 1.363902747981783, longitude: 103.77629313494597)
let sungeiBuloh = CLLocationCoordinate2D(latitude: 1.4459398764786946, longitude: 103.72388418365436)
let pasirRisPark = CLLocationCoordinate2D(latitude: 1.3815003353929574, longitude: 103.95039731628862)
