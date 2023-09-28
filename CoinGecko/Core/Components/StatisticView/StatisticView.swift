//
//  StatisticView.swift
//  CoinGecko
//
//  Created by Gourav on 23.09.2023.
//

import SwiftUI

struct StatisticView: View {
    let model : StatisticModel
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(model.title)
                .font(.appBody)
                .multilineTextAlignment(.leading)
            Text(model.value)
                .font(.appCaption)
            if let percentChange = model.percentageChange {
                HStack(spacing: 4){
                    Image(systemName: "triangle.fill")
                        .font(.appCaption)
                    Text(percentChange.toPercent())
                        .font(.appCaption)
                        .bold()
                }
                .foregroundColor(.green)
            }
                
        }
    }
}

struct StatisticView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticView(model: developer.stat3)
    }
}
