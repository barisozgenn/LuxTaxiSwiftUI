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
    @EnvironmentObject var launchScreenManager : LaunchScreenViewModel
    
    @State private var isLauncScrenAnimEnd = false
    
    var body: some View {
            ZStack(alignment: .top){
                
                SideMenuView()
                
                pageContainer
                  
                    
               
                MapViewMenuButton(mapState: $mapState)
              
            }
            .background(Color.theme.appBackgroundColor)
            .onReceive(LocationManager.shared.$userLocation) { location in
                if let location = location {
                    
                    locationViewModel.userLocation = location
                    
                    print("DEBUG: user location in HomeView -> \(location)")
                }
            }
            .onAppear{
                DispatchQueue
                    .main
                    .asyncAfter(deadline: .now() + 1.7 ) {
                        launchScreenManager.dismiss()
                        isLauncScrenAnimEnd = true

                    }
            }
       
    }
}

extension HomeView{
    
    private var pageContainer: some View {
        
        ZStack{
            MapViewRepresentable(mapState: $mapState)
                .ignoresSafeArea()
            
            locationSearchViews
                //.transition(.move(edge: .bottom))
        }
        .cornerRadius(mapState == .showMenu ? 58 : 0)
        .shadow(
            color: .black.opacity(mapState == .showMenu ? 0.58 : 0),
            radius: mapState == .showMenu ? 14 : 0, x: mapState == .showMenu ? 0 : -14, y: mapState == .showMenu ? 14 : 0
        )
        .offset(x: mapState == .showMenu ? 229 : 0, y: mapState == .showMenu ? 14 : 0)
        .scaleEffect(mapState == .showMenu ? 0.7 : 1)
        .ignoresSafeArea()
    }
    
    private var locationSearchViews: some View {
        
        ZStack{
            switch mapState {
             
            case .noInput, .showMenu :
                if isLauncScrenAnimEnd {
                    LocationSearchBoxView()
                        .onTapGesture {
                            withAnimation(.spring()){
                                mapState = .searchingForLocation
                            }
                        }
                }
            case .searchingForLocation :
                LocationSearchListView(mapState: $mapState)
                
            case .locationSelected, .routeCreated :
                  TripRequestView()
            }
        }
    }
}
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(LaunchScreenViewModel())
    }
}
