//
//  MapTrackingView.swift
//  gymguru
//
//  Created by Milind Contractor on 23/11/23.
//

import SwiftUI
import MapKit
import CoreLocation


@Observable
class NewLocationManager {
    var location: CLLocation? = nil
    
    private let locationManager = CLLocationManager()
    
    func requestUserAuthorization() async throws {
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
    }
    
    func startCurrentLocationUpdates() async throws {
        for try await locationUpdate in CLLocationUpdate.liveUpdates() {
            guard let location = locationUpdate.location else { return }
            
            self.location = location
            print(location)
        }
    }
}

struct MapTrackingView: View {
    @State var showStats = false
    @State var isWorkoutRunning = true
    @Namespace var namespace
    @State var position: MapCameraPosition = .automatic
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 0, longitude: 0),
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    )
    @Namespace var mapscope
    @State private var distance: Double = 0
    @State var locationManager = NewLocationManager()
    
    var body: some View {
        if !showStats {
            VStack {
                VStack {
                    Map(position: $position, scope: mapscope) {
                        Marker("Bukit Timah", systemImage: "mountain.2.fill", coordinate: bukitTimah)
                            .tint(.blue)
                        Marker("MacRitche", systemImage: "tree.fill", coordinate: macRitche)
                            .tint(.orange)
                        Marker("Chestnut Nature",systemImage: "tree.fill", coordinate: chestnut)
                            .tint(.blue)
                        UserAnnotation()
                        Marker("Coney Island", systemImage: "figure.outdoor.cycle", coordinate: coneyWest)
                            .tint(.purple)
                        Marker("Pulau Ubin", systemImage: "bicycle", coordinate: pulauUbin)
                            .tint(.green)
                        Marker("East Coast Park", systemImage: "bicycle", coordinate: eastCoastPark)
                            .tint(.brown)
                        Marker("Sungei Buloh Wetlands", systemImage: "bird.fill", coordinate: sungeiBuloh)
                            .tint(.red)
                        Marker("Pasir Ris Park", systemImage: "tree.fill", coordinate: pasirRisPark)
                            .tint(.green)
                        Marker("Gardens By The Bay", systemImage: "tree.fill", coordinate: gardensByTheBay)
                            .tint(.orange)
                    }
                }
                .mapControls {
                    MapUserLocationButton()
                    MapCompass()
                    MapScaleView()
                    MapPitchToggle()
                }
                .safeAreaInset(edge: .bottom) {
                    ZStack {
                        HStack(spacing: 10) {
                            Spacer()
                            if isWorkoutRunning {
                                Button {
                                    withAnimation(.easeInOut(duration: 0.5)) {
                                        showStats = true
                                    }
                                } label: {
                                    Image(systemName: "pause")
                                        .frame(width: 30, height: 30)
                                }
                                .buttonStyle(.bordered)
                                .matchedGeometryEffect(id: "Pause Button", in: namespace)
                            }
                            Spacer()
                        }
                        HStack {
                            Spacer()
                            Button {
                                withAnimation(.easeInOut(duration: 0.5)) {
                                    showStats = true
                                }
                            } label: {
                                Image(systemName: "chart.xyaxis.line")
                                    .frame(width: 30, height: 30)
                            }
                            .buttonStyle(.bordered)
                            .matchedGeometryEffect(id: "Graph button", in: namespace)
                        }
                    }
                    .padding()
                    .background(.thinMaterial)
                }
                .mapStyle(.hybrid(elevation: .realistic, showsTraffic: true))
                .transition(.slide)
                .mapControlVisibility(.visible)
                .mapScope(mapscope)
                .task {
                    print("this is running")
                    try? await locationManager.requestUserAuthorization()
                    try? await locationManager.startCurrentLocationUpdates()
                }
            }
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
                .safeAreaInset(edge: .bottom) {
                    ZStack {
                        HStack(spacing: 10) {
                            Spacer()
                            if isWorkoutRunning {
                                Button {
                                    withAnimation(.easeInOut(duration: 0.5)) {
                                        showStats = true
                                    }
                                } label: {
                                    Image(systemName: "pause")
                                        .frame(width: 30, height: 30)
                                }
                                .buttonStyle(.bordered)
                                .matchedGeometryEffect(id: "Pause Button", in: namespace)
                            }
                            Spacer()
                        }
                        HStack {
                            Spacer()
                            Button {
                                withAnimation(.easeInOut(duration: 0.5)) {
                                    showStats = false
                                }
                            } label: {
                                Image(systemName: "chart.xyaxis.line")
                                    .frame(width: 30, height: 30)
                            }
                            .buttonStyle(.borderedProminent)
                            .matchedGeometryEffect(id: "Graph button", in: namespace)
                        }
                    }
                    .padding()
                    .background(.thinMaterial)
                }
            }
            .transition(.slide)
        }
    }
}

#Preview {
    MapTrackingView()
}

