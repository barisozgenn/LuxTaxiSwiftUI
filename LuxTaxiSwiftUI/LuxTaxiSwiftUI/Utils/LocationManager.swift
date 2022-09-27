//
//  LocationManager.swift
//  LuxTaxiSwiftUI
//
//  Created by Baris OZGEN on 27.09.2022.
//

import CoreLocation

class LocationManager: NSObject, ObservableObject {
    private let locationManager = CLLocationManager()
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard !locations.isEmpty else { return }
        print("DEBUG: location -> \(locations.first ?? CLLocation(latitude: 0, longitude: 0))")
        locationManager.stopUpdatingLocation()
    }
}

