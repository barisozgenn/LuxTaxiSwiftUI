//
//  MapViewMenuButton.swift
//  LuxTaxiSwiftUI
//
//  Created by Baris OZGEN on 27.09.2022.
//

import SwiftUI

struct MapViewMenuButton: View {
    
    @Binding var showLocationSearchListView: Bool
    
    var body: some View {
        Button {
            withAnimation(.spring()){
                showLocationSearchListView.toggle()
            }
        } label: {
            Image(systemName: showLocationSearchListView ? "arrow.left" : "line.3.horizontal")
                .font(.system(size: 29, weight: .bold))
                .padding()
                .foregroundColor(Color.theme.primaryTextColor)
                .padding(.all, 7)
                .background(Color.theme.carItemBackgroundColor)
                .clipShape(Circle())
                .shadow(
                    color: .black.opacity(0.58),
                    radius: 14,x: 0, y: 7
                )
        }
        .frame( maxWidth: .infinity, alignment: .leading)
        
        .padding(.leading, 4)
        .padding(.top)
    }
}

struct MapViewMenuButton_Previews: PreviewProvider {
    static var previews: some View {
        MapViewMenuButton(showLocationSearchListView: .constant(true))
    }
}
