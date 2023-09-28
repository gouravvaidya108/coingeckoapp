//
//  Coin.swift
//  CoinGecko
//
//  Created by Gourav on 23.09.2023.
//

struct Coin: Identifiable, Decodable {
  let id: String?
  let symbol: String?
  let name: String?
  let image: String?
  let currentPrice: Double?
  let marketCap: Double?
  let marketCapRank: Double?
  let fullyDilutedValuation: Double?
  let totalVolume: Double?
  let high24H: Double?
  let low24H: Double?
  let priceChange24H: Double?
  let priceChangePercentage24H: Double?
  let marketCapChange24H: Double?
  let marketCapChangePercentage24H: Double?
  let circulatingSupply: Double?
  let totalSupply: Double?
  let maxSupply: Double?
  let ath: Double?
  let athChangePercentage: Double?
  let athDate: String?
  let atl: Double?
  let atlChangePercentage: Double?
  let atlDate: String?
  let lastUpdated: String?
  let sparklineIn7D: SparklineIn7D?
  let priceChangePercentage24HInCurrency: Double?
  let currentHoldings: Double?
  let priceChangePercentage1HInCurrency: Double?
  let priceChangePercentage7DInCurrency: Double?

  // MARK: - SparklineIn7D
  struct SparklineIn7D: Decodable {
    let price: [Double]?
  }


  var currentHoldingsValue: Double {
    currentHoldings.orZero * currentPrice.orZero
  }

  var rank: Int {
    marketCapRank.toInt
  }
}
