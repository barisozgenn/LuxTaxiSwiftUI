//
//  CountrySelectionCellView.swift
//  BowlShopSwiftUI
//
//  Created by Baris OZGEN on 1.11.2022.
//

import SwiftUI

struct CountrySelectionCellView: View {
    var country: CountriesQuery.Data.Country
    @Binding var selectedCountry: CountriesQuery.Data.Country
    @State private var isSelected: Bool = false
    
    var body: some View {
        HStack{
            Text(country.emoji)
            Text(country.name)
            Spacer()
            Text("+\(country.phone)")
                .fontWeight(.semibold)
            checkboxView
        }
        .foregroundColor(Color(.darkGray))
        .frame(height: 50)
        /*.onTapGesture {
            isSelected.toggle()
            if isSelected {
                selectedCountry = country
            }
        }*/
        .onAppear{
            isSelected = selectedCountry.code == country.code ? true : false
        }
        .onChange(of: selectedCountry.code) { tagCountryCode in
            isSelected = selectedCountry.code == country.code ? true : false
        }
    }
    
    private var checkboxView: some View {
        HStack {
            Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundColor(isSelected ? .cyan : .gray)
                .font(.system(size: 20, weight: .bold, design: .default))
        }
    }
}
