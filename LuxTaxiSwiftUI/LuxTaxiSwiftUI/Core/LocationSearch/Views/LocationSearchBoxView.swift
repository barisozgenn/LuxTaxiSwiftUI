//
//  LocationSearchBoxView.swift
//  LuxTaxiSwiftUI
//
//  Created by Baris OZGEN on 27.09.2022.
//

import SwiftUI

struct LocationSearchBoxView: View {
    @State private var paddinBottom: CGFloat = 14
    @Binding var searchLocation : String
    
    var body: some View {
        
        HStack{
            // SearchBar
            HStack{
                Image(systemName: "magnifyingglass")
                    .foregroundColor(
                        searchLocation.isEmpty ?
                            .gray : Color.theme.primaryTextColor)
                
                TextField("Where to?", text: $searchLocation)
                    .disableAutocorrection(true)
                    .foregroundColor(Color.theme.primaryTextColor)
                    .overlay(
                        Image(systemName: "xmark.circle.fill")
                            .padding()
                            .offset(x: 14)
                            .foregroundColor(Color.theme.primaryTextColor)
                            .opacity(
                                searchLocation.isEmpty ?
                                0 : 0.6)
                            .onTapGesture {
                                UIApplication.shared.endEditing()
                                searchLocation = ""
                            }
                        ,alignment: .trailing
                    )
            }
            .font(.headline)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 14)
                    .fill(Color.theme.carItemBackgroundColor)
                    .shadow(
                        color: .black.opacity(0.58),
                        radius: 14,x: 0, y: 7
                    )
            )
        }
        .onAppear(perform: {
            withAnimation(.default) {
                self.paddinBottom = 72
            }
        })
        
        .frame(maxHeight: .infinity, alignment: .bottom)
        .padding(.horizontal)
        .padding(.bottom, paddinBottom)
        
        
    }
}

struct LocationSearchBoxView_Previews: PreviewProvider {
    static var previews: some View {
        LocationSearchBoxView(searchLocation: .constant(""))
        //.preferredColorScheme(.dark)
    }
}
