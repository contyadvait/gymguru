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
                
                VStack {
                    ForEach(userData.challengeData, id: \.id) { challenge in
                        if challenge.challengeType == .daily {
                            VStack {
                                HStack {
                                    Text("Daily Challenge")
                                        .foregroundStyle(.white)
                                        .font(.system(size: 20, weight: .medium))
                                    Spacer()
                                    Text("Due in\n1h 30min")
                                        .foregroundStyle(.white)
                                        .multilineTextAlignment(.center)
                                }
                                
                                ProgressView(value: item) {
                                    HStack {
                                        Text("Run 15 km")
                                            .foregroundStyle(.white)
                                        Spacer()
                                        Text("50%")
                                            .foregroundStyle(.white)
                                    }
                                }
                                .tint(.white)
                                .padding(.top)
                                HStack {
                                    Image(systemName: "figure.run")
                                        .foregroundStyle(.white)
                                    Image(systemName: "soccerball")
                                        .foregroundStyle(.white)
                                    Spacer()
                                }
                                .padding(.top)
                                .environment(\.font, .system(size: 28))
                                .foregroundStyle(.accent)
                                
                            }
                            .padding(10)
                            .frame(maxWidth: UIScreen.main.bounds.width - 20, alignment: .leading)
                            .background(.accent)
                            .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
                            .shadow(color: colorScheme == .dark ? .white.opacity(0.01) : .black.opacity(0.1), radius: 15, x: 0, y: 5)
                        } else {
                            VStack {
                                HStack {
                                    Text(challenge.challengeName)
                                        .font(.system(size: 20, weight: .medium))
                                }
                                
                                ForEach(challenge.challengeItems, id: \.id) { item in
                                    ProgressView(value: item.amount) {
                                        HStack {
                                            Text("\(item.workoutItem.workoutLabel), \(item.amount) \(item.workoutItem.unit)")
                                            Spacer()
                                            Text("Background code")
                                        }
                                    }
                                    .padding(.top)
                                }

                                HStack {
                                    ForEach(challenge.badges, id: \.id) { badge in
                                        Image(systemName: badge.badge)
                                    }
                                    Spacer()
                                }
                                .padding(.top)
                                .environment(\.font, .system(size: 28))
                                .foregroundStyle(.accent)
                                
                            }
                            .padding(10)
                            .background(colorScheme == .dark ? Color(red: 18/225, green: 18/225, blue: 18/225) : Color.white)
                            .frame(maxWidth: UIScreen.main.bounds.width - 20, alignment: .leading)
                            .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
                            .shadow(color: colorScheme == .dark ? .white.opacity(0.01) : .black.opacity(0.1), radius: 15, x: 0, y: 5)
                        }
                    }
                }
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

