//
//  LocationSearchCell.swift
//  LuxTaxiSwiftUI
//
//  Created by Baris OZGEN on 28.09.2022.
//

import SwiftUI

struct LocationSearchCell: View {
    let locationTitle : String
    let locationDescription : String
    
    var body: some View {
        HStack(alignment: .top){
            
            Image(systemName: "mappin.circle.fill")
                .resizable()
                .foregroundColor(Color.theme.goldBackgroundColor)
                .font(.title)
                .frame(width: 40, height: 40)
                .padding(.top, 2)
            
            VStack(alignment: .leading, spacing: 4){
                Text(locationTitle)
                    .foregroundColor(Color.theme.primaryTextColor)
                    .font(.body)
                    .fontWeight(.semibold )
                Text(locationDescription)
                    .foregroundColor(.gray)
                    .font(.subheadline)
                
                Divider()
                    .padding(.vertical, 7)
            }
            .padding(.leading, 4)
        }
        .padding(.horizontal)
    }
}

struct LocationSearchCell_Previews: PreviewProvider {
    static var previews: some View {
        LocationSearchCell(locationTitle: "Title", locationDescription: "Description")
    }
}
