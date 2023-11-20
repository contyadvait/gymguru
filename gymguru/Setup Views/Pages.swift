//
//  Pages.swift
//  gymguru
//
//  Created by Milind Contractor on 17/11/23.
//

import SwiftUI
import CompactSlider
import UserNotifications
import SwiftData

struct OnboardingView: View {
    @Namespace var namespace
    @State var showNameEnter = false
    @Binding var name: String
    @State var page: Int = 1
    @Binding var height: Float
    @Binding var weight: Float
    @Binding var age: Float
    @Binding var workoutTime: Float
    @Binding var favouriteWorkout: [Exercise]
    @Environment(\.dismiss) var dismiss
    @State var notificationSettings = false
    @State var selectedDate = Date()
    @State var nameError = false
    @State var notificationScheduled = false
    let notify = NotificationHandler()
    // -------------------------------------------------------------------
    // Notification Manager
    // -------------------------------------------------------------------
    func scheduleNotification(selectedDate: Date) {
        let center = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            if granted {
                let content = UNMutableNotificationContent()
                content.title = "Hey! HEY! Get up!"
                content.body = "It's time to workout!"
                content.sound = UNNotificationSound.default
                
                let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: selectedDate)
                let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
                
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                
                center.add(request)
            } else {
                print("Permission denied")
            }
        }
    }
    
    // -------------------------------------------------------------------
    // Page 3 Buttons
    // -------------------------------------------------------------------
    func buttonView(elementToChange: Exercise, label: String) -> some View {
        ZStack {
            Button {
                if favouriteWorkout.contains(elementToChange) {
                    if let index = favouriteWorkout.firstIndex(of: elementToChange) {
                        favouriteWorkout.remove(at: index)
                    }
                } else {
                    favouriteWorkout.append(elementToChange)
                }
            } label: {
                HStack {
                    Text(label)
                    Spacer()
                    if favouriteWorkout.contains(elementToChange) {
                        Image(systemName: "checkmark")
                    }
                }
                .padding(3)
            }
            .buttonStyle(.bordered)
            .cornerRadius(3)
        }
    }
    
    // -------------------------------------------------------------------
    // Page 1
    // -------------------------------------------------------------------
    var one: some View {
        VStack {
            HStack {
                Text("Welcome to GymGuru!")
                    .font(.system(size: 30, weight: .bold))
                    .multilineTextAlignment(.leading)
                    .onAppear {
                        withAnimation {
                            showNameEnter = true
                        }
                    }
                    .padding(.bottom, 2.0)
                    .matchedGeometryEffect(id: "Title", in: namespace)
                    .frame(alignment: .leading)
            }
            
            
            if showNameEnter {
                VStack {
                    Text("To start, let's get to know about you. Please enter your name or nickname so we know how to call you.")
                        .multilineTextAlignment(.center)
                    TextField("Name", text: $name)
                        .textFieldStyle(.roundedBorder)
                }
                .transition(.move(edge: .bottom))
            }
            
            Button {
                if name != "" {
                    withAnimation {
                        page = page + 1
                    }
                } else {
                    nameError = true
                }
            } label: {
                Label("Next", systemImage: "arrow.right")
                
            }
            .matchedGeometryEffect(id: "Next", in: namespace)
            .buttonStyle(.borderedProminent)
            
        }
        .padding()
        .matchedGeometryEffect(id: "Whole", in: namespace)
        .alert("Name is empty. Please enter a name", isPresented: $nameError) {
            Button("Ok", role: .cancel) { }
        }
    }
    // -------------------------------------------------------------------
    // Page 2
    // -------------------------------------------------------------------
    var two: some View {
        VStack {
            Text("Now, let's get to know more about you. Please stay as truthful as possible as this well help us generate workouts for you to be more fit.")
                .multilineTextAlignment(.center)
            
            VStack {
                
                CompactSlider(value: $height, in: 120...220, step: 1) {
                    HStack {
                        Text("Height")
                        Spacer()
                        Text("\(Int(height)) cm")
                    }
                }
                
                CompactSlider(value: $weight, in: 20...150, step: 1) {
                    HStack {
                        Text("Weight")
                        Spacer()
                        Text("\(Int(weight)) kg")
                    }
                }
                
                CompactSlider(value: $age, in: 1...90, step: 1) {
                    HStack {
                        Text("Age")
                        Spacer()
                        Text("\(Int(age)) years old")
                    }
                }
                
                CompactSlider(value: $workoutTime, in: 0...6, step: 0.5) {
                    HStack {
                        Text("Time available for workouts")
                        Spacer()
                        Text("\(String(format: "%.1f", workoutTime)) h")
                    }
                }
            }
            
            HStack {
                Button {
                    withAnimation {
                        page = page - 1
                    }
                } label: {
                    Label("Back", systemImage: "arrow.left")
                }
                .buttonStyle(.bordered)
                .matchedGeometryEffect(id: "Back", in: namespace)
                
                Button {
                    withAnimation {
                        page = page + 1
                    }
                } label: {
                    Label("Next", systemImage: "arrow.right")
                }
                .buttonStyle(.borderedProminent)
                .matchedGeometryEffect(id: "Next", in: namespace)
            }
        }
        .padding()
        .matchedGeometryEffect(id: "Whole", in: namespace)
    }
    // -------------------------------------------------------------------
    // Page 3
    // -------------------------------------------------------------------
    var three: some View {
        VStack {
            
            Text("We are almost done! So, let's get to know your favourite workout. Select your favourite workouts by tapping on it.")
                .multilineTextAlignment(.center)
            
            buttonView(elementToChange: .burpee, label: "Burpees")
            buttonView(elementToChange: .jumpRope, label: "Jump Rope")
            buttonView(elementToChange: .running, label: "Running")
            buttonView(elementToChange: .cycling, label: "Cycling")
            buttonView(elementToChange: .swimming, label: "Swimming")
            buttonView(elementToChange: .rockclimbing, label: "Rock Climbing")
            buttonView(elementToChange: .hiking, label: "Hiking")
            buttonView(elementToChange: .jogging, label: "Jogging")
            buttonView(elementToChange: .stairclimbing, label: "Stair Climbing")
            
            
            HStack {
                Button {
                    withAnimation {
                        page = page - 1
                    }
                } label: {
                    Label("Back", systemImage: "arrow.left")
                }
                .buttonStyle(.bordered)
                .matchedGeometryEffect(id: "Back", in: namespace)
                
                Button {
                    withAnimation {
                        page = page + 1
                    }
                } label: {
                    Label("Next", systemImage: "arrow.right")
                }
                .buttonStyle(.borderedProminent)
                .matchedGeometryEffect(id: "Next", in: namespace)
            }
        }
        .padding()
        .matchedGeometryEffect(id: "Whole", in: namespace)
    }
    // -------------------------------------------------------------------
    // Page 4
    // -------------------------------------------------------------------
    var four: some View {
        VStack {
            Spacer()
            Text("Welcome to GymGuru!")
                .font(.system(size: 30, weight: .bold))
                .padding()
                .multilineTextAlignment(.center)
                .matchedGeometryEffect(id: "Title", in: namespace)
            
            Text("You're almost there!Just allow us to send reminder notifications and access your location so we can track your workouts during your runs or cycles. You can set the notification timing to your preference.")
                .multilineTextAlignment(.center)
                .onAppear {
                    notify.askPermission()
                }
            
            VStack {
                DatePicker("Select Time", selection: $selectedDate, displayedComponents: .hourAndMinute)
                    .datePickerStyle(WheelDatePickerStyle())
                    .labelsHidden()
                Button {
                    scheduleNotification(selectedDate: selectedDate)
                    notificationScheduled = true
                } label: {
                    HStack {
                        Spacer()
                        Label("Set notification timing", systemImage: "info.circle")
                        Spacer()
                    }
                }
                .buttonStyle(.bordered)
                .tint(.blue)
            }
            Spacer()
            HStack {
                Button {
                    withAnimation {
                        page = page - 1
                    }
                } label: {
                    Label("Back", systemImage: "arrow.left")
                }
                .buttonStyle(.bordered)
                .matchedGeometryEffect(id: "Back", in: namespace)
                
                Button {
                    withAnimation {
                        page = page + 1
                    }
                } label: {
                    Label("Finish Setup", systemImage: "checkmark")
                }
                .buttonStyle(.borderedProminent)
                .matchedGeometryEffect(id: "Next", in: namespace)
            }
            Spacer()
        }
        .padding()
        .matchedGeometryEffect(id: "Whole", in: namespace)
        .alert("Notification Sucessfully scheduled!", isPresented: $notificationScheduled) {
            Button("Ok", role: .cancel) { }
        }
    }
    
    
    var body: some View {
        VStack {
            if page != 4 && page != 1{
                Text("Welcome to GymGuru!")
                    .font(.system(size: 30, weight: .bold))
                    .padding()
                    .multilineTextAlignment(.center)
                    .matchedGeometryEffect(id: "Title", in: namespace)
            }
            
            if page == 1 {
                one
            } else if page == 2 {
                two
            } else if page == 3 {
                three
            } else if page == 4 {
                four
            } else {
                ProgressView()
                    .onAppear {
                        dismiss()
                    }
            }
        }
    }
}
