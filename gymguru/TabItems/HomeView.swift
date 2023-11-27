import SwiftUI

struct HomeView: View {
    @Environment(\.colorScheme) var colorScheme
    let item = 0.5
    let cornerRadius = 10.0
    @State var selectedWorkout: Exercise
    @State var showWorkout = false
    @Binding var userData: UserInfo
    
    func workoutItem(workout: Exercise, sfIcon: String, name: String) -> some View {
        Button {
            showWorkout = true
            selectedWorkout = workout
        } label: {
            VStack {
                Image(systemName: sfIcon)
                    .foregroundStyle(.accent)
                    .font(.system(size: 27))
                    .padding(3)
                Text(name)
                    .font(.system(size: 20))
            }
            .padding(10)
            .frame(width: 90, height: 110)
            .background(colorScheme == .dark ? Color(red: 18/225, green: 18/225, blue: 18/225) : Color.white)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
            .shadow(color: colorScheme == .dark ? .white.opacity(0.01) : .black.opacity(0.1), radius: 15, x: 0, y: 5)
            .foregroundStyle(colorScheme == .dark ? .white : .black)
        }
    }
    
    func calculateTimeRemaining() -> String? {
            let currentDate = Date()
            var calendar = Calendar.current

            if let nextDayAtMidnight = calendar.date(byAdding: .day, value: 1, to: currentDate) {
                let timeDifference = calendar.dateComponents([.hour, .minute, .second], from: currentDate, to: nextDayAtMidnight)

                var timeRemainingString = "Due in"

                if let hours = timeDifference.hour, hours > 0 {
                    timeRemainingString += " \(hours)h"
                }

                if let minutes = timeDifference.minute, minutes > 0 {
                    timeRemainingString += " \(minutes)min"
                }

                if let seconds = timeDifference.second, seconds > 0 {
                    timeRemainingString += " \(seconds)s"
                }

                return timeRemainingString
            }

            return nil
        }
    
    var challengesView: some View {
        VStack {
            HStack {
                Text(userData.dailyChallenge.challengeName)
                Spacer()
                Text(calculateTimeRemaining ?? "Error calculator")
            }
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("Home")
                    .font(.largeTitle)
                    .bold()
                    .padding(10.0)
                    .fontWeight(.black)
                Spacer()
            }
            
            ScrollView {
                HStack{
                    Text("Start Workout")
                        .multilineTextAlignment(.leading)
                        .padding(15.0)
                        .font(.title2)
                        .fontWeight(.semibold)
                    Spacer()
                }
                HStack {
                    
                    
                    ScrollView(.horizontal) {
                        HStack {
                            workoutItem(workout: .cycling, sfIcon: "bicycle", name: "Cycle")
                            workoutItem(workout: .running, sfIcon: "figure.run", name: "Run")
                            workoutItem(workout: .walk, sfIcon: "figure.walk", name: "Walk")
                            workoutItem(workout: .hiking, sfIcon: "mountain.2.fill", name: "Hiking")
                            workoutItem(workout: .stairclimbing, sfIcon: "figure.stairs", name: "Stairs")
                            workoutItem(workout: .jumpRope, sfIcon: "figure.jumprope", name: "Jump Rope")
                            workoutItem(workout: .jumpingJacks, sfIcon: "figure.mixed.cardio", name: "Jumping Jacks")
                            workoutItem(workout: .burpee, sfIcon: "figure.strengthtraining.functional", name: "Burpees")
                        }
                    }
                    .scrollIndicators(.automatic, axes: .horizontal)
                    .padding(10.0)
                }
            }
            .fullScreenCover(isPresented: $showWorkout) {
                if selectedWorkout == .cycling || selectedWorkout == .running || selectedWorkout == .walk || selectedWorkout == .hiking || selectedWorkout == .stairclimbing {
                    MapTrackingView(userData: $userData, exercise: $selectedWorkout)
                } else {
                    CounterTrackingView(userData: $userData, exercise: $selectedWorkout)
                }
            }
        }
    }
}

