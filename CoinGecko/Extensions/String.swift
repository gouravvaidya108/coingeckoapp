//
//  String.swift
//  CoinGecko
//
//  Created by Gourav on 23.09.2023.
//

import Foundation

extension String {
    static var empty: String {
        ""
    }
    
    
    var prependLocaleCurrencySymbol: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = Locale.current.currency?.identifier
        
        // Assuming the string can be converted to a Double.
        // If it fails, it will return the original string.
        if let value = Double(self), let formattedString = formatter.string(from: NSNumber(value: value)) {
            return formattedString
        } else {
            return self
        }
    }
}
