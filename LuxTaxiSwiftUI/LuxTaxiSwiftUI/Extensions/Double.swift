//
//  Double.swift
//  LuxTaxiSwiftUI
//
//  Created by Baris OZGEN on 29.09.2022.
//

import Foundation

extension Double {
    private var currencyPriceFormatter : NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        formatter.numberStyle = .currency
        formatter.currencyCode = "USD"
        formatter.currencySymbol = "$"
        return formatter
    }
    
    private func toUSDCurrency() -> String {
        
        let price = abs(Double(self))
        var priceString = ""
        if price > 1.0 {
            priceString = currencyPriceFormatter.string(for: price) ?? "$0.00"
        }
        else {
            var digit = 2
            
            if price > 0.1 { digit = 3}
            else if price > 0.01 { digit = 3}
            else if price > 0.001 { digit = 4}
            else if price > 0.0001 { digit = 5}
            else if price > 0.00001 { digit = 6}
            else {digit = 10}
            
            priceString = "$" + price.asNumberString(digit: digit)
        }
        return priceString
    }
    
    
    private func asNumberString(digit: Int = 2) -> String{
        return String(format: "%.\(digit)f", self)
    }
    
    func toUSDCurrencyFormatted() -> String {
        var priceString =  self.toUSDCurrency()
        
        while (priceString.last == "0"){
          priceString = String(priceString.dropLast())
        }
        if priceString.last == "." || priceString.last == "," {priceString =  String(priceString.dropLast())}
        
        return priceString
    }
   
}
