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
            .frame(width: 100, height: 140)
            .background(colorScheme == .dark ? Color(red: 18/225, green: 18/225, blue: 18/225) : Color.white)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
            .shadow(color: colorScheme == .dark ? .white.opacity(0.01) : .black.opacity(0.1), radius: 15, x: 0, y: 5)
            .foregroundStyle(colorScheme == .dark ? .white : .black)
        }
    }
    
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
        let output = "Due in\n\(hours)h \(minutes)min \(seconds)s"
        
        // Update the @State variable with the output string
        timeRemaining = output
    }
    
    var dailyChallengeView: some View {
        VStack(spacing: 5) {
            HStack {
                Text(userData.dailyChallenge.challengeName)
                    .font(.system(size: 25, weight: .medium))
                Spacer()
                if timeRemaining != "" {
                    Text(timeRemaining)
                        .multilineTextAlignment(.center)
                } else {
                        ProgressView()
                            .tint(.white)
                }
            }
            .padding(.bottom)
            ForEach(userData.dailyChallenge.challengeItems, id: \.id) { challenge in
                ProgressView(value: Float(challenge.completed/challenge.amount)) {
                    HStack {
                        Text("\(challenge.workoutItem.workoutLabel), \(Int(challenge.amount)) \(challenge.workoutItem.unit)")
                        Spacer()
                        Text("\(Int((challenge.percentage)*100))%")
                    }
                }
                .foregroundStyle(.white)
            }
            
            HStack {
                ForEach(userData.dailyChallenge.badges, id: \.id) { badge in
                    Image(systemName: badge.sfIcon)
                        .tint(.accentColor)
                        .font(.system(size: 19))
                }
                Spacer()
            }
        }
        .onAppear {
            // Create a timer that fires every second and calls the calculateTimeRemaining function
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                calculateTimeRemaining()
            }
        }
        .foregroundStyle(.white)
        .padding(10)
        .frame(width: UIScreen.main.bounds.width - 20)
        .background(.accent)
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
        .shadow(color: colorScheme == .dark ? .white.opacity(0.01) : .black.opacity(0.1), radius: 15, x: 0, y: 5)
        .foregroundStyle(colorScheme == .dark ? .white : .black)
    }
    
    var monthlyChallengesView: some View {
        VStack {
            ForEach(userData.challengeData, id: \.id) { challenge in
                VStack {
                    HStack {
                        Text(challenge.challengeName)
                            .font(.system(size: 25, weight: .medium))
                        Spacer()
                    }
                    .padding(.bottom)
                    ForEach(challenge.challengeItems, id: \.id) { challengeItem in
                        ProgressView(value: challengeItem.percentage) {
                            Text("\(challengeItem.workoutItem.workoutLabel), \(Int(challengeItem.amount)) \(challengeItem.workoutItem.unit)")
                        }
                    }
                    .padding([.top, .bottom])
                    
                    HStack {
                        ForEach(challenge.badges, id: \.id) { badge in
                            Image(systemName: badge.sfIcon)
                                .tint(.accentColor)
                                .font(.system(size: 19))
                        }
                        Spacer()
                    }
                }
                .padding(10)
                .frame(width: UIScreen.main.bounds.width - 20)
                .background(colorScheme == .dark ? Color(red: 18/225, green: 18/225, blue: 18/225) : Color.white)
                .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
                .shadow(color: colorScheme == .dark ? .white.opacity(0.01) : .black.opacity(0.1), radius: 15, x: 0, y: 5)
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
                monthlyChallengesView
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
                            workoutItem(workout: .burpee, sfIcon: "figure.wrestling", name: "Burpees")
                            workoutItem(workout: .jumpRope, sfIcon: "figure.jumprope", name: "Jump\nRope")
                            workoutItem(workout: .jumpingJacks, sfIcon: "figure.mixed.cardio", name: "Jumping\nJacks")
                        }
                    }
                    .scrollIndicators(.automatic, axes: .horizontal)
                    .padding(10.0)
                }
            }
            .fullScreenCover(isPresented: $showWorkout) {
                if selectedWorkout == .cycling || selectedWorkout == .running || selectedWorkout == .walk || selectedWorkout == .hiking {
                    MapTrackingView(userData: $userData, exercise: $selectedWorkout)
                } else {
                    CounterTrackingView(userData: $userData, exercise: $selectedWorkout)
                }
            }
        }
    }
}

#Preview {
    HomeView(selectedWorkout: .none, userData: .constant(UserInfo(preferredWorkouts: [], timeToWorkout: 5.0, age: 16.0, height: 189.0, weight: 90.0, name: "Sam", challengeData: [ChallengeData(challengeName: "OOPS", challengeDescription: "oops", challengeItems: [ExerciseItem(workoutItem: .running, workoutTrackType: .counter, amount: 10)], badges: [Badge(badge: "Xmas 23 Challenge Finisher", sfIcon: "7.circle", obtainingExercise: .running, amountOfObtainingExercise: 10, obtained: false)]), ChallengeData(challengeName: "Christmas Special Challenge", challengeDescription: "Lose some weight ASAP to stuff yourself for Christmas!", challengeItems: [ExerciseItem(workoutItem: .running, workoutTrackType: .counter, amount: 10), ExerciseItem(workoutItem: .running, workoutTrackType: .counter, amount: 10)], badges: [])], dailyChallenge: ChallengeData(challengeName: "New Year Challenge", challengeDescription: "Lose some weight in time for the new year!", challengeItems: [ExerciseItem(workoutItem: .running, workoutTrackType: .counter, amount: 10)], badges: [Badge(badge: "Streak Maintainer", sfIcon: "7.circle", obtainingExercise: .cycling, amountOfObtainingExercise: 10, obtained: false)]), badges: [Badge(badge: "Newbie", sfIcon: "door.left.hand.open", obtainingExercise: .none, amountOfObtainingExercise: 0, obtained: true), Badge(badge: "Cricketer", sfIcon: "figure.cricket", obtainingExercise: .running, amountOfObtainingExercise: 5, obtained: true), Badge(badge: "Xmas 23 Challenge Finisher", sfIcon: "tree.fill", obtainingExercise: .running, amountOfObtainingExercise: 10, obtained: false)], exerciseData: [])))
}
