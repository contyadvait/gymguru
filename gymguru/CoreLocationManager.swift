import Foundation
import MapKit
import CoreMotion
import CoreLocation

class NewLocationManager: NSObject, CLLocationManagerDelegate, ObservableObject {
    @Published var location: CLLocation? = nil

    private let locationManager = CLLocationManager()

    func requestUserAuthorization() async throws {
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.distanceFilter = kCLDistanceFilterNone
    }

    func startCurrentLocationUpdates() async throws {
        for try await locationUpdate in CLLocationUpdate.liveUpdates() {
            guard let location = locationUpdate.location else { return }

            self.location = location
        }
    }

    func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }

    private var previousLocation: CLLocation?
    @Published var distanceTraveled: Double = 0

    func updateDistance() {
        if let currentLocation = location, let previousLocation = previousLocation {
            let distanceBetweenLocations = currentLocation.distance(from: previousLocation)
            distanceTraveled += distanceBetweenLocations
        }
        previousLocation = location
    }

    init(location: CLLocation? = nil, previousLocation: CLLocation? = nil, distanceTraveled: Double) {
        self.location = location
        self.previousLocation = previousLocation
        self.distanceTraveled = distanceTraveled

        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        self.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentLocation = locations.first else { return }

        updateDistance()
    }
    
    var locationTimer: Timer?
    
    func startTimer() {
      // Invalidate the timer if it exists
      locationTimer?.invalidate()
      // Start the timer with a 2-second interval
      locationTimer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(saveLocation), userInfo: nil, repeats: true)
    }
    
    func stopTimer() {
      // Invalidate the timer
      locationTimer?.invalidate()
    }
    
    @objc func saveLocation() {
      // Get the current location from the location manager
      guard let currentLocation = self.location else { return }
      // Save the location data to UserDefaults or any other storage you prefer
      let locationData = NSKeyedArchiver.archivedData(withRootObject: currentLocation)
      UserDefaults.standard.set(locationData, forKey: "savedLocation")
      // You can also compare the current location with the previous location to calculate the distance changed
      if let previousLocationData = UserDefaults.standard.object(forKey: "savedLocation") as? Data,
         let previousLocation = NSKeyedUnarchiver.unarchiveObject(with: previousLocationData) as? CLLocation {
        let distance = currentLocation.distance(from: previousLocation)
          self.distanceTraveled += distance
      }
    }

}
