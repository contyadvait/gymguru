import SwiftUI

struct HomeView: View {
    @Environment(\.colorScheme) var colorScheme
    let item = 0.5
    let cornerRadius = 10.0
    @State var selectedWorkout: Exercise
    @State var showWorkout = false
    @Binding var userData: UserInfo
    @State var timeRemaining = ""
    
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
    
    // Define a function that calculates the time remaining to midnight and updates the @State variable
    func calculateTimeRemaining() {
        // Get the current date and time
        let now = Date()
        
        // Get the calendar and the components of the current date and time
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute, .second], from: now)
        
        // Calculate the hours, minutes and seconds remaining to midnight
        let hours = 23 - components.hour!
        let minutes = 59 - components.minute!
        let seconds = 59 - components.second!
        
        // Format the output string
        let output = "Due in \(hours)h \(minutes)min \(seconds)s"
        
        // Update the @State variable with the output string
        timeRemaining = output
    }
    
    var dailyChallengeView: some View {
        VStack {
            HStack {
                Text(userData.dailyChallenge.challengeName)
                    .font(.system(size: 25, weight: .medium))
                Spacer()
                Text(timeRemaining)
            }
            HStack {
                Text("")
            }
            ForEach(userData.dailyChallenge.challengeItems, id: \.id) { challenge in
                ProgressView(value: Float(challenge.amount)) {
                    HStack {
                        Text("\(challenge.workoutItem.workoutLabel), \(challenge.amount) \(challenge.workoutItem.unit)")
                        Spacer()
                        Text("\((challenge.completed/challenge.amount)*100)%")
                    }
                }
                .foregroundStyle(.white)
            }
        }
        .foregroundStyle(.white)
        .padding(10)
        .frame(width: UIScreen.main.bounds.width - 20, height: 110)
        .background(.accent)
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
        .shadow(color: colorScheme == .dark ? .white.opacity(0.01) : .black.opacity(0.1), radius: 15, x: 0, y: 5)
        .foregroundStyle(colorScheme == .dark ? .white : .black)
    }
    
    var monthlyChallengesView: some View {
        VStack {
            ForEach(userData.challengeData, id: \.id) { challenge in
                VStack {
                    
                }
            }
            .onAppear {
                // Create a timer that fires every second and calls the calculateTimeRemaining function
                Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                    calculateTimeRemaining()
                }
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
                dailyChallengeView
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

#Preview {
    HomeView(selectedWorkout: .none, userData: .constant(UserInfo(preferredWorkouts: [],
                                                                  timeToWorkout: 5.0,
                                                                  age: 16.0,
                                                                  height: 189.0,
                                                                  weight: 90.0,
                                                                  name: "Sam",
                                                                  challengeData: [],
                                                                  dailyChallenge: ChallengeData(challengeName: "Daily Challenge", challengeDescription: "afa", challengeItems: [ExerciseItem(workoutItem: .running, workoutTrackType: .counter, amount: 10)], badges: []),
                                                                  badges: [Badge(badge: "Newbie", sfIcon: "door.left.hand.open", obtainingExercise: .none, amountOfObtainingExercise: 0, obtained: true),
                                                                           Badge(badge: "Cricketer", sfIcon: "figure.cricket", obtainingExercise: .running, amountOfObtainingExercise: 5, obtained: true),
                                                                           Badge(badge: "Xmas 23 Challenge Finisher", sfIcon: "tree.fill", obtainingExercise: .running, amountOfObtainingExercise: 10, obtained: false)],
                                                                  exerciseData: [])))
}
