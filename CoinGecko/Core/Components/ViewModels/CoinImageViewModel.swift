//
//  CoinImageViewModel.swift
//  CoinGecko
//
//  Created by Gourav on 23.09.2023.
//

import Combine
import UIKit

final class CoinImageViewModel: ObservableObject {
  // MARK: - Properties
  @Published var image: UIImage?
  @Published var isLoading = false
    
  

  private let dataService: CoinImageService
  private var cancellables = Set<AnyCancellable>()

  // MARK: - Initialization
  init(coin: Coin) {
    dataService = CoinImageService(coin: coin)
    addSubscribers()
  }
}

// MARK: - Private Helper Methods
private extension CoinImageViewModel {
  func addSubscribers() {
    isLoading = true

    dataService.$image
      .sink { [weak self] _ in
        guard let self else { return }
        isLoading = false
      } receiveValue: { [weak self] image in
        guard let self else { return }
        self.image = image
      }
      .store(in: &cancellables)
  }
}
