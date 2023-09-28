//
//  APIConstant.swift
//  CoinGecko
//
//  Created by Gourav on 23.09.2023.
//

import Foundation


enum APIConstant {
    static func cryptocurrencyListURL(withPage page: Int) -> String {
        let currencyCode = Locale.current.currency?.identifier ?? "usd"
        return "https://api.coingecko.com/api/v3/coins/markets?vs_currency=\(currencyCode)&order=market_cap_desc&per_page=40&page=\(page)&sparkline=true&price_change_percentage=1h,24h,7d"
    }
  
  
}
