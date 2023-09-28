//
//  NetworkManager.swift
//  CoinGecko
//
//  Created by Gourav on 23.09.2023.
//

import Combine
import Foundation

final class NetworkManager {
  private enum NetworkError: LocalizedError {
    case badURLResponse(url: URL)
    case unknown

    var errorDescription: String? {
      switch self {
      case .badURLResponse(url: let url):
        return "Bad response from URL: \(url)."
      case .unknown:
        return "Unknown error occurred."
      }
    }
  }

  static func download(url: URL) -> AnyPublisher<Data, Error> {
    URLSession.shared.dataTaskPublisher(for: url)
      .subscribe(on: DispatchQueue.global(qos: .background))
      .tryMap { try handleURLResponse(output: $0, url: url) }
      .receive(on: DispatchQueue.main)
      .eraseToAnyPublisher()
  }

  static func handleURLResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
    guard let response = output.response as? HTTPURLResponse,
          response.statusCode == 200 else {
      throw NetworkError.badURLResponse(url: url)
    }

    return output.data
  }

  static func handleCompletion(withCompletion completion: Subscribers.Completion<Error>) {
    switch completion {
    case .finished:
      break
    case .failure(let error):
      print(error.localizedDescription)
    }
  }

  // MARK: - JSONDecoder
  static var jsonDecoder: JSONDecoder {
    let jsonDecoder = JSONDecoder()
    jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
    return jsonDecoder
  }
}
