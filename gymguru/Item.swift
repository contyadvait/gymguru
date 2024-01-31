//
//  Item.swift
//  gymguru
//
//  Created by Milind Contractor on 17/11/23.
//

import Foundation
import MapKit
import SwiftUI

enum Exercise: Codable, Hashable, CaseIterable {
    case burpee, jumpRope, jumpingJacks, running, cycling, jogging, hiking, walk
    
    var workoutLabel: String {
        switch self {
        case .burpee:
            return "Burpee"
        case .jumpRope:
            return "Jump Rope"
        case .jumpingJacks:
            return "Jumping jacks"
        case .running:
            return "Running"
        case .cycling:
            return "Cycling"
        case .jogging:
            return "Jogging"
        case .hiking:
            return "Hiking"
        case .walk:
            return "Walk"
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
        case .jogging:
            return "km"
        case .hiking:
            return "km"
        case .walk:
            return "km"
        }
    }
    
    var workoutTime: Double {
        switch self {
        case .burpee:
            return 0.1
        case .jumpRope:
            return 0.1
        case .jumpingJacks:
            return 0.1
        case .running:
            return 7.0
        case .cycling:
            return 4.5
        case .jogging:
            return 8.0
        case .hiking:
            return 70.0
        case .walk:
            return 11.0
        }
    }
    
    static func random<G: RandomNumberGenerator>(using generator: inout G) -> Exercise {
        return Exercise.allCases.randomElement(using: &generator)!
    }


    static func random() -> Exercise {
        var g = SystemRandomNumberGenerator()
        return Exercise.random(using: &g)
    }
}

struct UserInfo: Codable, Identifiable, Equatable {
    static func == (lhs: UserInfo, rhs: UserInfo) -> Bool {
        lhs.challengeData == rhs.challengeData
    }
    var id = UUID()
    
    var preferredWorkouts: [Exercise]
    var timeToWorkout: Float
    var age: Float
    var height: Float
    var weight: Float
    var name: String
    var challengeData: [ChallengeData]
    var dailyChallenge: ChallengeData
    var badges: [Badge]
    var exerciseData: [TrackedWorkout]
}

enum ChallengeType: Codable {
    case daily, seasonal
}

struct ChallengeData: Codable, Identifiable, Equatable {
    static func == (lhs: ChallengeData, rhs: ChallengeData) -> Bool {
        lhs.challengeName == rhs.challengeName
    }
    
    var id = UUID()
    
    var challengeType: ChallengeType = .seasonal
    var challengeName: String
    var challengeDescription: String
    var challengeItems: [ExerciseItem]
    var badges: [Badge]
    var icon: String
}

enum WorkoutTrack: Codable {
    case map, counter, timer
}

struct ExerciseItem: Codable, Identifiable {
    var id = UUID()
    var workoutItem: Exercise
    var workoutTrackType: WorkoutTrack = .map
    var amount: Float
    var completed: Float = 0
}

struct Badge: Codable, Identifiable, Equatable {
    static func == (lhs: Badge, rhs: Badge) -> Bool {
        lhs.badge == rhs.badge
    }
    
    var id = UUID()
    var badge: String
    var sfIcon: String
    var obtainingExercise: Exercise
    var amountOfObtainingExercise: Float
    // To be changed to custom Images in v2 (major update in about a month after app's release
    var obtained: Bool
}

struct TrackedWorkout: Codable, Identifiable {
    var id = UUID()
    
    var exercise: Exercise
    var amount: Float
}

// Locations
let bukitTimah = CLLocationCoordinate2D(latitude: 1.3465883130043526, longitude: 103.77604065339969)
let macRitche = CLLocationCoordinate2D(latitude: 1.3458229246791371, longitude: 103.83649719859652)
let chestnut = CLLocationCoordinate2D(latitude: 1.3762283876989791, longitude: 103.78107189714665)
let upperSeletarReservoir = CLLocationCoordinate2D(latitude: 1.4000913361610738, longitude: 103.80755310734715)
let uluSembawangpcn = CLLocationCoordinate2D(latitude: 1.4220192268941243, longitude: 103.79279714442339)
let coneyWest = CLLocationCoordinate2D(latitude: 1.417322304701359, longitude: 103.91497350863645)
let pulauUbin = CLLocationCoordinate2D(latitude: 1.4113312119533952, longitude: 103.95638259812203)
let chekJawaWetlands = CLLocationCoordinate2D(latitude: 1.4093623752137738, longitude: 103.99119817430204)
let jurrasicMile = CLLocationCoordinate2D(latitude: 1.3358355690024537, longitude: 103.98330100852492)
let eastCoastPark = CLLocationCoordinate2D(latitude: 1.3014352845819575, longitude: 103.91226622380609)
let gardensByTheBay = CLLocationCoordinate2D(latitude: 1.2815531939092515, longitude: 103.86351903594476)
let railCorridor = CLLocationCoordinate2D(latitude: 1.3529920875083605, longitude: 103.77050832562517)
let bukitBatokNaturePark = CLLocationCoordinate2D(latitude: 1.3484888544578277, longitude: 103.76408333440817)
let clementiForest = CLLocationCoordinate2D(latitude: 1.3295609216855464, longitude: 103.78114615645318)
let dairyFarm = CLLocationCoordinate2D(latitude: 1.363902747981783, longitude: 103.77629313494597)
let sungeiBuloh = CLLocationCoordinate2D(latitude: 1.4459398764786946, longitude: 103.72388418365436)
let pasirRisPark = CLLocationCoordinate2D(latitude: 1.3815003353929574, longitude: 103.95039731628862)
let botanicGardens = CLLocationCoordinate2D(latitude: 1.3149315824605528, longitude: 103.8162916867477)

struct LocationData: Identifiable{
    let id = UUID()
    var location: CLLocationCoordinate2D
    var name:String
    var icon:String
    var colour:Color
}
let locations: [LocationData] = [LocationData(location: bukitTimah, name: "Bukit Timah", icon: "tree.fill", colour: .blue),
                                 LocationData(location: macRitche, name: "MacRitchie", icon: "tree.fill", colour: .orange),
                                 LocationData(location: chestnut, name: "Chestnut", icon: "tree.fill", colour: .blue),
                                 LocationData(location: upperSeletarReservoir, name: "Upper Seletar Reservoir", icon: "tree.fill", colour: .brown),
                                 LocationData(location: uluSembawangpcn, name: "Ulu Sembawang Park Connector", icon: "tree.fill", colour: .brown),
                                 LocationData(location: coneyWest, name: "Coney Island", icon: "tree.fill", colour: .purple),
                                 LocationData(location: pulauUbin, name: "Pulau Ubin", icon: "tree.fill", colour: .white),
                                 LocationData(location: chekJawaWetlands, name: "Chek Jawa Wetlands", icon: "tree.fill", colour: .white),
                                 LocationData(location: jurrasicMile, name: "Jurrasic Mile", icon: "tree.fill", colour: .green),
                                 LocationData(location: eastCoastPark, name: "East Coast Park", icon: "tree.fill", colour: .brown),
                                 LocationData(location: railCorridor, name: "Rail Corrider", icon: "tree.fill", colour: .blue),
                                 LocationData(location: bukitBatokNaturePark, name: "Bukit Batok Nature Park", icon: "tree.fill", colour: .blue),
                                 LocationData(location: clementiForest, name: "Clementi Forest", icon: "tree.fill", colour: .blue),
                                 LocationData(location: dairyFarm, name: "Dairy Farm", icon: "tree.fill", colour: .blue),
                                 LocationData(location: sungeiBuloh, name: "Sungei Buloh", icon: "bird.fill", colour: .blue),
                                 LocationData(location: pasirRisPark, name: "Pasir Ris Park", icon: "tree.fill", colour: .green),
                                 LocationData(location: botanicGardens, name: "Botanic Gardens", icon: "tree.fill", colour: .yellow)]
                    
