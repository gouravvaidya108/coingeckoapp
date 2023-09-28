//
//  OptionalString.swift
//  CoinGecko
//
//  Created by Gourav on 23.09.2023.
//

extension Optional where Wrapped == String {
  var orEmpty: String {
    self ?? .empty
  }

  var orEmptyPrice: String {
    self ?? "$0.00"
  }
}
