//
//  CoinDetailsViewModel.swift
//  CoinGecko
//
//  Created by Gourav on 23.09.2023.
//

import Foundation
import SwiftUI

class CoinDetailsViewModel {
    let coin: Coin
    
    // chart config
    var chartData = [ChartData]()
    var startDate =  Date()
    var endDate = Date()
    var minPrice = 0.0
    var maxPrice = 0.0
    var xAxisValues = [Date]()
    var yAxisValues = [Double]()
    
    var coinName: String {
        return coin.name ?? ""
    }
    
    var coinSymbol: String {
        return coin.symbol?.uppercased() ?? ""
    }
    
    var chartLineColor: Color {
        let priceChange = (coin.sparklineIn7D?.price?.last ?? 0) - (coin.sparklineIn7D?.price?.first ?? 0)
        return priceChange > 0 ? .green : .red
    }
    
    var overviewSectionModel: CoinDetailSectionModel {
        // price stats
        let price = (coin.currentPrice?.toCurrency()).orEmptyPrice
        let pricePercentChange = coin.priceChange24H
        let priceStat = StatisticModel(title: "Current Price", value: price, percentageChange: pricePercentChange)
        
        // market cap stats
        let marketCap = coin.marketCap ?? 0
        let marketCapPercentChange = coin.marketCapChangePercentage24H
        let marketCapStat = StatisticModel(title: NSLocalizedString("mktCap", comment: "Market capitalization"), value: marketCap.formattedWithAbbreviations(), percentageChange: marketCapPercentChange)
        
//        // circulatingSupply stats
        let circulatingSupply = coin.circulatingSupply ?? 0
        let circulatingSupplyStat = StatisticModel(title: NSLocalizedString("circulatingSupply", comment: "Circulating Supply"), value: circulatingSupply.formattedWithAbbreviations(), percentageChange: nil)
        
        
        let maxSupply = coin.maxSupply ?? 0
        let maxSupplyStat = StatisticModel(title: NSLocalizedString("maxSupply", comment: "Max Supply"), value: maxSupply.formattedWithAbbreviations(), percentageChange: nil)
        
        
        let totalSupply = coin.totalSupply ?? 0
        let totalSupplyStat = StatisticModel(title: NSLocalizedString("totalSupply", comment: "Total Supply"), value: totalSupply.formattedWithAbbreviations(), percentageChange: nil)
        
        // volume stats
        let volume = coin.totalVolume ?? 0
        let volumeStat = StatisticModel(title: NSLocalizedString("24hVolume", comment: "Volume"), value: volume.formattedWithAbbreviations(), percentageChange: nil)
        
        
        return CoinDetailSectionModel(title: NSLocalizedString("overview", comment: "OverView"), stats: [priceStat, marketCapStat,circulatingSupplyStat,maxSupplyStat,totalSupplyStat,volumeStat])
    }
    
    var addtitionalDetailSectionModel: CoinDetailSectionModel {
        // 24H high
        let high = coin.high24H?.toCurrency() ?? "n/a"
        let highStat = StatisticModel(title: NSLocalizedString("24hHigh", comment: "24H High"), value: high, percentageChange: nil)
        
        // 24H low
        let low = coin.low24H?.toCurrency() ?? "n/a"
        let lowStat = StatisticModel(title: NSLocalizedString("24hLow", comment: "24H Low"), value: low, percentageChange: nil)
        
        
        // 24H Price change
        let priceChange24H = (coin.priceChange24H?.toCurrency()).orEmptyPrice
        let percentChange24 = coin.priceChangePercentage24H
        let priceChangeStat = StatisticModel(title: NSLocalizedString("24hPriceChange", comment: "24h Price Change"), value: priceChange24H, percentageChange: percentChange24)
        
        // 24H market cap change
        let marketCapChange = coin.marketCapChange24H ?? 0
        let marketCapChangePercent = coin.marketCapChangePercentage24H
        let marketStat = StatisticModel(title: NSLocalizedString("24hMarketCapChange", comment: "24h Market Cap Change"), value: "$\(marketCapChange.formattedWithAbbreviations())", percentageChange: marketCapChangePercent)
        
        return CoinDetailSectionModel(title: NSLocalizedString("additionalDetails", comment: "Addition Details"), stats: [highStat, lowStat, priceChangeStat, marketStat])
    }
    
    init(coin: Coin){
        self.coin = coin
        configureChartData()
    }
    
    func configureChartData() {
        guard let priceData = coin.sparklineIn7D?.price else { return }
        var index = 0
        self.minPrice = priceData.min()!
        self.maxPrice = priceData.max()!
        self.endDate = Date(coinGeckoString: coin.lastUpdated ?? "")
        self.startDate = endDate.addingTimeInterval(-7 * 60 * 60 * 24)
        self.yAxisValues = [minPrice, (minPrice + maxPrice) / 2 ,maxPrice]
        self.xAxisValues = [startDate, endDate]
        
        for price in priceData.reversed() {
            let date = endDate.addingTimeInterval(-1 * 60 * 60 * Double(index))
            
            let chartDataItem = ChartData(data: date,value: price )
            self.chartData.append(chartDataItem)
            index += 1
        }
    }
}
