//
//  UserDataManager.swift
//  gymguru
//
//  Created by YJ Soon on 2/12/23.
//

import Foundation
import SwiftUI

class UserDataManager: ObservableObject {
    @Published var userData: UserInfo = UserInfo(preferredWorkouts: [],
                                                 timeToWorkout: 0.0,
                                                 age: 23.0,
                                                 height: 165.0,
                                                 weight: 50.0,
                                                 name: "",
                                                 challengeData: [], dailyChallenge: ChallengeData(challengeName: "Generating Challenge", challengeDescription: "Fake challenge", challengeItems: [], badges: []),
                                                 badges: [Badge(badge: "Newbie", sfIcon: "door.left.hand.open", obtainingExercise: .cycling, amountOfObtainingExercise: 0, obtained: true)],
                                                 exerciseData: []) {
        didSet {
            save()
        }
    }
        
    init() {
        load()
    }
    
    func getArchiveURL() -> URL {
        let plistName = "userData.plist"
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        return documentsDirectory.appendingPathComponent(plistName)
    }
    
    func save() {
        let archiveURL = getArchiveURL()
        let propertyListEncoder = PropertyListEncoder()
        let encodedUserData = try? propertyListEncoder.encode(userData)
        try? encodedUserData?.write(to: archiveURL, options: .noFileProtection)
    }
    
    func load() {
        let archiveURL = getArchiveURL()
        let propertyListDecoder = PropertyListDecoder()
                
        if let retrievedUserData = try? Data(contentsOf: archiveURL),
            let userDataDecoded = try? propertyListDecoder.decode(UserInfo.self, from: retrievedUserData) {
            userData = userDataDecoded
        }
    }

}
