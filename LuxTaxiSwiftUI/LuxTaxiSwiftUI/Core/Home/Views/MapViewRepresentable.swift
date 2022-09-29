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
    //let locationManager = LocationManager.shared
    @Binding var mapState : MapViewState
    
    @EnvironmentObject var locationSearchListViewModel : LocationSearchListViewModel
    
    func makeUIView(context: Context) -> some UIView {
        mapView.delegate = context.coordinator
        mapView.isRotateEnabled = false
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        
        /* let configuration = MKStandardMapConfiguration(elevationStyle: .realistic, emphasisStyle: .default)
         configuration.showsTraffic = true
         
         mapView.preferredConfiguration = configuration*/
        
        // mapType will be depracated for next versions
        //mapView.mapType = .mutedStandard
        
        return mapView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        print("DEBUG: map view State -> \(mapState)")
        
        switch mapState {
        case .noInput:
            context.coordinator.clearMapViewAndRecenter()
            break
        case .searchingForLocation:
            break
        case .locationSelected:
            
            if let selectedLocationCoordinate = locationSearchListViewModel.selectedLocation?.coordinate {
                
                context.coordinator.addAndSelectAnnotation(withCoordinate: selectedLocationCoordinate)
                context.coordinator.configureRoutePolyline(withDestinationCordinate: selectedLocationCoordinate)
                
                print("DEBUG: selected Location on map -> \(selectedLocationCoordinate)")
                break
            }
        case .routeCreated :
            break
        }
    }
    
    func makeCoordinator() -> MapCoordinator {
        return MapCoordinator(parent: self)
    }
}

extension MapViewRepresentable {
    
    // MARK: - middle man between UIKit and UIView
    class MapCoordinator: NSObject, MKMapViewDelegate {
        
        // MARK: - Properties
        
        let parent : MapViewRepresentable
        var userLocationCoordinate : CLLocationCoordinate2D?
        var currentUserRegion : MKCoordinateRegion?
        
        // MARK: - Lifecycle
        init(parent: MapViewRepresentable) {
            self.parent = parent
            super.init()
        }
        
        // MARK: - MKMapViewDelegate
        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
            
            self.userLocationCoordinate = userLocation.coordinate
            
            let userRegion = MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude),
                span: MKCoordinateSpan(latitudeDelta: 0.07, longitudeDelta: 0.07))
            
            self.currentUserRegion = userRegion
            
            parent.mapView.setRegion(userRegion, animated: true)
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            
            let annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "placemark")
            
            if annotation.title != "My Location" {
                annotationView.markerTintColor = UIColor(Color.theme.goldBackgroundColor)
                return annotationView
            }
            
            return nil
        }
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            
            let polyLine = MKPolylineRenderer(overlay: overlay)
            polyLine.strokeColor = UIColor(Color.theme.goldBackgroundColor.opacity(0.92))
            polyLine.lineWidth = 7
            
            return polyLine
        }
        
        // MARK: - Helpers
        
        func addAndSelectAnnotation(withCoordinate coordinate: CLLocationCoordinate2D) {
            
            parent.mapView.removeAnnotations(parent.mapView.annotations)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            
            parent.mapView.addAnnotation(annotation)
            parent.mapView.selectAnnotation(annotation, animated: true)
            
            //parent.mapView.showAnnotations(parent.mapView.annotations, animated: true)
        }
        
        func configureRoutePolyline(withDestinationCordinate coordinate: CLLocationCoordinate2D){
            
            guard let userLocationCoordinate = self.userLocationCoordinate else { return }
            
            parent.locationSearchListViewModel.getDestinationRoute(
                from: userLocationCoordinate,
                to: coordinate) { route in
                    
                    self.parent.mapView.addOverlay(route.polyline)
                    self.parent.mapState = .routeCreated
                    
                    let mapRect = self.parent.mapView.mapRectThatFits(
                        route.polyline.boundingMapRect,
                        edgePadding: .init(top: 114, left: 29, bottom: 529, right: 29))
                    
                    self.parent.mapView.setRegion(MKCoordinateRegion(mapRect), animated: true)
                }
        }
        
        func clearMapViewAndRecenter() {
            parent.mapView.removeAnnotations(parent.mapView.annotations)
            parent.mapView.removeOverlays(parent.mapView.overlays)
            
            if let currentUserRegion = currentUserRegion {
                parent.mapView.setRegion(currentUserRegion, animated: true)
            }
        }
    }
}
