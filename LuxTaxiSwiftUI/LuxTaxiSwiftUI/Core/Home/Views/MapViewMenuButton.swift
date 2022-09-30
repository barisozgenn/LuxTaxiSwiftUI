//
//  MapViewMenuButton.swift
//  LuxTaxiSwiftUI
//
//  Created by Baris OZGEN on 27.09.2022.
//

import SwiftUI

struct MapViewMenuButton: View {
    
    @Binding var mapState : MapViewState
    @EnvironmentObject var viewModel : LocationSearchListViewModel
    
    var body: some View {
        Button {
            withAnimation(.spring()){
                actionForState(mapState)
            }
        } label: {
            Image(systemName: imageNameForState(mapState))
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

extension MapViewMenuButton {
    func actionForState(_ state: MapViewState) {
        switch state {
            
        case .noInput:
            mapState = .showMenu
        case .searchingForLocation:
            mapState = .noInput
        case .locationSelected, .routeCreated, .showMenu:
            mapState = .noInput
            viewModel.selectedLocation = nil
       
            
        }
    }
    
    func imageNameForState(_ state: MapViewState) -> String {
        switch state {
            
        case .noInput:
            return "line.3.horizontal"
        case .searchingForLocation, .locationSelected, .routeCreated:
            return "arrow.left"
        case .showMenu:
            return "xmark"
        }
    }
}
struct MapViewMenuButton_Previews: PreviewProvider {
    static var previews: some View {
        MapViewMenuButton(mapState: .constant(.noInput))
    }
}
