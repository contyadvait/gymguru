import CoreLocation

class NewLocationManager: NSObject, CLLocationManagerDelegate {
    
    // Location manager instance
    private let locationManager = CLLocationManager()
    
    // Variable to store distance travelled
    private var distanceTravelled: CLLocationDistance = 0
    
    // Variable to store the last location when updates were paused
    private var lastKnownLocation: CLLocation?
    
    // Variable to keep track of whether the location updates are paused
    private var isPaused: Bool = false
    
    // Minimum distance change to consider (in meters)
    private let minimumDistanceChange: CLLocationDistance = 10.0
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    // Function to request user authorization
    func requestUserAuthorization() -> Bool {
        locationManager.delegate = self
        
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            return false
        case .authorizedWhenInUse, .authorizedAlways:
            return true
        case .restricted, .denied:
            return false
        @unknown default:
            return false
        }
    }
    
    // Start updating location
    func startLocationUpdates() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
            isPaused = false
        } else {
            print("Location services are disabled")
        }
    }
    
    // Stop updating location
    func stopLocationUpdates() {
        locationManager.stopUpdatingLocation()
    }
    
    // Pause updating location
    func pauseLocationUpdates() {
        isPaused = true
        lastKnownLocation = locationManager.location
    }
    
    // Resume updating location
    func resumeLocationUpdates() {
        isPaused = false
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        } else {
            print("Location services are disabled")
        }
    }
    
    // MARK: CLLocationManagerDelegate Methods
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let newLocation = locations.last else { return }
        
        // Calculate distance travelled since last update if not paused
        if !isPaused, let lastLocation = lastKnownLocation ?? locationManager.location {
            let distance = newLocation.distance(from: lastLocation)
            if distance >= minimumDistanceChange {
                distanceTravelled += distance
                lastKnownLocation = newLocation
            }
        } else {
            lastKnownLocation = newLocation
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error updating location: \(error.localizedDescription)")
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            startLocationUpdates()
        case .notDetermined, .restricted, .denied:
            stopLocationUpdates()
        @unknown default:
            stopLocationUpdates()
        }
    }
    
    // Get total distance travelled in kilometers
    func getTotalDistanceTravelled() -> CLLocationDistance {
        return distanceTravelled / 1000 // Convert from meters to kilometers
    }
}
