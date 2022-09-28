//
//  HomeView.swift
//  LuxTaxiSwiftUI
//
//  Created by Baris OZGEN on 27.09.2022.
//

import SwiftUI

struct HomeView: View {
    
    @State private var showLocationSearchListView = false
    
    var body: some View {
        ZStack(alignment: .top){
            MapViewRepresentable()
                .ignoresSafeArea()
            
            locationSearchViews
            
            MapViewMenuButton(showLocationSearchListView: $showLocationSearchListView)
          
        }
        .background(Color.theme.appBackgroundColor)
        
    }
}

extension HomeView{
    
    private var locationSearchViews: some View {
        
        ZStack{
            if !showLocationSearchListView {
                LocationSearchBoxView()
                    .onTapGesture {
                        withAnimation(.spring()){
                            showLocationSearchListView.toggle()
                        }
                    }
            } else {
                LocationSearchListView(showLocationSearchListView: $showLocationSearchListView)
            }
        }
    }
}
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
