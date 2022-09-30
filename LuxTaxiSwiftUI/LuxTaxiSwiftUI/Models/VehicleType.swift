//
//  VehicleType.swift
//  LuxTaxiSwiftUI
//
//  Created by Baris OZGEN on 29.09.2022.
//

import Foundation

enum VehicleType: Int, CaseIterable, Identifiable {
    case sport
    case suv
    case van
    
    var id : Int { return rawValue}
    
    var title : String {
        switch self {
            
        case .sport:
            return "Sport-E"
        case .suv:
            return "SUV-XL"
        case .van:
            return "VAN-Vip"
        }
    }
    
    var imageName : String {
        switch self {
            
        case .sport:
            return "app-car-sedan"
        case .suv:
            return "app-car-suv"
        case .van:
            return "app-car-van"
        }
    }
    
    var baseFare : Double {
        switch self {
            
        case .sport:
            return 14
        case .suv:
            return 29
        case .van:
            return 58
        }
    }
    
    var baseFareInMinute : Double {
        switch self {
            
        case .sport:
            return 0.007
        case .suv:
            return 0.014
        case .van:
            return 0.021
        }
    }
    
    func calculateFee (forMeters distanceInMeters: Double ) -> Double {
        switch self {
        case .sport:
            return distanceInMeters * baseFareInMinute + baseFare
        case .suv:
            return distanceInMeters * baseFareInMinute + baseFare
        case .van:
            return distanceInMeters * baseFareInMinute + baseFare
        }
    }
}
