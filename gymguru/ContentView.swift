//
//  ContentView.swift
//  gymguru
//
//  Created by Milind Contractor on 17/11/23.
//

import SwiftUI
import SwiftData

//struct ContentView: View {
//    @Environment(\.modelContext) private var modelContext
//    @Query private var items: [Item]
//
//    var body: some View {
//        NavigationSplitView {
//            List {
//                ForEach(items) { item in
//                    NavigationLink {
//                        Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
//                    } label: {
//                        Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
//                    }
//                }
//                .onDelete(perform: deleteItems)
//            }
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    EditButton()
//                }
//                ToolbarItem {
//                    Button(action: addItem) {
//                        Label("Add Item", systemImage: "plus")
//                    }
//                }
//            }
//        } detail: {
//            Text("Select an item")
//        }
//    }
//
//    private func addItem() {
//        withAnimation {
//            let newItem = Item(timestamp: Date())
//            modelContext.insert(newItem)
//        }
//    }
//
//    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            for index in offsets {
//                modelContext.delete(items[index])
//            }
//        }
//    }
//}

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Namespace var namespace
    @State var showNameEnter = false
    @State var name: String = ""
    @State var page: Int = 1
    @State var height: Float = 140
    @State var weight: Float = 60
    @State var age: Float = 10
    @State var workoutTime: Float = 0.5
    @State var favouriteWorkout: [Exercise] = []
    @Environment(\.dismiss) var dismiss
    @State var notificationSettings = false
    @State var selectedDate = Date()
    @AppStorage("setup") var setUp = false
    let notify = NotificationHandler()
    let notificationTimeInterval = 30.0
    @Query private var items: [UserData]
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Home Screen")
                List {
                    ForEach(items) { item in
                        ScrollView {
                            Text("Settings Data Retrieved")
                            Text("Name: \(item.name)")
                            Text("Time to workout: \(item.timeToWorkout)")
                            Text("Age: \(item.age)")
                            Text("Height: \(item.height)")
                            Text("Weight: \(item.weight)")
                            Text("Tap to reveal prefered exercises (check console)")
                                .onTapGesture {
                                    print(item.preferredExercises)
                                }
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
                Text("Re-do Setup")
                    .onTapGesture {
                        setUp = true
                    }
            }
            .fullScreenCover(isPresented: $setUp) {
                OnboardingView(name: $name, height: $height, weight: $weight, age: $age, workoutTime: $workoutTime, favouriteWorkout: $favouriteWorkout)
                    .onDisappear {
                        withAnimation {
                            let newItem = UserData(preferredExercises: favouriteWorkout, timeToWorkout: workoutTime, age: age, height: height, weight: weight, name: name)
                            modelContext.insert(newItem)
                        }
                    }
            }
        }
        .navigationTitle("Home")
    }
}


#Preview {
    ContentView(name: "Advait")
}

