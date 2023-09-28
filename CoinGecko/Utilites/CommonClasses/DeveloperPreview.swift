final class DeveloperPreview {
  // MARK: - Singleton Instance
  static let instance = DeveloperPreview()

  // MARK: - Statistic Instances
    let stat3 = StatisticModel(title: "Rank", value: "1", percentageChange: nil)
    
  // MARK: - Coin Instance
  let coin: Coin = .init(
    id: "bitcoin",
    symbol: "btc",
    name: "Bitcoin",
    image: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579",
    currentPrice: 18717.93,
    marketCap: 357775228080,
    marketCapRank: 1,
    fullyDilutedValuation: 392164179695,
    totalVolume: 33734565363,
    high24H: 19475.03,
    low24H: 18641.21,
    priceChange24H: -232.35889239136668,
    priceChangePercentage24H: -1.22615,
    marketCapChange24H: -5825248847.010986,
    marketCapChangePercentage24H: -1.6021,
    circulatingSupply: 19158506,
    totalSupply: 21000000,
    maxSupply: 21000000,
    ath: 69045,
    athChangePercentage: -73.00688,
    athDate: "2021-11-10T14:24:11.849Z",
    atl: 67.81,
    atlChangePercentage: 27385.05085,
    atlDate: "2013-07-06T00:00:00.000Z",
    lastUpdated: "2022-09-23T14:59:10.845Z",
    sparklineIn7D: Coin.SparklineIn7D(price:[
      19877.977087031624,
      19694.477379430067,
      19532.43085061006
    ]),
    priceChangePercentage24HInCurrency: -1.2261495372372209,
    currentHoldings: 1.5,
    priceChangePercentage1HInCurrency: -1.333,
    priceChangePercentage7DInCurrency: -1.44
  )

  // MARK: - Initialization
  private init() { }
}
