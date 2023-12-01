import SwiftUI

struct HomeView: View {
    @Environment(\.colorScheme) var colorScheme
    let item = 0.5
    let cornerRadius = 10.0
    @State var selectedWorkout: Exercise
    @State var showWorkout = false
    @Binding var userData: UserInfo
    @State var timeRemaining = ""
    @Binding var challengeStreak: Int
    @State var helpSheet = false
    let challengeManager = ChallengeManager()
    
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
            
            if userData.dailyChallenge.challengeItems[0].percentage == Float(1) {
                VStack {
                    Text("You have sucessfully completed today's daily challenge! Come back for more tommorow!")
                    Text("Current daily challenge streak: \(challengeStreak)")
                }
                .padding([.top, .bottom])
            }
        }
        .onAppear {
            // Create a timer that fires every second and calls the calculateTimeRemaining function
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                calculateTimeRemaining()
                if timeRemaining == "Due in\n0h 0min 0s" {
                    if userData.dailyChallenge.challengeItems[0].percentage == Float(1) {
//<<<<<<< Updated upstream
                        challengeStreak += 1
                        userData.dailyChallenge = challengeManager.reRoll(userData: userData, challengeStreak: challengeStreak)
                        if challengeStreak == 30 {
                            challengeStreak = 0
                        }
                    }
                }
            }
        }
        .foregroundStyle(.white)
        .padding(10)
        .frame(width: UIScreen.main.bounds.width - 20)
        .background(.accent)
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
        .shadow(color: colorScheme == .dark ? .white.opacity(0.01) : .black.opacity(0.1), radius: 15, x: 0, y: 5)
        .foregroundStyle(colorScheme == .dark ? .white : .black)
        .onAppear {
            if !userData.dailyChallenge.badges.isEmpty {
                if userData.dailyChallenge.challengeItems[0].percentage == Float(1) {
                    for badge in userData.dailyChallenge.badges {
                        userData.badges.append(badge)
                    }
                }
            }
        }
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
                    
                    
                Spacer()
                Button(action: {
                    helpSheet.toggle()
                }, label: {
                    Image(systemName: "questionmark.circle.fill")
                        .font(.system(size: 30))
                })
                .sheet(isPresented: $helpSheet){
                    ScrollView{
                        Text("Help")
                            .font(.largeTitle)
                            .fontWeight(.black)
                            .multilineTextAlignment(.center)
                       
                            .padding(10.0)
                        Text("Daily Challenges")
                            .foregroundStyle(Color.red)
                            .font(.title2)
                            .font(.system(size: 20))
                            .bold()
                            .multilineTextAlignment(.center)
                            
                        Text("Daily challenges are set by the FitStreak AI. These challenges are random from a set of exercises that you can complete. Once you finish the daily challenges 7 days in a row, you will earn the 7-Day Streak badge. This continues on as you can earn badges for 1-Month streaks and so on. You can start a workout and your workout will immediately be counted in your challenge.")
                            .font(.body)
                            .multilineTextAlignment(.center)
                            
                           
                        .padding(5.0)
                        
                        Text("Seasonal Challenges")
                            .foregroundStyle(Color.red)
                            .font(.title2)
                            .font(.system(size: 20))
                            .bold()
                            .multilineTextAlignment(.center)
                        
                        Text("You can choose to join Seasonal Challenges via the 'Challenges' tab. Every challenge has a badge assigned to it. So completing a challenge would allow you to unlock its designated badge which can be accessed through the 'Badges' tab. Do note though, you can only enroll in 2 challenges at maximum!")
                            .font(.body)
                            .multilineTextAlignment(.center)
                        
                            
                        .padding(5.0)
                            
                            Text("Badges")
                                .foregroundStyle(Color.red)
                                .font(.title2)
                                .font(.system(size: 20))
                                .bold()
                                .multilineTextAlignment(.center)
                            
                            Text("You can obtain badges either from daily or seasonal challenges and access them in the 'Badges' tab. Obtained badges will be coloured as Red. You can filter out obtained badges from unobtained badges by clicking the three line icon at the top right of your screen in the 'Badges' tab.")
                                .font(.body)
                                .multilineTextAlignment(.center)
                        
                            .padding(5.0)
                            Text("Personal Workout")
                                .foregroundStyle(Color.red)
                                .font(.title2)
                                .font(.system(size: 20))
                                .bold()
                                .multilineTextAlignment(.center)
                        
                        Text("Other than challenges, you can do your own workout by choosing a workout option in the 'Home' tab. Do note that personal workouts will also count to your challenges, but your workout is not limited to the challenge goal.")
                                .font(.body)
                                .multilineTextAlignment(.center)
                                
                        
                        .padding(5.0)
                        Text("Settings")
                            .foregroundStyle(Color.red)
                            .font(.title2)
                            .font(.system(size: 20))
                            .bold()
                            .multilineTextAlignment(.center)
                        
                        Text("You can edit your personal information like height and weight by going to Settings > More(Under Name). Alternatively, you can also redo your setup. This means you will be brought back to the starting form where you will fill out your name, info, workouts and notification settings.")
                            .font(.body)
                            .multilineTextAlignment(.center)
                    }
                }
            }
            .onAppear {
                for (challengeIndex, challenge) in userData.challengeData.enumerated() {
                    for (_, challengeItem) in challenge.challengeItems.enumerated() {
                        if challengeItem.percentage == Float(1) {
                            for (_, badge) in challenge.badges.enumerated() {
                                userData.badges.append(badge)
                            }
                            userData.challengeData[challengeIndex].badges = []
                        }
                    }
                }
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
    HomeView(selectedWorkout: .hiking, userData: .constant(UserInfo(preferredWorkouts: [], timeToWorkout: 5.0, age: 16.0, height: 189.0, weight: 90.0, name: "Sam", challengeData: [ChallengeData(challengeName: "OOPS", challengeDescription: "oops", challengeItems: [ExerciseItem(workoutItem: .running, workoutTrackType: .counter, amount: 10)], badges: [Badge(badge: "Xmas 23 Challenge Finisher", sfIcon: "7.circle", obtainingExercise: .running, amountOfObtainingExercise: 10, obtained: false)]), ChallengeData(challengeName: "Christmas Special Challenge", challengeDescription: "Lose some weight ASAP to stuff yourself for Christmas!", challengeItems: [ExerciseItem(workoutItem: .running, workoutTrackType: .counter, amount: 10), ExerciseItem(workoutItem: .running, workoutTrackType: .counter, amount: 10)], badges: [Badge(badge: "Xmas 23 Challenge Finisher", sfIcon: "tree.fill", obtainingExercise: .running, amountOfObtainingExercise: 10, obtained: false)])], dailyChallenge: ChallengeData(challengeName: "New Year Challenge", challengeDescription: "Lose some weight in time for the new year!", challengeItems: [ExerciseItem(workoutItem: .running, workoutTrackType: .counter, amount: 10)], badges: [Badge(badge: "Streak Maintainer", sfIcon: "7.circle", obtainingExercise: .cycling, amountOfObtainingExercise: 10, obtained: false)]), badges: [Badge(badge: "Newbie", sfIcon: "door.left.hand.open", obtainingExercise: .jogging, amountOfObtainingExercise: 0, obtained: true), Badge(badge: "Cricketer", sfIcon: "figure.cricket", obtainingExercise: .running, amountOfObtainingExercise: 5, obtained: true), Badge(badge: "Xmas 23 Challenge Finisher", sfIcon: "tree.fill", obtainingExercise: .running, amountOfObtainingExercise: 10, obtained: false)], exerciseData: [])), challengeStreak: .constant(10))
}
