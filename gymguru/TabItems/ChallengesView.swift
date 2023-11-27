//
//  ChallengesView.swift
//  gymguru
//
//  Created by Milind Contractor on 22/11/23.
//

import SwiftUI

struct ChallengesView: View {
    @State var challengesAvailable = [ChallengeData(challengeName: "Christmas Calorie Loss", challengeDescription: "Lose some calories to consume extra for christmas!", challengeItems: [ExerciseItem(workoutItem: .burpee, workoutTrackType: .counter, amount: 10)], badges: []),
                                      ChallengeData(challengeName: "New Year Goals Meet", challengeDescription: "Meet your exercise-related goals just in time for the New Year!", challengeItems: [ExerciseItem(workoutItem: .burpee, workoutTrackType: .counter, amount: 10)], badges: <#[Badge]#>)],
    @Environment(\.colorScheme) var colorScheme
    @Binding var userData: UserInfo
    @State var customChallenge = false
    var body: some View {
        NavigationStack {
            List {
                ForEach($challengesAvailable, id: \.id) { $challenge in
                    NavigationLink {
                        ChallengeInternalView(challenge: $challenge, userData: $userData)
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
            .listStyle(.inset)
            .navigationTitle("Challenges")
            .navigationBarTitleDisplayMode(.automatic)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        customChallenge = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
//        .fullScreenCover(isPresented: $customChallenge) {
//            CustomChallengeCreatorView()
//        }
    }
}

struct ChallengeInternalView: View {
    @Binding var challenge: ChallengeData
    @Binding var userData: UserInfo
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
            Spacer()
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
                userData.challengeData.append(ChallengeData(challengeType: .seasonal, challengeName: challenge.challengeName, challengeDescription: challenge.challengeDescription, challengeItems: challenge.challengeItems))
                dismiss()
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
            
            Spacer()
        }
    }
}
// For a future update (will have to create a Google Docs file for the large amount)
//struct CustomChallengeCreatorView: View {
//    @Environment(\.dismiss) var dismiss
//    @State var showWarning = false
//    var body: some View {
//        VStack {
//            HStack {
//                Text("Create your own custom challenge")
//                    .font(.system(size: 20 ,weight: .medium, design: .default))
//                Spacer()
//                Button {
//                    showWarning = true
//                } label: {
//                    Image(systemName: "xmark.circle.fill")
//                        .symbolRenderingMode(.hierarchical)
//                        .tint(.gray)
//                        .font(.system(size: 25,weight: .medium, design: .default))
//                }
//            }
//        }
//        .padding(.horizontal)
//        .alert("Are you sure you want to close it? Your challenge will not be saved", isPresented: $showWarning) {
//            Button("OK", role: .destructive) { dismiss()  }
//            Button("Cancel", role: .cancel) { }
//        }
//    }
//}
//
//#Preview {
//    CustomChallengeCreatorView()
//}

//#Preview {
//    ChallengeInternalView(challenge: .constant(ChallengeData(challengeName: "New Year Goals Meet", challengeDescription: "Meet your exercise-related goals just in time for the New Year!", challengeItems: [ExerciseItem(workoutItem: .burpee, workoutTrackType: .counter, amount: 10), ExerciseItem(workoutItem: .jogging, workoutTrackType: .map, amount: 10)])))
//}

#Preview {
    ChallengesView(userData: .constant(UserInfo(preferredWorkouts: [], timeToWorkout: 5.0, age: 16.0, height: 189.0, weight: 90.0, name: "Sam", challengeData: [], badges: [], exerciseData: [])))
}
