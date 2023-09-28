//
//  StatisticModel.swift
//  CoinGecko
//
//  Created by Gourav on 23.09.2023.
//

import Foundation

struct StatisticModel: Identifiable {
    let id = UUID().uuidString
    let title: String
    let value: String
    let percentageChange: Double?
}
