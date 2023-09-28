//
//  ChartData.swift
//  CoinGecko
//
//  Created by Gourav on 23.09.2023.
//

import Foundation

struct ChartData: Identifiable {
    let id = UUID().uuidString
    let data: Date
    let value: Double
}
