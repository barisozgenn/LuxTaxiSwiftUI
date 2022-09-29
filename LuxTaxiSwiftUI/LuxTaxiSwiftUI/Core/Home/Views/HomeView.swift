//
//  HomeView.swift
//  LuxTaxiSwiftUI
//
//  Created by Baris OZGEN on 27.09.2022.
//

import SwiftUI

struct HomeView: View {
    
    @State private var mapState = MapViewState.noInput
    @EnvironmentObject var locationViewModel : LocationSearchListViewModel
    
    var body: some View {
            ZStack(alignment: .top){
                MapViewRepresentable(mapState: $mapState)
                    .ignoresSafeArea()
                
                locationSearchViews
                    //.transition(.move(edge: .bottom))
                
                MapViewMenuButton(mapState: $mapState)
              
            }
            .background(Color.theme.appBackgroundColor)
            .onReceive(LocationManager.shared.$userLocation) { location in
                if let location = location {
                    
                    locationViewModel.userLocation = location
                    
                    print("DEBUG: user location in HomeView -> \(location)")
                }
            }
       
    }
}

extension HomeView{
    
    private var locationSearchViews: some View {
        
        ZStack{
            switch mapState {
             
            case .noInput :
                LocationSearchBoxView()
                    .onTapGesture {
                        withAnimation(.spring()){
                            mapState = .searchingForLocation
                        }
                    }
            case .searchingForLocation :
                LocationSearchListView(mapState: $mapState)
            case .locationSelected :
                  TripRequestView()
            }
        }
    }
}
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
