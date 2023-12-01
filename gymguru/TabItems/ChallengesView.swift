//
//  ChallengesView.swift
//  gymguru
//
//  Created by Milind Contractor on 22/11/23.
//

import SwiftUI

struct ChallengesView: View {
    @Environment(\.colorScheme) var colorScheme
    @Binding var userData: UserInfo
    @State var customChallenge = false
    @Binding var currentChallenges: [ChallengeData]
    var body: some View {
        NavigationStack {
            List {
                ForEach($currentChallenges, id: \.id) { $challenge in
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
    @State var tooManyChallenges = false
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
                if userData.challengeData.count != 2 {
                    userData.challengeData.append(challenge)
                    dismiss()
                } else {
                    tooManyChallenges = true
                }
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
        .alert("You have participated in too many challenges. Please complete one to add another one.", isPresented: $tooManyChallenges) {
            Button("OK", role: .cancel) {
                dismiss()
            }
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
    ChallengesView(userData: .constant(UserInfo(preferredWorkouts: [],
                                                timeToWorkout: 5.0,
                                                age: 16.0,
                                                height: 189.0,
                                                weight: 90.0,
                                                name: "Sam",
                                                          challengeData: [], dailyChallenge:  ChallengeData(challengeName: "aff", challengeDescription: "afa", challengeItems: [], badges: []),
                                                badges: [Badge(badge: "Newbie", sfIcon: "door.left.hand.open", obtainingExercise: .burpee, amountOfObtainingExercise: 0, obtained: true),
                                                          Badge(badge: "Cricketer", sfIcon: "figure.cricket", obtainingExercise: .running, amountOfObtainingExercise: 5, obtained: true),
                                                         Badge(badge: "Xmas 23 Challenge Finisher", sfIcon: "tree.fill", obtainingExercise: .running, amountOfObtainingExercise: 10, obtained: false)],
                                                exerciseData: [])), currentChallenges: .constant([]))
}
