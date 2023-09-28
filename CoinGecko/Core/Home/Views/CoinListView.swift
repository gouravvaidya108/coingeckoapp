//
//  CoinListView.swift
//  CoinGecko
//
//  Created by Gourav on 23.09.2023.
//

import SwiftUI


struct CoinListView: View {
    // Constants
    let frameWidth: CGFloat = 120
    let frameHeight: CGFloat = 60
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                ScrollView(.vertical, showsIndicators: true) {
                    HStack(spacing: 0) {
                        StaticColumnView(frameWidth: frameWidth, frameHeight: frameHeight).frame(width: 120,height: 60)
                        ScrollableColumnsView(frameWidth: frameWidth, frameHeight: frameHeight)
                    }
                }
                .padding(.horizontal, 16)
            }
        }
    }
    
}

private struct StaticColumnView: View {
    @EnvironmentObject private var homeViewModel: HomeViewModel
    let frameWidth: CGFloat;
    let frameHeight: CGFloat;
    
    var body: some View {
        VStack(spacing: 0) {
            // Header with Divider
            VStack(spacing: 0) {
                HStack(alignment: .center) {
                        Image(systemName: IconNaming.shared.chevronDown)
                            .resizable()
                            .frame(width: 12, height: 12)
                            .opacity([SortOption.rank, SortOption.rankReversed].contains(homeViewModel.sortOption) ? 1 : 0)
                            .rotationEffect(.init(degrees: homeViewModel.sortOption == .rank ? 0 : 180))
                        
                        Text("coin")
                            .font(.appBody)
                            .frame(height: frameHeight, alignment: .leading)
                        
                        Spacer() // push the content to the left
                    }
                .frame(width: frameWidth)
                .onTapGesture {
                    withAnimation(.default) {
                        homeViewModel.sortOption = homeViewModel.sortOption == .rank
                        ? .rankReversed
                        : .rank
                    }
                }
                Divider()

            }
            
            ForEach(Array(homeViewModel.coins.enumerated()), id: \.offset) { index, coin in
                // Each row with Divider
                VStack(spacing: 0) {
                    NavigationLink(destination: DetailView(coin: coin)) {
                        HStack(alignment: .center) {
                            CoinImageView(coinImageViewModel: CoinImageViewModel(coin: coin))
                                    .frame(width: 30, height: 30)
                                VStack(alignment: .leading) { // This VStack should left-align the text
                                    Text(coin.name.orEmpty)
                                        .font(.appBody)
                                        .foregroundColor(Color.theme.text)
                                    Text(coin.symbol.orEmpty.uppercased())
                                        .font(.appCaption)
                                        .bold()
                                        .foregroundColor(Color.theme.secondaryText)
                                }
                                Spacer()
                            }
                        .frame(width: 120, height: 60)
                    }
                    Divider() // Adding Divider here
                }
            }
        }
    }
}

private struct ScrollableColumnsView: View {
    @EnvironmentObject private var homeViewModel: HomeViewModel
    var frameWidth: CGFloat
    var frameHeight: CGFloat
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: true) {
            HStack(spacing: 0) {
                ForEach(CoinColumn.allCases, id: \.self) { column in
                    VStack(spacing: 0) {
                        // Header with Divider
                        VStack(spacing: 0) {
                            ColumnHeader(column: column, frameWidth: frameWidth, frameHeight: frameHeight)
                                .onTapGesture {
                                    withAnimation(.default) {
                                        homeViewModel.toggleSortOption(for: column)
                                    }
                                }
                            Divider()
                        }
                        
                        ForEach(homeViewModel.coins) { coin in
                                CoinRowView(column: column, coin: coin, frameWidth: frameWidth, frameHeight: frameHeight)
                        }
                    }
                }
            }
        }
    }
}

// MARK: - Preview
struct CoinListView_Previews: PreviewProvider {
    static var previews: some View {
        CoinListView()
            .environmentObject(HomeViewModel())
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}
