//
//  CoinDataService.swift
//  CoinGecko
//
//  Created by Gourav on 23.09.2023.
//

import Combine
import Foundation

final class CoinDataService {
    // MARK: - Properties
    @Published var coins: [Coin] = []
    
    private var coinSubscription: AnyCancellable?
}

// MARK: - Internal Helper Methods
extension CoinDataService {
    
    func fetchCoins(withPage page: Int, setLoadingState: @escaping (Bool) -> Void) {
        setLoadingState(true)
        guard let url = URL(string: APIConstant.cryptocurrencyListURL(withPage: page)) else { return }
        
        coinSubscription = NetworkManager.download(url: url)
            .decode(type: [Coin].self, decoder: NetworkManager.jsonDecoder)
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        print(error) // Handle error appropriately
                    }
                    setLoadingState(false)
                },
                receiveValue: { [weak self] coins in
                    self?.coins += coins
                }
            )
    }
}
