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
            return 7
        case .suv:
            return 12
        case .van:
            return 29
        }
    }
    
    var baseFareInMinute : Double {
        switch self {
            
        case .sport:
            return 0.14
        case .suv:
            return 0.17
        case .van:
            return 0.192
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
