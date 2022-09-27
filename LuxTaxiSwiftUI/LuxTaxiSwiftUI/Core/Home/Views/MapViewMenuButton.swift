//
//  MapViewMenuButton.swift
//  LuxTaxiSwiftUI
//
//  Created by Baris OZGEN on 27.09.2022.
//

import SwiftUI

struct MapViewMenuButton: View {
    var body: some View {
        Button {
                
            } label: {
                Image(systemName: "line.3.horizontal")
                    .font(.system(size: 29 , weight: .bold))
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
        MapViewMenuButton()
    }
}
