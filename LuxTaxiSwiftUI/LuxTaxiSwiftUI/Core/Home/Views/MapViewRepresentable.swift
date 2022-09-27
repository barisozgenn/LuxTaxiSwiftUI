//
//  MapViewRepresentable.swift
//  LuxTaxiSwiftUI
//
//  Created by Baris OZGEN on 27.09.2022.
//

import SwiftUI
import MapKit

struct MapViewRepresentable: UIViewRepresentable {
    
    
    let mapView = MKMapView()
    let locationManager = LocationManager()
    
    func makeUIView(context: Context) -> some UIView {
        mapView.delegate = context.coordinator
        mapView.isRotateEnabled = false
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        
        return mapView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
    func makeCoordinator() -> MapCoordinator {
        return MapCoordinator(parent: self)
    }
}

extension MapViewRepresentable {
    
    // middle man between UIKit and UIView
    class MapCoordinator: NSObject, MKMapViewDelegate {
        let parent : MapViewRepresentable
        
        init(parent: MapViewRepresentable) {
            self.parent = parent
            super.init()
        }
        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
            let userRegion = MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude),
                span: MKCoordinateSpan(latitudeDelta: 0.07, longitudeDelta: 0.07))
            
            parent.mapView.setRegion(userRegion, animated: true)
        }
        
    }
}
