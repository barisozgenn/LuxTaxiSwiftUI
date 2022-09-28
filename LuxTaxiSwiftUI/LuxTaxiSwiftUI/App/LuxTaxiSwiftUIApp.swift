//
//  LuxTaxiSwiftUIApp.swift
//  LuxTaxiSwiftUI
//
//  Created by Baris OZGEN on 27.09.2022.
//

import SwiftUI

@main
struct LuxTaxiSwiftUIApp: App {
    
    @StateObject var locationSearchListViewModel = LocationSearchListViewModel()

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(locationSearchListViewModel)
        }
    }
}
