//
//  LuxTaxiSwiftUIApp.swift
//  LuxTaxiSwiftUI
//
//  Created by Baris OZGEN on 27.09.2022.
//

import SwiftUI

@main
struct LuxTaxiSwiftUIApp: App {
    
    @StateObject var launchScreenManager = LaunchScreenViewModel()
    @StateObject var locationSearchListViewModel = LocationSearchListViewModel()

    var body: some Scene {
        WindowGroup {
            ZStack{
                HomeView()
                    .environmentObject(locationSearchListViewModel)
                    .environmentObject(launchScreenManager)
                
                if launchScreenManager.state != .completed{
                    LaunchScreenView()
                }
            }
            
        }
    }
}
