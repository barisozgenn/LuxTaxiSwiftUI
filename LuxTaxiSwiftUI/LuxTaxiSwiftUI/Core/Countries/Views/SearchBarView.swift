//
//  SearchBarView.swift
//  BowlShopSwiftUI
//
//  Created by Baris OZGEN on 29.10.2022.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchText : String
    
    var body: some View {
        
        HStack{
            // SearchBar
            HStack{
                Image(systemName: "magnifyingglass")
                    .foregroundColor(Color(.gray))
                
                TextField("Search...", text:$searchText)
                    .disableAutocorrection(true)
                    .foregroundColor(Color(.darkGray))
                    .overlay(
                        Image(systemName: "xmark.circle.fill")
                            .padding()
                            .offset(x: 14)
                            .foregroundColor(Color(.darkGray))
                            .opacity(
                                searchText.isEmpty ?
                                0 : 0.6)
                            .onTapGesture {
#if os(iOS)
                                UIApplication.shared.endEditing()
#endif
                                searchText = ""
                            }
                        ,alignment: .trailing
                    )
                    .textFieldStyle(.plain)
            }
            .font(.headline)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 14)
                    .fill(.white)
                    .shadow(
                        color: .black.opacity(0.29),
                        radius: 7,x: 0, y: 7
                    )
            )
        }
        .padding(.horizontal)
        
        
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(searchText: .constant("asd"))
    }
}
