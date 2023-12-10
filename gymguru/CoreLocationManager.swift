import CoreLocation

class NewLocationManager: NSObject, CLLocationManagerDelegate {
    
    // Location manager instance
    private let locationManager = CLLocationManager()
    
    // Variable to store distance travelled
    private var distanceTravelled: CLLocationDistance = 0
    
    // Function to request user authorization
    func requestUserAuthorization() -> Bool {
        locationManager.delegate = self
        
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            return false
        case .authorizedWhenInUse, .authorizedAlways:
            return true
        case .restricted, .denied:
            return false
        default:
            return false
        }
    }
    
    // Start updating location
    func startLocationUpdates() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        } else {
            print("Location services are disabled")
        }
    }
    
    // Stop updating location
    func stopLocationUpdates() {
        locationManager.stopUpdatingLocation()
    }
    
    // MARK: CLLocationManagerDelegate Methods
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let newLocation = locations.last else { return }
        
        // Calculate distance travelled since last update
        if let lastLocation = locationManager.location {
            let distance = newLocation.distance(from: lastLocation)
            distanceTravelled += distance
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error updating location: \(error.localizedDescription)")
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() == .authorizedAlways {
            startLocationUpdates()
        } else {
            stopLocationUpdates()
        }
    }
    
    // Get total distance travelled
    func getTotalDistanceTravelled() -> CLLocationDistance {
        return distanceTravelled
    }
}
