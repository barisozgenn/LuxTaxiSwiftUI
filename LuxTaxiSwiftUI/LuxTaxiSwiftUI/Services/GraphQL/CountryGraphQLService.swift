//
//  CountryGraphQLService.swift
//  BowlShopSwiftUI
//
//  Created by Baris OZGEN on 1.11.2022.
//

import Foundation
import Combine
import Apollo

class CountryGraphQLService {
    private let dataService = GraphQLNetworkManager.shared
    
    let countriesPassthroughSubject = PassthroughSubject<[CountriesQuery.Data.Country], Error>()
    @Published var  countries : [CountriesQuery.Data.Country] = []
   
    
    var dataSubscription: AnyCancellable?
    
    let queryType : GraphQLQueryType
    
    init(queryType : GraphQLQueryType) {
        self.queryType = queryType
        fetchDataPublished()
        // it can be used when PassthroughSubject is required for combine without combineLatest or search functions
        //fetchDataPassthroughSubject()
    }
    
    func fetchDataPassthroughSubject() {
        
        dataService.apolloClient.fetch(query: CountriesQuery(),  queue: DispatchQueue.main){ [weak self] result in
            switch result {
            case .success(let graphQLCountries):
                if let countries = graphQLCountries.data?.countries {
                    self?.countriesPassthroughSubject.send(countries)
                }
                self?.countriesPassthroughSubject.send(completion: .finished)
            case .failure(let error):
                print("DEBUG: graphQL PassthroughSubject Country API error \(error.localizedDescription)")
                self?.countriesPassthroughSubject.send(completion: .failure(error))
            }
            
        }
    }
    
    func fetchDataPublished() {
        
        dataService.apolloClient.fetch(query: CountriesQuery(),  queue: DispatchQueue.main){ [weak self] result in
            switch result {
            case .success(let graphQLCountries):
                if let countries = graphQLCountries.data?.countries {
                    self?.countries = countries
                }
            case .failure(let error):
                print("DEBUG: graphQL Published Country API error \(error.localizedDescription)")
            }
            
        }
    }
    
    enum GraphQLQueryType {
        case countriesForPhone
        case countriesForDelivery
    }
}
