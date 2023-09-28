//
//  ColumnHeader.swift
//  CoinGecko
//
//  Created by Gourav on 26.09.2023.
//

import Foundation
import SwiftUI


struct ColumnHeader: View {
    @EnvironmentObject private var homeViewModel: HomeViewModel
    var column: CoinColumn
    var frameWidth: CGFloat
    var frameHeight: CGFloat
    
    var body: some View {
        HStack(alignment: .center)  {
            if column == .price {
                Image(systemName: IconNaming.shared.chevronDown)
                    .resizable()
                    .frame(width: 12, height: 12)
                    .opacity([SortOption.price, SortOption.priceReversed].contains(homeViewModel.sortOption) ? 1 : 0)
                    .rotationEffect(.init(degrees: homeViewModel.sortOption == .price ? 0 : 180))
                    .padding(.trailing,0) 
            }
            Text(column.title)
                .font(.appBody)
                .frame(height: frameHeight)
        
        }
        .frame(width: frameWidth)
    }
}
