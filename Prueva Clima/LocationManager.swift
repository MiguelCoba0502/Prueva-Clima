//
//  LocationManager.swift
//  Prueva Clima
//
//  Created by Eduardo Coba on 05/11/24.
//

import Foundation
import CoreLocation
import Combine

class LocationManager: NSObject, ObservableObject{
    @Published var currentLocation: CLLocation?
    private let locationManager = CLLocationManager()
    private var cancellables = Set<AnyCancellable>()
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    // Metodo para solicitar la ubicacion
    func requesLocartion(){
        locationManager.requestLocation()
    }
}

extension LocationManager: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {return}
        self.currentLocation = location
        locationManager.stopUpdatingLocation()
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to get user location: \(error)")
        
    }
}
