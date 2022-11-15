//
//  LuxTaxiSwiftUIApp.swift
//  LuxTaxiSwiftUI
//
//  Created by Baris OZGEN on 27.09.2022.
//

import SwiftUI
import Firebase

@main
struct LuxTaxiSwiftUIApp: App {
    
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(FirebaseAppDelegate.self) var delegate
    
    @StateObject var launchScreenManager = LaunchScreenViewModel()
    @StateObject var locationSearchListViewModel = LocationSearchListViewModel()
    @StateObject var authViewModel = AuthViewModel()
    
    var body: some Scene {
        WindowGroup {
            ZStack{
                if Auth.auth().currentUser?.uid != nil {
                   

                    HomeView()
                        .environmentObject(locationSearchListViewModel)
                        .environmentObject(launchScreenManager)
                        .onAppear{
                            try? Auth.auth().signOut()
                        }
                }
                else {
                    AuthView()
                        .environmentObject(authViewModel)
                   
                }
               
                
                if launchScreenManager.state != .completed{
                    LaunchScreenView()
                }
            }
            
        }
    }
}
