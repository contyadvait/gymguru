import SwiftUI

struct HomeView: View {
    @Environment(\.colorScheme) var colorScheme
    let item = 0.5
    let cornerRadius = 10.0
    
    func workoutItem(workout: Exercise, sfIcon: String, name: String) -> some View {
        Button {
            
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
                Spacer()
            }
            
            VStack {
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
                
                VStack {
                    HStack {
                        Text("Christmas Special Challenge")
                            .font(.system(size: 20, weight: .medium))
                        Spacer()
                        Text("Due in\n1h 30min")
                            .multilineTextAlignment(.center)
                    }
                    
                    ProgressView(value: 0.3) {
                        HStack {
                            Text("Run 10 km")
                            Spacer()
                            Text("30%")
                        }
                    }
                    .padding(.top)
                    ProgressView(value: 0.1) {
                        HStack {
                            Text("Do 10 Push-ups")
                            Spacer()
                            Text("10%")
                        }
                    }
                    .padding(.top)
                    HStack {
                        Image(systemName: "figure.run")
                        Image(systemName: "soccerball")
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
            HStack {
                Text("Your Workout")
                    .multilineTextAlignment(.leading)
                    .padding(5.0)
                    .font(.title2)
                ScrollView(.horizontal) {
                    HStack {
                        workoutItem(workout: .cycling, sfIcon: "bicycle", name: "Cycle")
                        workoutItem(workout: .running, sfIcon: "figure.run", name: "Run")
                        workoutItem(workout: .walk, sfIcon: "figure.walk", name: "Walk")
                        workoutItem(workout: .hiking, sfIcon: "mountain.2.fill", name: "Hiking")
                        workoutItem(workout: .cycling, sfIcon: "figure.stairs", name: "Stairs")
                        workoutItem(workout: .none, sfIcon: "ellipsis.circle.fill", name: "More")
                    }
                }
                .scrollIndicators(.automatic, axes: .horizontal)
                .padding(10.0)
            }
        }
    }
}

#Preview {
    HomeView()
}
