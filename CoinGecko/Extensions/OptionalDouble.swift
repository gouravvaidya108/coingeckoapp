//
//  OptionalDouble.swift
//  CoinGecko
//
//  Created by Gourav on 23.09.2023.
//

extension Optional where Wrapped == Double {
  var orZero: Double {
    self ?? 0
  }

  var toInt: Int {
    Int(self.orZero)
  }
}
