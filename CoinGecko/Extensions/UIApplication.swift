//
//  UIApplication.swift
//  CoinGecko
//
//  Created by Gourav on 23.09.2023.
//

import UIKit

extension UIApplication {
  func endEditing() {
    sendAction(
      #selector(UIResponder.resignFirstResponder),
      to: .none,
      from: .none,
      for: .none
    )
  }
}
