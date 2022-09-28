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
    private let searchCompleter = MKLocalSearchCompleter()
    var queryFragment : String = "" {
        didSet {
            searchCompleter.queryFragment = queryFragment
            print("DEBUG: destination queryFragment -> \(queryFragment)")
        }
    }
    
    override init() {
        super.init()
        searchCompleter.delegate = self
        searchCompleter.queryFragment = "Near" + queryFragment
    }
}

// MARK: - MKLocalSearchCompleterDelegate

extension LocationSearchListViewModel : MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.results = completer.results
    }
}
