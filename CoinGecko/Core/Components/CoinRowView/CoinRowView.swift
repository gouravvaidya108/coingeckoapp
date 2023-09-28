//
//  CoinRowView.swift
//  CoinGecko
//
//  Created by Gourav on 26.09.2023.
//

import Foundation
import SwiftUI

struct CoinRowView: View {
    var column: CoinColumn
    var coin: Coin
    var frameWidth: CGFloat
    var frameHeight: CGFloat

    
    var body: some View {
            VStack(spacing: 0) {
                if column == .sparkline {
                    SparklineView(data: coin.sparklineIn7D?.price ?? [])
                        .frame(width: frameWidth, height: frameHeight)
                } else {
                    Text(column.getValueFor(coin: coin))
                        .font(.appCaption)
                        .frame(width: frameWidth, height: frameHeight)
                        .padding(.horizontal, 2)
                        .foregroundColor(column.textColorFor(coin: coin))
                }
                Divider()
            }
        }
}
