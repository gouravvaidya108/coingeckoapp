//
//  CoinDetailSection.swift
//  CoinGecko
//
//  Created by Gourav on 23.09.2023.
//

import SwiftUI

struct CoinDetailSection: View {
    let model: CoinDetailSectionModel
    
    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        
    ]
    
    var body: some View {
        VStack {
            Text(model.title)
                .font(.appTitle)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            LazyVGrid(columns: columns, alignment: .leading, spacing: 20) {
                ForEach(model.stats){ stat in
                    StatisticView(model: stat)
                }
            }
            
        }
    }
}

//struct CoinDetailSection_Previews: PreviewProvider {
//    static var previews: some View {
//        
//        // Mock Stat Model
//        let stat = StatisticModel(
//            title: "Bitcoin",
//            value: "$1.23B",
//            percentageChange: 12.0
//        )
//        
//        // Mock Section Model
//        let sectionModel = CoinDetailSectionModel(
//            title: "Overview",
//            stats: [stat, stat]
//        )
//        
//        CoinDetailSection(model: sectionModel)
//            .previewLayout(.sizeThatFits)
//            .padding()
//    }
//}
