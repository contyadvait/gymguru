//
//  BadgesView.swift
//  gymguru
//
//  Created by Milind Contractor on 22/11/23.
//

import SwiftUI


struct BadgesView: View {
    var body: some View {
        VStack{
            HStack{
                Text("Badges")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .multilineTextAlignment(.leading)
                    .padding(10.0)
                Spacer()
            }
        }
    }
}

#Preview {
    BadgesView()
}
