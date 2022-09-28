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
    @Published var selectedLocationCoordinate : CLLocationCoordinate2D?
    
    private let searchCompleter = MKLocalSearchCompleter()
    var queryFragment : String = "" {
        didSet {
            searchCompleter.queryFragment = queryFragment
            print("DEBUG: destination queryFragment -> \(queryFragment)")
        }
    }
    
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
            self.selectedLocationCoordinate = placemarkCoordinate
            
            print("DEBUG: selected Placemark Coordinate -> \(placemarkCoordinate)")

        }
    }
    
    func locationSearch(forLocalSearchCompletion localSearch: MKLocalSearchCompletion, completion: @escaping MKLocalSearch.CompletionHandler ){
        
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = localSearch.title.appending(localSearch.subtitle)
        
        let search = MKLocalSearch(request: searchRequest)
        search.start(completionHandler: completion)
    }
    
}

// MARK: - MKLocalSearchCompleterDelegate

extension LocationSearchListViewModel : MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.results = completer.results
    }
}
