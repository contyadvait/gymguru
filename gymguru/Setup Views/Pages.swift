//
//  Pages.swift
//  gymguru
//
//  Created by Milind Contractor on 17/11/23.
//

import SwiftUI
import CompactSlider

struct PageOneView: View {
    @Namespace var namespace
    @State var showNameEnter = false
    @State var name: String
    @State var page: Int = 1
    @State var height: Float = 140
    @State var weight: Float = 60
    @State var age: Float = 10
    @State var workoutTime: Float = 0.5
    @State var favouriteWorkout: [Exercise] = []
    
    
    
    
    // -------------------------------------------------------------------
    // Page 1
    // -------------------------------------------------------------------
    var one: some View {
        VStack {
            Text("Welcome to GymGuru!")
                .font(.system(size: 30, weight: .bold))
                .padding()
                .onAppear {
                    withAnimation {
                        showNameEnter = true
                    }
                }
                .matchedGeometryEffect(id: "Title", in: namespace)
            
            if showNameEnter {
                VStack {
                    Text("To start, let's get to know about you. Please enter your name or nickname so we know how to call you.")
                    TextField("Name", text: $name)
    .textFieldStyle(.roundedBorder)
                }
                .transition(.move(edge: .bottom))
            }
            
            Button {
                withAnimation {
                    page = page + 1
                }
            } label: {
                Label("Next", systemImage: "arrow.right")
                
            }
            .matchedGeometryEffect(id: "Next", in: namespace)
            .buttonStyle(.borderedProminent)
            
        }
        .padding()
        .matchedGeometryEffect(id: "Whole", in: namespace)
    }
    // -------------------------------------------------------------------
    // Page 2
    // -------------------------------------------------------------------
    var two: some View {
        VStack {
            Text("Welcome to GymGuru!")
                .font(.system(size: 30, weight: .bold))
                .padding()
                .multilineTextAlignment(.center)
                .matchedGeometryEffect(id: "Title", in: namespace)
            
            Text("Now, let's get to know more about you. Please stay as truthful as possible as this well help us generate workouts for you to be more fit.")
            
            VStack {
                
                CompactSlider(value: $height, in: 120...220, step: 1) {
                    HStack {
                        Text("Height")
                        Spacer()
                        Text("\(Int(height)) cm")
                    }
                }
                
                CompactSlider(value: $weight, in: 20...150) {
                    HStack {
                        Text("Weight")
                        Spacer()
                        Text("\(Int(weight)) kg")
                    }
                }
                
                CompactSlider(value: $age, in: 1...90) {
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
// Page 3
// -------------------------------------------------------------------
    var three: some View {
        VStack {
            Text("Welcome to GymGuru!")
                .font(.system(size: 30, weight: .bold))
                .padding()
                .multilineTextAlignment(.center)
                .matchedGeometryEffect(id: "Title", in: namespace)
            
            Text("We are almost done! So, let's get to know your favourite workout. Select your favourite workouts by tapping on it.")
            
            buttonView(elementToChange: .burpee, label: "Burpees")
            buttonView(elementToChange: .jumpRope, label: "Jump Rope")
            buttonView(elementToChange: .jumpingJacks, label: "Jumping Jacks")
            buttonView(elementToChange: .running, label: "Running")
            buttonView(elementToChange: .cycling, label: "Cycling")
            
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
                Text("Welcome to GymGuru!")
                    .font(.system(size: 30, weight: .bold))
                    .padding()
                    .multilineTextAlignment(.center)
                    .matchedGeometryEffect(id: "Title", in: namespace)
                
                Text("Finally, allow us to send reminder notifications, access your location so we can track your workouts during your runs or cycles.")
                
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

    
    var body: some View {
        if page == 1 {
            one
        } else if page == 2 {
            two
        } else if page == 3 {
            three
        }
    }
}

#Preview {
    SetUpManager(name: .constant("Advait"), page: 1)
}
