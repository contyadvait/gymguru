//
//  MapTrackingView.swift
//  gymguru
//
//  Created by Milind Contractor on 23/11/23.
//

import SwiftUI
import MapKit
import CoreLocation
import CoreMotion

struct TimerDisplayObject {
    var seconds: Int = 0
    var minutes: Int = 0
    var hours: Int = 0
    
    var display: String {
        if self.seconds == 0 {
            "\(String(format: "%02d", self.hours)):\(String(format: "%02d", self.minutes)):00"
        } else {
            "\(String(format: "%02d", self.hours)):\(String(format: "%02d", self.minutes)):\(String(format: "%02d", self.seconds))"
        }
    }
    
    var timeMinuteCalculator: Float { Float(hours*60+seconds/60+minutes) }
}

struct MapTrackingView: View {
    @State var showStats = false
    @State var isTimerRunning = false
    @State var timer: Timer?
    @Namespace var namespace
    @State var position: MapCameraPosition = .automatic
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 0, longitude: 0),
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    )
    @Namespace var mapscope
    @State private var distance: Double = 0
    @State var locationManager = NewLocationManager(distanceTraveled: 0.0)
    @State var distanceTravelled: Double = 0.0
    let motionManager = CMMotionManager()
    let updateInterval = 0.1
    @State var speed = 0.0
    @State var timeElapsed: TimerDisplayObject = TimerDisplayObject()
    @State var timerDisplay = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @Binding var userData: UserInfo
    @Environment(\.dismiss) var dismiss
    @State var showAlert = false
    @Binding var exercise: Exercise
    
    func startMotionUpdates() {
        if motionManager.isAccelerometerAvailable {
            motionManager.startDeviceMotionUpdates(to: .main) { (data, error) in
                if let data = data {
                    let userAcceleration = data.userAcceleration
                    let acceleration = sqrt(userAcceleration.x * userAcceleration.x + userAcceleration.y * userAcceleration.y + userAcceleration.z * userAcceleration.z)
                    speed = acceleration * Double(updateInterval)
                }
            }
        }
    }
    
    func stopMotionUpdates() {
        motionManager.stopDeviceMotionUpdates()
        speed = 0.0
    }
    
    var buttons: some View {
        HStack(spacing: 10) {
            HStack(spacing: 10) {
                Button {
                    showAlert = true
                } label: {
                    Image(systemName: "stop.fill")
                }
                Spacer()
                if isTimerRunning {
                    Button {
                        stopMotionUpdates()
                        isTimerRunning = false
                    } label: {
                        Image(systemName: "pause.fill")
                            .frame(width: 30, height: 30)
                    }
                    .buttonStyle(.bordered)
                    .matchedGeometryEffect(id: "Pause Button", in: namespace)
                } else {
                    Button {
                        locationManager.startUpdatingLocation()
                        startMotionUpdates()
                        isTimerRunning = true
                        timeElapsed.seconds -= 1
                    } label: {
                        Image(systemName: "play.fill")
                            .frame(width: 30, height: 30)
                    }
                    .buttonStyle(.bordered)
                    .matchedGeometryEffect(id: "Stop Button", in: namespace)
                }
                Spacer()
            }
        }
    }
    
    var body: some View {
        Group {
            if !showStats {
                VStack {
                    VStack {
                        Map(position: $position, scope: mapscope) {
                        UserAnnotation()
                            ForEach(locations, id: \.id) { location in
                                Marker(location.name, systemImage: location.icon, coordinate: location.location)
                                    .tint(location.colour)
                            }
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
                            buttons
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
                        Text(timeElapsed.display)
                            .font(.system(size: 55))
                            .fontWidth(.expanded)
                        Text("TIME")
                            .font(.system(size: 20))
                            .fontWidth(.expanded)
                        Divider()
                        Text("\(Int(speed*3.6)) km/h")
                            .font(.system(size: 55))
                            .fontWidth(.expanded)
                        Text("SPEED")
                            .font(.system(size: 20))
                            .fontWidth(.expanded)
                        Divider()
                        //                            if Float(locationManager.distanceTraveled)/timeElapsed.timeMinuteCalculator < 0 {
                        //                                Text("\(Float(locationManager.distanceTraveled)/timeElapsed.timeMinuteCalculator) km/h")
                        //                                    .font(.system(size: 55))
                        //                                    .fontWidth(.expanded)
                        //                                Text("AVERAGE KM/H")
                        //                                    .font(.system(size: 20))
                        //                                    .fontWidth(.expanded)
                        //                                Divider()
                        //                            }
                        Text("\(String(locationManager.distanceTraveled)) km")
                            .font(.system(size: 55))
                            .fontWidth(.expanded)
                        Text("DISTANCE")
                            .font(.system(size: 20))
                            .fontWidth(.expanded)
                        Spacer()
                    }
                    .safeAreaInset(edge: .bottom) {
                        ZStack {
                            buttons
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
        .onReceive(timerDisplay) { _ in
            if isTimerRunning {
                timeElapsed.seconds += 1
                if timeElapsed.seconds == 60 {
                    timeElapsed.seconds = 0
                    timeElapsed.minutes += 1
                    if timeElapsed.minutes == 60 {
                        timeElapsed.minutes = 0
                        timeElapsed.hours += 1
                    }
                }
            }
        }
        .alert("Are you sure you want to end this workout?", isPresented: $showAlert) {
            Button("OK", role: .destructive) {
                
                for (challengeIndex, challenge) in userData.challengeData.enumerated() {
                    for (workoutIndex, workout) in challenge.challengeItems.enumerated() {
                        if workout.workoutItem == exercise {
                            userData.challengeData[challengeIndex].challengeItems[workoutIndex].completed += Int(locationManager.distanceTraveled)
                        }
                    }
                }
                dismiss()
            }
            
            Button("Cancel", role: .cancel) {  }
        }
    }
}
