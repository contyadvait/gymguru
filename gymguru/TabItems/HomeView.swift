import SwiftUI

struct HomeView: View {
    @Environment(\.colorScheme) var colorScheme
    let item = 0.5
    let cornerRadius = 10.0
    @State var selectedWorkout: Exercise
    @State var showWorkout = false
//    @Binding var userData: UserInfo
    var userData: UserInfo { userDataManager.userData }
    @ObservedObject var userDataManager: UserDataManager
    @State var timeRemaining = ""
    @Binding var challengeStreak: Int
    @State var helpSheet = false
    let challengeManager = ChallengeManager()
    @State var leaveChallengeSheet = false
    @Environment(\.dismiss) var dismiss
    @State var warnBeforeLeaving = false
    @Binding var showHelp: Bool
    @State var homeViewOpened = false
    @State var refreshID = UUID()
    @Binding var refreshView: Bool
    
    func workoutItem(workout: Exercise, sfIcon: String, name: String) -> some View {
        Button {
            homeViewOpened = false
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
                        Text("\(Int(challenge.completed/challenge.amount)*100)%")
                    }
                }
                .tint(.white)
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
            
            if userData.dailyChallenge.challengeItems[0].amount <= userData.dailyChallenge.challengeItems[0].completed {
                VStack {
                    Text("You have sucessfully completed today's daily challenge! Come back for more tommorow!")
                    Text("Current daily challenge streak: \(challengeStreak)")
                }
                .padding([.top, .bottom])
            }
        }
        .onAppear {
            // Create a timer that fires every second and calls the calculateTimeRemaining function
            if userData.dailyChallenge.challengeName == "Generating Challenge" {
                userDataManager.userData.dailyChallenge = challengeManager.reRoll(userData: userData, challengeStreak: challengeStreak)
            }
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                calculateTimeRemaining()
                if timeRemaining == "Due in\n0h 0min 0s" {
                    if userData.dailyChallenge.challengeItems[0].amount <= userData.dailyChallenge.challengeItems[0].completed {
                        //<<<<<<< Updated upstream
                        challengeStreak += 1
                        userDataManager.userData.dailyChallenge = challengeManager.reRoll(userData: userData, challengeStreak: challengeStreak)
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
                if userData.dailyChallenge.challengeItems[0].completed >= userData.dailyChallenge.challengeItems[0].amount {
                    for badge in userData.dailyChallenge.badges {
                        userDataManager.userData.badges.append(badge)
                    }
                }
            }
        }
    }
    
    var monthlyChallengesView: some View {
        VStack {
            ForEach($userDataManager.userData.challengeData, id: \.id) { $challenge in
                VStack {
                    HStack {
                        Text(challenge.challengeName)
                            .font(.system(size: 25, weight: .medium))
                        Spacer()
                    }
                    .padding(.bottom)
                    ForEach(challenge.challengeItems, id: \.id) { challengeItem in
                        ProgressView(value: challengeItem.completed/challengeItem.amount) {
                            HStack {
                                Text("\(challengeItem.workoutItem.workoutLabel), \(Int(challengeItem.amount)) \(challengeItem.workoutItem.unit)")
                                Spacer()
                                if (challengeItem.completed/challengeItem.amount)*100 >= 100 {
                                    Text("Completed!")
                                } else {
                                    Text("\(Int((challengeItem.completed/challengeItem.amount)*100))%")
                                }
                            }
                        }
                        if challengeItem.completed >= challengeItem.amount {
                            Text("You have finished this workout!")
                                .onAppear {
                                    for (badgeIndex, _) in userDataManager.userData.badges.enumerated() {
                                        userDataManager.userData.badges[badgeIndex].obtained = true
                                    }
                                }
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
                .onLongPressGesture {
                    leaveChallengeSheet = true
                }
                .sheet(isPresented: $leaveChallengeSheet) {
                    LeaveChallengeView(userData: $userDataManager.userData, challenge: $challenge, warnBeforeLeaving: $warnBeforeLeaving)
                }
            }
        }
    }
    
    var body: some View {
        VStack {
            
            if homeViewOpened {
                VStack {
                    HStack {
                        Text("Home")
                            .onChange(of: userData) {
                                print(userData)
                                print(Date())
                            }
                            .font(.largeTitle)
                            .bold()
                            .padding(10.0)
                        
                        
                        Spacer()
                        if showHelp {
                            Button(action: {
                                helpSheet.toggle()
                            }, label: {
                                Image(systemName: helpSheet ? "questionmark.circle" : "questionmark.circle.fill")
                                    .symbolRenderingMode(.hierarchical)
                                    .font(.system(size: 25))
                            })
                            .contentTransition(.symbolEffect(.replace))
                            .sheet(isPresented: $helpSheet){
                                HelpView()
                            }
                        }
                        Button {
                            refreshID = UUID()
                            refreshView = true
                            print("refreshing.....")
                        } label: {
                            Image(systemName: "arrow.clockwise.circle.fill")
                                .symbolRenderingMode(.hierarchical)
                                .font(.system(size: 25))
                                .padding()
                        }
                        .symbolEffect(.bounce, value: refreshID)
                        .padding(.trailing, 2)
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
                                .padding(20)
                            }
                            .scrollIndicators(.automatic, axes: .horizontal)
                            .padding([.horizontal, .bottom], 5.0)
                        }
                    }
                }
            } else {
                ProgressView()
                    .onAppear {
                        var workoutsFinished: Int = 0
                        
                        for (challengeIndex, challenge) in userData.challengeData.enumerated() {
                            for (workoutIndex, workout) in challenge.challengeItems.enumerated() {
                                if workout.amount <= workout.completed {
                                    workoutsFinished = workoutsFinished + 1
                                }
                                if challenge.challengeItems.count == workoutsFinished {
                                    userDataManager.userData.challengeData.remove(at: challengeIndex)
                                }
                            }
                        }
                        for (challengeIndex, challenge) in userData.challengeData.enumerated() {
                            for (_, challengeItem) in challenge.challengeItems.enumerated() {
                                if challengeItem.amount <= challengeItem.completed {
                                    for (_, badge) in challenge.badges.enumerated() {
                                        userDataManager.userData.badges.append(badge)
                                    }
                                    
                                    userDataManager.userData.challengeData.remove(at: challengeIndex)
                                }
                            }
                        }
                        
                        homeViewOpened = true
                    }
            }
        }
        .fullScreenCover(isPresented: $showWorkout, onDismiss: { showWorkout = false }, content: {
            if selectedWorkout == .cycling || selectedWorkout == .running || selectedWorkout == .walk || selectedWorkout == .hiking {
                MapTrackingView(userData: $userDataManager.userData, exercise: $selectedWorkout)
                    .onAppear {
                        homeViewOpened = false
                    }
            } else {
                CounterTrackingView(userData: $userDataManager.userData, exercise: $selectedWorkout)
                    .onAppear {
                        homeViewOpened = false
                    }
            }
        })
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { _ in
                print("running")
                var workouts = 0
                
                for (_, challenge) in userData.challengeData.enumerated() {
                    for (_, workout) in challenge.challengeItems.enumerated() {
                        if workout.completed >= workout.amount {
                            workouts = workouts + 1
                            print(workouts)
                        }
                    }
                    if workouts == challenge.challengeItems.count {
                        print("challenges finished!")
                        for (_, badge) in challenge.badges.enumerated() {
                            userDataManager.userData.badges.append(badge)
                            print(userData.badges)
                        }
                    }
                }
                
                homeViewOpened = false
                homeViewOpened = true
            }
        }
        .id(refreshID)
    }
}


struct LeaveChallengeView: View {
    @Binding var userData: UserInfo
    @Environment(\.dismiss) var dismiss
    @Binding var challenge: ChallengeData
    @Binding var warnBeforeLeaving: Bool
    var body: some View {
        VStack {
            HStack {
                Text("Challenge Info")
                    .font(.system(size: 20,weight: .medium, design: .default))
                Spacer()
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .symbolRenderingMode(.hierarchical)
                        .font(.system(size: 25,weight: .medium, design: .default))
                }
                .tint(.gray)
            }
            .padding([.top, .leading, .trailing])
            Divider()
            HStack {
                Text(challenge.challengeName)
                Spacer()
            }
            .padding(.horizontal)
            
            HStack {
                Text(challenge.challengeDescription)
                Spacer()
            }
            .padding(.horizontal)
            
            Button {
                warnBeforeLeaving = true
            } label: {
                HStack {
                    Spacer()
                    Image(systemName: "xmark.circle.fill")
                    Text("Leave Challenge")
                    Spacer()
                }
            }
            .padding(.horizontal)
            .buttonStyle(.borderedProminent)
            
            Spacer()
        }
        .presentationDetents([.medium])
        .alert("Are you sure you want to leave this challenge? Changes made will not be saved", isPresented: $warnBeforeLeaving) {
            Button("OK", role: .destructive) {
                if let index = userData.challengeData.firstIndex(of: challenge) {
                    userData.challengeData.remove(at: index)
                } else {
                    print("Failed")
                }
                dismiss()
            }
            Button("Cancel", role: .cancel) { dismiss() }
        }
    }
}


struct HelpView: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
            HStack {
                Text("Help")
                    .font(.system(size: 20,weight: .medium, design: .default))
                Spacer()
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .symbolRenderingMode(.hierarchical)
                        .font(.system(size: 25,weight: .medium, design: .default))
                }
                .tint(.gray)
            }
            .padding([.top, .leading, .trailing])
            Divider()
            ScrollView{
                HStack {
                    Text("Daily Challenges")
                        .font(.title2)
                        .font(.system(size: 20))
                        .bold()
                        .multilineTextAlignment(.leading)
                    Spacer()
                }
                .padding(.horizontal)
                
                HStack {
                    Text("Daily challenges are set by the FitStreak AI. These challenges are random from a set of exercises that you can complete. Once you finish the daily challenges 7 days in a row, you will earn the 7-Day Streak badge. This continues on as you can earn badges for 1-Month streaks and so on. You can start a workout and your workout will immediately be counted in your challenge.")
                        .font(.body)
                        .multilineTextAlignment(.leading)
                    Spacer()
                }
                .padding()
                
                Divider()
                
                HStack {
                    Text("Seasonal Challenges")
                        .font(.title2)
                        .font(.system(size: 20))
                        .bold()
                        .multilineTextAlignment(.leading)
                    Spacer()
                }
                .padding(.horizontal)
                
                
                HStack {
                    Text("You can choose to join Seasonal Challenges via the 'Challenges' tab. Every challenge has a badge assigned to it. So completing a challenge would allow you to unlock its designated badge which can be accessed through the 'Badges' tab. Do note though, you can only enroll in 2 challenges at maximum! To leave these challenges, press and hold on the title on the home screen, to which you can access a sheet to leave the challenge.")
                        .font(.body)
                        .multilineTextAlignment(.leading)
                    Spacer()
                }
                .padding()
                
                Divider()
                
                HStack {
                    Text("Badges")
                        .font(.title2)
                        .font(.system(size: 20))
                        .bold()
                        .multilineTextAlignment(.leading)
                    Spacer()
                }
                .padding(.horizontal)
                
                HStack {
                    Text("You can obtain badges either from daily or seasonal challenges and access them in the 'Badges' tab. Obtained badges will be coloured as Red. You can filter out obtained badges from unobtained badges by clicking the three line icon at the top right of your screen in the 'Badges' tab.")
                        .font(.body)
                        .multilineTextAlignment(.leading)
                    Spacer()
                }
                .padding()
                
                Divider()
                
                HStack {
                    Text("Personal Workout")
                        .font(.title2)
                        .font(.system(size: 20))
                        .bold()
                        .multilineTextAlignment(.center)
                    Spacer()
                }
                .padding(.horizontal)
                
                HStack {
                    Text("Other than challenges, you can do your own workout by choosing a workout option in the 'Home' tab. Do note that personal workouts will also count to your challenges, but your workout is not limited to the challenge goal.")
                        .font(.body)
                        .multilineTextAlignment(.leading)
                }
                .padding()
                
                Divider()
                
                HStack {
                    Text("Settings")
                        .font(.title2)
                        .font(.system(size: 20))
                        .bold()
                        .multilineTextAlignment(.center)
                    Spacer()
                }
                .padding(.horizontal)
                
                HStack {
                    Text("You can edit your personal information like height and weight by going to Settings > More(Under Name).")
                        .font(.body)
                        .multilineTextAlignment(.leading)
                    Spacer()
                }
                .padding()
            }
        }
        .presentationDetents([.medium, .large])
    }
}


//#Preview {
//    HomeView(selectedWorkout: .hiking, userData: .constant(UserInfo(preferredWorkouts: [], timeToWorkout: 5.0, age: 16.0, height: 189.0, weight: 90.0, name: "Sam", challengeData: [ChallengeData(challengeName: "OOPS", challengeDescription: "oops", challengeItems: [ExerciseItem(workoutItem: .running, workoutTrackType: .counter, amount: 10)], badges: [Badge(badge: "Xmas 23 Challenge Finisher", sfIcon: "7.circle", obtainingExercise: .running, amountOfObtainingExercise: 10, obtained: false)]), ChallengeData(challengeName: "Christmas Special Challenge", challengeDescription: "Lose some weight ASAP to stuff yourself for Christmas!", challengeItems: [ExerciseItem(workoutItem: .running, workoutTrackType: .counter, amount: 10), ExerciseItem(workoutItem: .running, workoutTrackType: .counter, amount: 10)], badges: [Badge(badge: "Xmas 23 Challenge Finisher", sfIcon: "tree.fill", obtainingExercise: .running, amountOfObtainingExercise: 10, obtained: false)])], dailyChallenge: ChallengeData(challengeName: "New Year Challenge", challengeDescription: "Lose some weight in time for the new year!", challengeItems: [ExerciseItem(workoutItem: .running, workoutTrackType: .counter, amount: 10)], badges: [Badge(badge: "Streak Maintainer", sfIcon: "7.circle", obtainingExercise: .cycling, amountOfObtainingExercise: 10, obtained: false)]), badges: [Badge(badge: "Newbie", sfIcon: "door.left.hand.open", obtainingExercise: .jogging, amountOfObtainingExercise: 0, obtained: true), ], exerciseData: [])), challengeStreak: .constant(10), showHelp: .constant(false))
//}
