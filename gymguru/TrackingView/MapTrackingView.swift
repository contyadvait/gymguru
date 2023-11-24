//
//  MapTrackingView.swift
//  gymguru
//
//  Created by Milind Contractor on 23/11/23.
//

import SwiftUI
import MapKit

struct MapTrackingView: View {
    @State var showStats = true
    @Namespace var namespace
    var body: some View {
        if !showStats {
            VStack {
                Map()
                Button {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        showStats = true
                    }
                } label: {
                    Image(systemName: "chart.xyaxis.line")
                }
                .buttonStyle(.bordered)
                .matchedGeometryEffect(id: "Graph button", in: namespace)
            }
            .transition(.slide)
        } else {
            VStack {
                VStack {
                    Spacer()
                    Text("00:20:35")
                        .font(.system(size: 55))
                        .fontWidth(.expanded)
                    Text("TIME")
                        .font(.system(size: 20))
                        .fontWidth(.expanded)
                    Divider()
                    Text("10 km/h")
                        .font(.system(size: 55))
                        .fontWidth(.expanded)
                    Text("SPEED")
                        .font(.system(size: 20))
                        .fontWidth(.expanded)
                    Divider()
                    Text("7:55")
                        .font(.system(size: 55))
                        .fontWidth(.expanded)
                    Text("TIME PER KM")
                        .font(.system(size: 20))
                        .fontWidth(.expanded)
                    Divider()
                    Text("3.14 km")
                        .font(.system(size: 55))
                        .fontWidth(.expanded)
                    Text("DISTANCE")
                        .font(.system(size: 20))
                        .fontWidth(.expanded)
Spacer()
                }
                Button {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        showStats = false
                    }
                } label: {
                    Image(systemName: "chart.xyaxis.line")
                }
                .buttonStyle(.borderedProminent)
                .matchedGeometryEffect(id: "Graph button", in: namespace)
            }
            .transition(.slide)
        }
    }
}

#Preview {
    MapTrackingView()
}
