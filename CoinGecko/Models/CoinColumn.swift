//
//  CoinColumn.swift
//  CoinGecko
//
//  Created by Gourav on 26.09.2023.
//

import Foundation
import SwiftUI



// Enum for Columns
enum CoinColumn: Int, CaseIterable {
    case price, oneHour, twentyFourHour, sevenDay, twentyFourHourVolume, marketCap, sparkline
    
    var title: String {
        switch self {
        case .price: return  NSLocalizedString("price", comment: "Price")
        case .oneHour: return NSLocalizedString("1h", comment: "1h")
        case .twentyFourHour: return NSLocalizedString("24h", comment: "24h")
        case .sevenDay:  return NSLocalizedString("7d", comment: "7d")
        case .twentyFourHourVolume: return NSLocalizedString("24hVolume", comment: "24h Volume")
        case .marketCap: return NSLocalizedString("marketCap", comment: "Mkt Cap")
        case .sparkline: return NSLocalizedString("last7Days", comment: "Last 7 Days")
        }
    }
    func getValueFor( coin: Coin) -> String {
        switch self {
        case .price: return (coin.currentPrice?.toCurrency()).orEmptyPrice
        case .oneHour: return (coin.priceChangePercentage1HInCurrency?.asPercentString()).orEmptyPrice
        case .twentyFourHour: return (coin.priceChangePercentage24HInCurrency?.asPercentString()).orEmptyPrice
        case .sevenDay: return (coin.priceChangePercentage7DInCurrency?.asPercentString()).orEmptyPrice
        case .twentyFourHourVolume: return ((coin.totalVolume?.toCurrency()).orEmptyPrice )
        case .marketCap: return ((coin.marketCap?.toCurrency()).orEmptyPrice )
        default: return ""
        }
    }
    
    func textColorFor(coin: Coin) -> Color {
            let value: Double?
            switch self {
            case .oneHour:
                value = coin.priceChangePercentage1HInCurrency
            case .twentyFourHour:
                value = coin.priceChangePercentage24HInCurrency
            case .sevenDay:
                value = coin.priceChangePercentage7DInCurrency
            // add more cases as needed
            default:
                value = nil
            }
            
            if let value = value {
                return value < 0 ? .red : .green
            } else {
                return .primary // Default text color, you can adjust as needed
            }
        }
    
}
