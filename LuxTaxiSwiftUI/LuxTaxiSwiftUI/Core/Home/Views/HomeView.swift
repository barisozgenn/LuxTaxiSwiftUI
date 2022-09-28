//
//  HomeView.swift
//  LuxTaxiSwiftUI
//
//  Created by Baris OZGEN on 27.09.2022.
//

import SwiftUI

struct HomeView: View {
    
    @State private var mapState = MapViewState.noInput
    
    var body: some View {
        ZStack(alignment: .top){
            MapViewRepresentable(mapState: $mapState)
                .ignoresSafeArea()
            
            locationSearchViews
            
            MapViewMenuButton(mapState: $mapState)
          
        }
        .background(Color.theme.appBackgroundColor)
        
    }
}

extension HomeView{
    
    private var locationSearchViews: some View {
        
        ZStack{
            if mapState == .noInput {
                LocationSearchBoxView()
                    .onTapGesture {
                        withAnimation(.spring()){
                            mapState = .searchingForLocation
                        }
                    }
            } else if mapState == .searchingForLocation {
                LocationSearchListView(mapState: $mapState)
            }
        }
    }
}
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
