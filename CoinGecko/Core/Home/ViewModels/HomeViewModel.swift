//
//  HomeViewModel.swift
//  CoinGecko
//
//  Created by Gourav on 23.09.2023.
//

import Combine
import SwiftUI

@MainActor
final class HomeViewModel: ObservableObject {
    // MARK: - Properties
    @Published var coins: [Coin] = []
    @Published var searchText = String.empty
    @Published var sortOption: SortOption = .rank
    @Published var isLoading = true
    @Published var hasMoreCoins = true
    
    private(set) var page = 0
    private var cancellables = Set<AnyCancellable>()
    private let coinDataService = CoinDataService()
    
    // MARK: - Initialization
    init() {
        fetchCoinsWithFiltering()
    }
}

// MARK: - Internal Helper Methods
extension HomeViewModel {
    func updateList() {
        page += 1
        coinDataService.fetchCoins(withPage: page) { [weak self] isLoading in
                self?.isLoading = isLoading
        }
    }
    
    func toggleSortOption(for column: CoinColumn) {
        switch column {
        case .price:
            sortOption = sortOption == .price ? .priceReversed : .price
        default: break
        }
    }
    
    
}

// MARK: - Private Helper Methods
private extension HomeViewModel {
    func fetchCoinsWithFiltering() {
        $searchText
            .combineLatest(
                coinDataService.$coins,
                $sortOption
            )
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterAndSortCoins)
            .sink { [weak self] filteredCoins in
                guard let self else { return }
                coins = filteredCoins
                self.isLoading = false
                self.hasMoreCoins = !filteredCoins.isEmpty
            }
            .store(in: &cancellables)
        
        
        
    }
    
    func filterAndSortCoins(
        withText text: String,
        coins: [Coin],
        sortOption: SortOption
    ) -> [Coin] {
        var updatedCoins = filterCoins(
            withText: text,
            coins: coins
        )
        sortCoins(
            coins: &updatedCoins,
            sortOption: sortOption
        )
        return updatedCoins
    }
    
    func filterCoins(
        withText text: String,
        coins: [Coin]
    ) -> [Coin] {
        guard text.isNotEmpty else { return coins }
        let coinName = text.lowercased()
        return coins.filter {
            $0.name.orEmpty.lowercased().contains(coinName) ||
            $0.symbol.orEmpty.lowercased().contains(coinName) ||
            $0.id.orEmpty.lowercased().contains(coinName)
        }
    }
    
    func sortCoins(
        coins: inout [Coin],
        sortOption: SortOption
    ) {
        switch sortOption {
        case .rank,
                .holdings:
            coins.sort(by: { $0.rank < $1.rank })
        case .rankReversed,
                .holdingsReversed:
            coins.sort(by: { $0.rank > $1.rank })
        case .price:
            coins.sort(by: { $0.currentPrice.orZero > $1.currentPrice.orZero })
        case .priceReversed:
            coins.sort(by: { $0.currentPrice.orZero < $1.currentPrice.orZero })
        }
    }
}
