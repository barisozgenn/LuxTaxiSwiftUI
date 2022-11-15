//
//  CountrySelectionViewModel.swift
//  BowlShopSwiftUI
//
//  Created by Baris OZGEN on 1.11.2022.
//

import Foundation
import Combine

class CountrySelectionViewModel : ObservableObject {
    @Published var countries: [CountriesQuery.Data.Country] = []
    @Published var searchText: String = ""
    @Published var selectedCountry: CountriesQuery.Data.Country
    
    //private let dataService = GraphQLNetworkManager.shared
    private let dataService : CountryGraphQLService
    private var cancellables = Set<AnyCancellable>()
    
    
    init(){
        self.selectedCountry = CountriesQuery.Data.Country(code: "DE", name: "Germany", emoji: "🇩🇪", phone: "49")
        self.dataService = CountryGraphQLService(queryType: .countriesForPhone)
        fetchDataSearch()
    }
    
    // it can be used when PassthroughSubject is required for combine without combineLatest or search functions go to CountryGraphQLService and delete init comment to initilaize it
    func fetchData() {
        dataService.countriesPassthroughSubject
            .map({$0.filter({$0.phone.count < 4})})
            .sink { apolloCompletion in
                switch apolloCompletion {
                case .finished : break
                case .failure(let error): print("DEBUG: graphQL Countr API error \(error.localizedDescription)")
                }
            } receiveValue: { [weak self] returnedData in
                self?.countries = returnedData
            }
            .store(in: &cancellables)
    }
    
    func fetchDataSearch(){
        $searchText
            .combineLatest(dataService.$countries)
            .debounce(for: .seconds(0.7), scheduler: DispatchQueue.main)
            .map(searchCountries)
            .sink{[weak self] (searchedCountries) in
                self?.countries = searchedCountries
                
                /*if let selectedCountry = self?.selectedCountry {
                    self?.countries.insert(selectedCountry, at: 0)
                }*/
            }
            .store(in: &cancellables)
    }
    private func searchCountries(text:String, searchedCountries : [CountriesQuery.Data.Country]) -> [CountriesQuery.Data.Country]{
        
        guard !text.isEmpty else {
            return searchedCountries
        }
        
        let lowercasedText = text.lowercased()
        
        let filteredCountries = searchedCountries.filter { (country) -> Bool in
            let condition =
            country.name.lowercased().contains(lowercasedText) ||
            country.code.lowercased().contains(lowercasedText) ||
            country.phone.lowercased().contains(lowercasedText)
            
            return condition
        }
        
        return filteredCountries
    }
    
    func selectCountyCode(selectedCountryCode: String){
        guard let selectedCountry = countries.first(where: {$0.code == selectedCountryCode}) else {return}
        selectCounty(country: selectedCountry)
    }
    private func selectCounty(country: CountriesQuery.Data.Country){
        selectedCountry = country
        //countries.remove(at: 0)
        //countries.insert(selectedCountry, at: 0)
    }
}
