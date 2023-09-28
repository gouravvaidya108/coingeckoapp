//
//  CoinImageService.swift
//  CoinGecko
//
//  Created by Gourav on 23.09.2023.
//


import Combine
import SwiftUI

final class CoinImageService {
  // MARK: - Properties
  @Published var image: UIImage?

  private var imageSubscription: AnyCancellable?
  private let coin: Coin
  private let fileManager = LocalFileManager.shared
  private let folderName = "coin-images"
  private let imageName: String

  // MARK: - Initialization
  init(coin: Coin) {
    self.coin = coin
    imageName = coin.id.orEmpty
    getCoinImage()
  }
}

// MARK: - Private Helper Methods
private extension CoinImageService {
  func downloadCoinImage() {
    guard let url = URL(string: coin.image.orEmpty) else { return }

    imageSubscription = NetworkManager.download(url: url)
      .tryMap { data -> UIImage? in
        return .init(data: data)
      }
      .sink(receiveCompletion: NetworkManager.handleCompletion,
            receiveValue: { [weak self] image in
        guard let self,
              let image
        else {
          return
        }
        self.image = image
        imageSubscription?.cancel()
        fileManager.saveImage(image, imageName: imageName, folderName: folderName)
      })
  }

  func getCoinImage() {
    guard let image = fileManager.getImage(imageName: coin.id.orEmpty, folderName: folderName) else {
      downloadCoinImage()
      return
    }
    self.image = image
  }
}
