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
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            UserData.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
