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
import DeviceKit

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
    @State var locationManager = NewLocationManager()
    let motionManager = CMMotionManager()
    let updateInterval = 0.1
    @State var speed = 0.0
    @State var timeElapsed: TimerDisplayObject = TimerDisplayObject()
    @State var timerDisplay = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @Binding var userData: UserInfo
    @Environment(\.dismiss) var dismiss
    @State var showAlert = false
    @Binding var exercise: Exercise
    @State var issues = false
    @AppStorage("locationAccessStatus") var locationAccessStatus = false
    @State var keepScreenOn = true
    @State var iphoneSFSymbol: String = ""
    
    func startMotionUpdates() {
        if motionManager.isAccelerometerAvailable {
            motionManager.startDeviceMotionUpdates(to: .main) { (data, error) in
                if let data = data {
                    let userAcceleration = data.userAcceleration
                    let acceleration = sqrt(userAcceleration.x * userAcceleration.x + userAcceleration.y * userAcceleration.y + userAcceleration.z * userAcceleration.z)
                    speed = speed + acceleration * Double(updateInterval)
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
                        locationManager.startLocationUpdates()
                        startMotionUpdates()
                        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
                            speed = 0
                        }
                        isTimerRunning = true
                        timeElapsed.seconds -= 1
                    } label: {
                        Image(systemName: "play.fill")
                            .frame(width: 30, height: 30)
                    }
                    .buttonStyle(.bordered)
                    .matchedGeometryEffect(id: "Play Button", in: namespace)
                }
                Spacer()
            }
            .onAppear {
                if Device.current.isOneOf([.iPhone14Pro, .iPhone14ProMax, .iPhone15, .iPhone15Pro, .iPhone15Plus, .iPhone15ProMax]) {
                    iphoneSFSymbol = "iphone.gen3"
                } else if Device.current.isOneOf([.iPhoneSE2, .iPhoneSE3]) {
                    iphoneSFSymbol = "iphone.gen1"
                } else {
                    iphoneSFSymbol = "iphone.gen2"
                }
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
                    .safeAreaInset(edge: .top) {
                        
                        HStack {
//                            Button {
//                                keepScreenOn.toggle()
//                            } label: {
//                                Image(systemName: keepScreenOn ? "apps.iphone" : iphoneSFSymbol)
//                                    .frame(width: 20, height: 20)
//                            }
//                            .transition(.symbolEffect)
//                            .buttonStyle(.bordered)
//                            .matchedGeometryEffect(id: "Keep button", in: namespace)
//                            .frame(width: 30, height: 30)
                            Spacer()
                            Button {
                                showAlert = true
                            } label: {
                                Image(systemName: "stop.fill")
                                    .frame(width: 30, height: 30)
                            }
                            .buttonStyle(.bordered)
                            .matchedGeometryEffect(id: "Stop button", in: namespace)
                            .frame(width: 30, height: 30)
                        }
                        .padding()
                        .background(.thinMaterial)
                        
                    }
                    .mapStyle(.hybrid(elevation: .realistic, showsTraffic: true))
                    .transition(.slide)
                    .mapControlVisibility(.visible)
                    .mapScope(mapscope)
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
                        Text("\(String(format: "%.2f" , locationManager.getTotalDistanceTravelled())) km")
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
                    .safeAreaInset(edge: .top) {
                        
                        HStack {
//                            Button {
//                                keepScreenOn.toggle()
//                            } label: {
//                                Image(systemName: keepScreenOn ? "apps.iphone" : iphoneSFSymbol)
//                                    .frame(width: 20, height: 20)
//                            }
//                            .transition(.symbolEffect)
//                            .buttonStyle(.bordered)
//                            .matchedGeometryEffect(id: "Keep button", in: namespace)
//                            .frame(width: 30, height: 30)
                            Spacer()
                            Button {
                                showAlert = true
                            } label: {
                                Image(systemName: "stop.fill")
                                    .frame(width: 30, height: 30)
                            }
                            .buttonStyle(.bordered)
                            .matchedGeometryEffect(id: "Stop button", in: namespace)
                            .frame(width: 30, height: 30)
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
                            userData.challengeData[challengeIndex].challengeItems[workoutIndex].completed += Float(locationManager.getTotalDistanceTravelled())
                        }
                    }
                }
                
                for (dailyChallengeIndex, dailyChallenge) in userData.dailyChallenge.challengeItems.enumerated() {
                    if dailyChallenge.workoutItem == exercise {
                        userData.dailyChallenge.challengeItems[dailyChallengeIndex].completed += Float(locationManager.getTotalDistanceTravelled())
                    }
                }
                dismiss()
            }
            
            Button("Cancel", role: .cancel) {  }
        }
        .sheet(isPresented: $issues) {
            Text("Why is my tracking not working?")
            Text("Please check your app settings as you may have disabled location access for this app or your location services has been turned off. Tracking may also not work because of location accuracy issues in places deep underground (e.g.: tunnels, etc.)")
        }
    }
}
