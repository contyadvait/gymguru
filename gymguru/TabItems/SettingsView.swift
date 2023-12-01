//
//  SettingsView.swift
//  gymguru
//
//  Created by Milind Contractor on 20/11/23.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.colorScheme) var colorScheme
    @Binding var item: UserInfo
    @Binding var setup: Bool
    @State var showMoreOptions = false
    @State var openCredits = false
    @Binding var showHelp: Bool
    var body: some View {
        NavigationStack {
            List {
                Section("About You") {
                    VStack {
                        HStack {
                            Text("Name ")
                            Divider()
                            TextField("Sam...", text: $item.name)
                        }
                    }
                    Toggle("Show help button on Home Screen", isOn: $showHelp)
                    Button {
                        showMoreOptions = true
                    } label: {
                        HStack {
                            Text("More")
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                    }
                    .foregroundStyle(colorScheme == .dark ? .white : .black)
                }
                .navigationTitle("Settings")
                .navigationBarTitleDisplayMode(.inline)
                
                Section("Privacy Settings") {
                    Button {
                        if let url = URL(string: UIApplication.openSettingsURLString) {
                            UIApplication.shared.open(url)
                        }
                    } label: {
                        Text("Open Settings")
                    }
                }
                
                Section("Credits") {
                    Button {
                        openCredits = true
                    } label: {
                        Text("Credits")
                    }
                }
            }
            .navigationTitle("Settings")
        }
        .sheet(isPresented: $showMoreOptions) {
            MoreSettingsView(userData: $item, isSheetOpened: $showMoreOptions)
                .presentationDetents([.medium])
            
        }
        
        .sheet(isPresented: $openCredits) {
            CreditsView()
                .presentationDetents([.medium])
            
        }
    }
}

