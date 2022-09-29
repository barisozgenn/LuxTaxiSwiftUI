//
//  Date.swift
//  LuxTaxiSwiftUI
//
//  Created by Baris OZGEN on 29.09.2022.
//

import Foundation

extension Date {
    
    private var tripDateFormatter : DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM HH:mm"
        
        return formatter
    }
    
    private func toDate() -> String {
        
        return tripDateFormatter.string(from: self)
    }
    
    func shortDate()  -> String{
        return String(self.toDate().dropFirst(6))
    }
    
    func dropOffDate(addSeconds expectedTripSeconds : Double )  -> String{
        
        let dropOffDate = self + expectedTripSeconds
        
        if self.toDate().prefix(5) == dropOffDate.toDate().prefix(5) {
            return dropOffDate.shortDate()
        }else {
            return dropOffDate.toDate()
        }
        
        
    }
}
