//
//  MoreSettingsView.swift
//  gymguru
//
//  Created by Milind Contractor on 21/11/23.
//

import SwiftUI
import CompactSlider

struct MoreSettingsView: View {
    @Binding var userData: UserInfo
    @Binding var isSheetOpened: Bool
    var body: some View {
        VStack {
            HStack {
                Text("More User Settings")
                    .font(.system(size: 20,weight: .medium, design: .default))
                Spacer()
                Button {
                    isSheetOpened = false
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .symbolRenderingMode(.hierarchical)
                        .font(.system(size: 25,weight: .medium, design: .default))
                }
                .tint(.gray)
            }
            .padding([.top, .leading, .trailing])
            
            
            VStack {
                
                CompactSlider(value: $userData.height, in: 120...220, step: 1) {
                    HStack {
                        Text("Height")
                        Spacer()
                        Text("\(Int(userData.height)) cm")
                    }
                }
                
                CompactSlider(value: $userData.weight, in: 20...150, step: 1) {
                    HStack {
                        Text("Weight")
                        Spacer()
                        Text("\(Int(userData.weight)) kg")
                    }
                }
                
                CompactSlider(value: $userData.age, in: 1...90, step: 1) {
                    HStack {
                        Text("Age")
                        Spacer()
                        Text("\(Int(userData.age)) years old")
                    }
                }
                
                CompactSlider(value: $userData.timeToWorkout, in: 0...6, step: 0.5) {
                    HStack {
                        Text("Time available for workouts")
                        Spacer()
                        Text("\(String(format: "%.1f", userData.timeToWorkout)) h")
                    }
                }
            }
            .padding()
            
            Spacer()
        }
        .ignoresSafeArea()
    }
}

struct CreditsView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.openURL) var openURL
    var body: some View {
        VStack {
            HStack {
                Text("Credits")
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
                Text("Packages")
                    .font(.system(size: 20,weight: .regular, design: .default))
                Spacer()
            }
            .padding(.horizontal)
            HStack {
                Text("Yee Jia Chen - Forever")
                Spacer()
                Button {
                    openURL(URL(string: "https://github.com/jiachenyee/Forever")!)
                } label: {
                    Text("View Package")
                }
                .buttonStyle(.borderedProminent)
            }
            .padding(.horizontal)
            
            HStack {
                Text("Alexey Butkin - CompactSlider")
                Spacer()
                Button {
                    openURL(URL(string: "https://github.com/buh/CompactSlider")!)
                } label: {
                    Text("View Package")
                }
                .buttonStyle(.borderedProminent)
            }
            .padding(.horizontal)
//            
//            HStack {
//                Text("Contentful - Contentful.swift")
//                Spacer()
//                Button {
//                    openURL(URL(string: "https://github.com/contentful/contentful.swift")!)
//                } label: {
//                    Text("View Package")
//                }
//                .buttonStyle(.borderedProminent)
//            }
//            .padding(.horizontal)
//            
//            HStack {
//                Text("SDWebImage - SDWebImageSwiftUI")
//                Spacer()
//                Button {
//                    openURL(URL(string: "https://github.com/SDWebImage/SDWebImageSwiftUI")!)
//                } label: {
//                    Text("View Package")
//                }
//                .buttonStyle(.borderedProminent)
//            }
//            .padding(.horizontal)
//            
//            HStack {
//                Text("SDWebImage - SDWebImage")
//                Spacer()
//                Button {
//                    openURL(URL(string: "https://github.com/SDWebImage/SDWebImage")!)
//                } label: {
//                    Text("View Package")
//                }
//                .buttonStyle(.borderedProminent)
//            }
//            .padding(.horizontal)
            Divider()
            HStack {
                Text("Developers")
                    .font(.system(size: 20,weight: .regular, design: .default))
                Spacer()
            }
            .padding(.horizontal)
            HStack {
                Text("Advait Contractor")
                Spacer()
                Button {
                    openURL(URL(string: "https://github.com/contyadvait")!)
                } label: {
                    Text("View Profile")
                }
                .buttonStyle(.borderedProminent)
            }
            .padding(.horizontal)

            HStack {
                Text("Brian Joseph")
                Spacer()
                Button {
                    openURL(URL(string: "https://github.com/BrianJ09")!)
                } label: {
                    Text("View Profile")
                }
                .buttonStyle(.borderedProminent)
            }
            .padding(.horizontal)
            
            HStack {
                Text("Gideon Yen")
                Spacer()
                Button {
                    openURL(URL(string: "https://github.com/GideonYen")!)
                } label: {
                    Text("View Profile")
                }
                .buttonStyle(.borderedProminent)
            }
            .padding(.horizontal)
            
            HStack {
                Text("Sachin Dineshraja")
                Spacer()
                Button {
                    openURL(URL(string: "https://github.com/sachindineshraja08")!)
                } label: {
                    Text("View Profile")
                }
                .buttonStyle(.borderedProminent)
            }
            .padding(.horizontal)
            
            HStack {
                Text("Advait Contractor")
                Spacer()
                Button {
                    openURL(URL(string: "https://github.com/contyadvait")!)
                } label: {
                    Text("View Profile")
                }
                .buttonStyle(.borderedProminent)
            }
            .padding([.horizontal, .bottom])
            HStack {
                Text("Part of the Swift Accelerator Programme 2023")
                Spacer()
            }
            .padding(.horizontal)
            
            Spacer()
        }
    }
}

#Preview {
    CreditsView()
}
