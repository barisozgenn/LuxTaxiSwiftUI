//
//  LocationSearchViewModel.swift
//  LuxTaxiSwiftUI
//
//  Created by Baris OZGEN on 28.09.2022.
//

import Foundation
import MapKit

class LocationSearchListViewModel: NSObject, ObservableObject {
    
    // MARK: - Properties
    
    @Published var results = [MKLocalSearchCompletion]()
    @Published var selectedLocation : LocationModel?
    
    @Published var pickingUpTime : String?
    @Published var droppingOffTime : String?

    private let searchCompleter = MKLocalSearchCompleter()
    var queryFragment : String = "" {
        didSet {
            searchCompleter.queryFragment = queryFragment
            print("DEBUG: destination queryFragment -> \(queryFragment)")
        }
    }
    
    var userLocation : CLLocationCoordinate2D?
    
    // MARK: - Lifecycle
    
    override init() {
        super.init()
        searchCompleter.delegate = self
        searchCompleter.queryFragment = "Near" + queryFragment
    }
    
    // MARK: - Helpers
    
    func selectLocation(_ localSearch: MKLocalSearchCompletion){
        
        locationSearch(forLocalSearchCompletion: localSearch) { response, error in
            
            if let error = error {
                print("DEBUG: location search error -> \(error.localizedDescription)")
                return
            }
            
            guard let mapItem = response?.mapItems.first else { return }
            
            let placemarkCoordinate = mapItem.placemark.coordinate
            
            self.selectedLocation = LocationModel(title: localSearch.title, coordinate: placemarkCoordinate)
            
            print("DEBUG: selected Placemark Coordinate -> \(placemarkCoordinate)")

        }
    }
    
    func locationSearch(forLocalSearchCompletion localSearch: MKLocalSearchCompletion, completion: @escaping MKLocalSearch.CompletionHandler ){
        
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = localSearch.title.appending(localSearch.subtitle)
        
        let search = MKLocalSearch(request: searchRequest)
        search.start(completionHandler: completion)
    }
    
    func calculateTripPrice(forType vechicleType: VehicleType) -> Double {
        guard let destinationCoordinate = selectedLocation?.coordinate else { return 0.0}
        guard let userLocation = self.userLocation else { return 0.0 }
        
        let firstLocation = CLLocation(latitude: userLocation.latitude, longitude: userLocation.longitude)
        let endLocation = CLLocation(latitude: destinationCoordinate.latitude, longitude: destinationCoordinate.longitude)
        
        let tripDistanceInMeter = firstLocation.distance(from: endLocation)

        return vechicleType.calculateFee(forMeters: tripDistanceInMeter)
    }
    
    func getDestinationRoute (from userLocation: CLLocationCoordinate2D,
                              to destination: CLLocationCoordinate2D,
                              completion: @escaping(MKRoute) -> Void ){
        
        let userPlacemark = MKPlacemark(coordinate: userLocation)
        let destinationPlacemark = MKPlacemark(coordinate: destination)
        
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: userPlacemark)
        request.destination = MKMapItem(placemark: destinationPlacemark)
        
        let direction = MKDirections(request: request)
        
        direction.calculate { response, error in
            if let error = error {
                print("DEBUG: direction calculate error -> \(error.localizedDescription)")
                return
            }
            
            guard let route = response?.routes.first else { return }
            self.configureTripTiming(withSeconds: route.expectedTravelTime)
            
            completion(route)
        }
    }
    
    func configureTripTiming(withSeconds expectedTravelTime: Double){
        
        pickingUpTime = Date().shortDate()
        droppingOffTime = Date().dropOffDate(addSeconds: expectedTravelTime)
    }
}

// MARK: - MKLocalSearchCompleterDelegate

extension LocationSearchListViewModel : MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.results = completer.results
    }
}
