//
//  ChallengesView.swift
//  gymguru
//
//  Created by Milind Contractor on 22/11/23.
//

import SwiftUI

struct ChallengesView: View {
    @State var challengesAvailable = [ChallengeData(challengeName: "Christmas Calorie Loss", challengeDescription: "Lose some calories to consume extra for christmas!", challengeItems: [ExerciseItem(workoutItem: .burpee, workoutTrackType: .counter, amount: 10)]),
                                      ChallengeData(challengeName: "New Year Goals Meet", challengeDescription: "Meet your exercise-related goals just in time for the New Year!", challengeItems: [ExerciseItem(workoutItem: .burpee, workoutTrackType: .counter, amount: 10)])]
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        NavigationStack {
            List {
                ForEach($challengesAvailable, id: \.id) { $challenge in
                    NavigationLink {
                        Button {
                            
                        } label: {
                            ChallengeInternalView(challenge: $challenge)
                        }
                    } label: {
                        VStack {
                            HStack {
                                Text(challenge.challengeName)
                                    .font(.system(size: 20, weight: .medium))
                                Spacer()
                            }
                            HStack {
                                Text(challenge.challengeDescription)
                                    .multilineTextAlignment(.leading)
                                Spacer()
                            }
                        }
                    }
                    .foregroundStyle(colorScheme == .dark ? .white : .black)
                    .padding(10)
                }
            }
            .listStyle(InsetListStyle())
        }
    }
}

struct ChallengeInternalView: View {
    @Binding var challenge: ChallengeData
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Text(challenge.challengeName)
                        .font(.system(size: 20, weight: .medium))
                    Spacer()
                }
                .padding(.horizontal, 10)
                HStack {
                    Text(challenge.challengeDescription)
                    Spacer()
                }
                .padding(.horizontal, 10)
                Divider()
                HStack {
                    Text("Workout Items")
                        .font(.system(size: 20, weight: .semibold))
                    Spacer()
                }
                .padding(.horizontal, 10)
                Divider()
            }
            
            ForEach(challenge.challengeItems, id: \.id) { workout in
                VStack {
                    HStack {
                        Text(workout.workoutItem.workoutLabel)
                        Spacer()
                        Divider()
                            .frame(height: 20)
                        Spacer()
                            Text("\(String(workout.amount)) \(String(workout.workoutItem.unit))")
                    }
                    Divider()
                }
                .padding(.horizontal, 10)
            }
            Button {
                
            } label: {
                HStack {
                    Spacer()
                    Image(systemName: "plus")
                    Text("Join Challenge")
                    Spacer()
                }
                .padding(.horizontal, 10)
            }
            .buttonStyle(.borderedProminent)
            .padding(.horizontal, 10)
        }
    }
}

#Preview {
    ChallengeInternalView(challenge: .constant(ChallengeData(challengeName: "New Year Goals Meet", challengeDescription: "Meet your exercise-related goals just in time for the New Year!", challengeItems: [ExerciseItem(workoutItem: .burpee, workoutTrackType: .counter, amount: 10), ExerciseItem(workoutItem: .jogging, workoutTrackType: .map, amount: 10)])))
}

#Preview {
    ChallengesView()
}
