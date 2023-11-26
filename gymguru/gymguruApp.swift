//
//  gymguruApp.swift
//  gymguru
//
//  Created by Milind Contractor on 17/11/23.
//

import SwiftUI
import SwiftData

@main
struct gymguruApp: App {
    var body: some Scene {
        WindowGroup {
            MapTrackingView(exercises: .constant([]))
        }
    }
}
