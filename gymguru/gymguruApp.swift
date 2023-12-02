//
//  gymguruApp.swift
//  gymguru
//
//  Created by Milind Contractor on 17/11/23.
//

import SwiftUI

@main
struct gymguruApp: App {
    @State var refreshView = false
    var body: some Scene {
        WindowGroup {
                ContentView(refreshView: $refreshView)
        }
    }
}
