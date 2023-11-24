import Foundation
import MapKit

@Observable
class NewLocationManager: NSObject, CLLocationManagerDelegate {
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
    
    func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }
    
    private var previousLocation: CLLocation?
    var distanceTraveled: Double = 0

    init(location: CLLocation? = nil, previousLocation: CLLocation? = nil, distanceTraveled: Double) {
        self.location = location
        self.previousLocation = previousLocation
        self.distanceTraveled = distanceTraveled
    }
    
    override init() {
          super.init()
         locationManager.delegate = self
          locationManager.desiredAccuracy = kCLLocationAccuracyBest
          locationManager.requestWhenInUseAuthorization()
      }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentLocation = locations.first else { return }

        if let previousLocation = previousLocation {
            let distanceBetweenLocations = currentLocation.distance(from: previousLocation)
            distanceTraveled += distanceBetweenLocations
        }

        previousLocation = currentLocation
    }

}
