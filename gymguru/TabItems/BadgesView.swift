//
//  BadgesView.swift
//  gymguru
//
//  Created by Milind Contractor on 22/11/23.
//

import SwiftUI


struct BadgesView: View {
    let rows = [GridItem(.fixed(30)), GridItem(.fixed(30))]
    @Binding var userData: UserInfo
    @Binding var currentChallenges: [ChallengeData]
    @Environment(\.colorScheme) var colorScheme
    @State var filter = false
    var body: some View {
        VStack {
            HStack {
                Text("Badges")
                    .font(.largeTitle)
                    .bold()
                Spacer()
                Button {
                    if filter {
                        filter = false
                    } else {
                        filter = true
                    }
                } label: {
                    if filter {
                        Image(systemName: "line.3.horizontal.decrease.circle.fill")
                            .font(.system(size: 20))
                    } else {
                        Image(systemName: "line.3.horizontal.decrease.circle")
                            .font(.system(size: 20))
                    }
                }
                .buttonStyle(.borderless)
            }
            .padding()
            ScrollView {
                VStack {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                        ForEach(currentChallenges, id: \.id) { challenge in
                            ForEach(challenge.badges, id: \.id) { badge in
                                if badge.obtained {
                                    VStack {
                                        Image(systemName: badge.sfIcon)
                                            .font(.system(size: 48))
                                        Text(badge.badge)
                                            .font(.system(size: 16))
                                            .multilineTextAlignment(.center)
                                    }
                                    .padding(10)
                                    .frame(width: UIScreen.main.bounds.width/2 - 30, height: 150)
                                    .background(.accent)
                                    .foregroundStyle(.white)
                                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                                    .shadow(color: colorScheme == .dark ? .white.opacity(0.01) : .black.opacity(0.1), radius: 15, x: 0, y: 5)
                                } else if !filter {
                                    VStack {
                                        Image(systemName: badge.sfIcon)
                                            .font(.system(size: 48))
                                        Text(badge.badge)
                                            .font(.system(size: 16))
                                            .multilineTextAlignment(.center)
                                    }
                                    .padding(10)
                                    .frame(width: UIScreen.main.bounds.width/2 - 30, height: 150)
                                    .background(colorScheme == .dark ? Color(red: 18/225, green: 18/225, blue: 18/225) : Color.white)
                                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                                    .shadow(color: colorScheme == .dark ? .white.opacity(0.01) : .black.opacity(0.1), radius: 15, x: 0, y: 5)
                                }
                            }
                        }
                        ForEach(userData.dailyChallenge.badges, id: \.id) { badge in
                            if badge.obtained {
                                VStack {
                                    Image(systemName: badge.sfIcon)
                                        .font(.system(size: 48))
                                    Text(badge.badge)
                                        .font(.system(size: 16))
                                        .multilineTextAlignment(.center)
                                }
                                .padding(10)
                                .frame(width: UIScreen.main.bounds.width/2 - 30, height: 150)
                                .background(.accent)
                                .foregroundStyle(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                                .shadow(color: colorScheme == .dark ? .white.opacity(0.01) : .black.opacity(0.1), radius: 15, x: 0, y: 5)
                            } else if !filter {
                                VStack {
                                    Image(systemName: badge.sfIcon)
                                        .font(.system(size: 48))
                                    Text(badge.badge)
                                        .font(.system(size: 16))
                                        .multilineTextAlignment(.center)
                                }
                                .padding(10)
                                .frame(width: UIScreen.main.bounds.width/2 - 30, height: 150)
                                .background(colorScheme == .dark ? Color(red: 18/225, green: 18/225, blue: 18/225) : Color.white)
                                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                                .shadow(color: colorScheme == .dark ? .white.opacity(0.01) : .black.opacity(0.1), radius: 15, x: 0, y: 5)
                            }   
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Badges")
            .listStyle(.automatic)
            Spacer()
        }
    }
}

#Preview {
    BadgesView(userData: .constant(UserInfo(preferredWorkouts: [],
                                  timeToWorkout: 5.0,
                                  age: 16.0,
                                  height: 189.0,
                                  weight: 90.0,
                                  name: "Sam",
                                challengeData: [], dailyChallenge: ChallengeData(challengeName: "aff", challengeDescription: "afa", challengeItems: [], badges: []),
                                            badges: [Badge(badge: "Newbie", sfIcon: "door.left.hand.open", obtainingExercise: .cycling, amountOfObtainingExercise: 0, obtained: true),
                                            Badge(badge: "Cricketer", sfIcon: "figure.cricket", obtainingExercise: .running, amountOfObtainingExercise: 5, obtained: true),
                                           Badge(badge: "Xmas 23 Challenge Finisher", sfIcon: "tree.fill", obtainingExercise: .running, amountOfObtainingExercise: 10, obtained: false)],
                                            exerciseData: [])), currentChallenges: .constant([]))
}
