//
//  SideMenu.swift
//  LuxTaxiSwiftUI
//
//  Created by Baris OZGEN on 30.09.2022.
//

import Foundation

enum SideMenu: Int, CaseIterable, Identifiable {
    
    case profile
    case trips
    case payments
    case help
    case settings
    
    var id : Int { return rawValue}
    
    var title : String {
        switch self {
        case .profile: return "Profile"
        case .trips: return "Trips"
        case .payments: return "Payment Types"
        case .help: return "Help"
        case .settings: return "Settings"
        }
    }
    
    var imageName : String {
        switch self {
        case .profile: return "person.fill"
        case .trips: return "car.fill"
        case .payments: return "creditcard.fill"
        case .help: return "questionmark.circle.fill"
        case .settings: return "gearshape.fill"
        }
    }
    
}

