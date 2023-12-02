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
            if !refreshView {
                ContentView(refreshView: $refreshView)
            } else {
                ProgressView()
                    .onAppear {
                        refreshView = false
                    }
            }
        }
    }
}
