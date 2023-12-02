//
//  BadgesView.swift
//  gymguru
//
//  Created by Milind Contractor on 22/11/23.
//

import SwiftUI


struct BadgesView: View {
    let rows = [GridItem(.fixed(30)), GridItem(.fixed(30))]
    var userData: UserInfo { userDataManager.userData }
    @ObservedObject var userDataManager: UserDataManager
    @Binding var currentChallenges: [ChallengeData]
    @Environment(\.colorScheme) var colorScheme
    @State var filter = false
    @State var availableBadges: [Badge] = []
    @Binding var loading: Bool
    var body: some View {
        VStack {
            if loading {
                ProgressView()
                .onAppear {
                    availableBadges = []
                    
                    for (_, challenge) in currentChallenges.enumerated() {
                        for (_, badge) in challenge.badges.enumerated() {
                            availableBadges.append(badge)
                        }
                    }
                   
                    for (_, badge) in userData.dailyChallenge.badges.enumerated() {
                        availableBadges.append(badge)
                    }
                    
                    for (badgeIndex, badge) in userDataManager.userData.badges.enumerated() {
                        userDataManager.userData.badges[badgeIndex].obtained = true
                        availableBadges.append(badge)
                    }
                    
                    loading = false
                }
            } else {
                HStack {
                    Text("Badges")
                        .font(.largeTitle)
                        .bold()
                    Spacer()
                    Button {
                        loading = true
                    } label: {
                        Image(systemName: "arrow.clockwise.circle.fill")
                            .font(.system(size: 20))
                    }
                    Button {
                        filter.toggle()
                    } label: {
                            Image(systemName: filter ? "line.3.horizontal.decrease.circle.fill" : "line.3.horizontal.decrease.circle")
                                .font(.system(size: 20))
                    }
                    .buttonStyle(.borderless)
                    .contentTransition(.symbolEffect(.replace))
                }
                .padding()
                ScrollView {
                        VStack {
                            VStack {
                                ForEach(availableBadges, id: \.id) { badge in
                                    if !filter {
                                        HStack {
                                            Image(systemName: badge.sfIcon)
                                                .font(.system(size: 48))
                                            Text(badge.badge)
                                                .font(.system(size: 16))
                                                .multilineTextAlignment(.center)
                                        }
                                        .padding(10)
                                        .frame(width: UIScreen.main.bounds.width - 10, height: 150)
                                        .background(badge.obtained ? .accent : colorScheme == .dark ? Color(red: 18/225, green: 18/225, blue: 18/225) : Color.white)
                                        .foregroundStyle(badge.obtained ? .white : colorScheme == .dark ? .white : .black)
                                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                                        .shadow(color: colorScheme == .dark ? .white.opacity(0.01) : .black.opacity(0.1), radius: 15, x: 0, y: 5)
                                    } else {
                                        if badge.obtained {
                                            VStack {
                                                Image(systemName: badge.sfIcon)
                                                    .font(.system(size: 48))
                                                Text(badge.badge)
                                                    .font(.system(size: 16))
                                                    .multilineTextAlignment(.center)
                                            }
                                            .padding(10)
                                            .frame(width: UIScreen.main.bounds.width - 10, height: 150)
                                            .background(.accent)
                                            .foregroundStyle(.white)
                                            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                                            .shadow(color: colorScheme == .dark ? .white.opacity(0.01) : .black.opacity(0.1), radius: 15, x: 0, y: 5)
                                        }
                                    }
                                }
                            }
                        }
                }
                .onDisappear {
                    availableBadges = []
                    loading = true
                }
            }
        }
    }
}
