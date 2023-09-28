//
//  CoinImageView.swift
//  CoinGecko
//
//  Created by Gourav on 23.09.2023.
//

import SwiftUI

struct CoinImageView: View {
  // MARK: - Properties
  @ObservedObject var coinImageViewModel: CoinImageViewModel
    
    
  // MARK: - View
  var body: some View {
    ZStack {
      if let image = coinImageViewModel.image {
        Image(uiImage: image)
          .resizable()
          .scaledToFit()
          .clipShape(Circle())
      } else if coinImageViewModel.isLoading {
        ProgressView()
      } else {
        Image(systemName: IconNaming.shared.questionMark)
          .foregroundColor(Color.theme.secondaryText)
      }
    }
  }
}

// MARK: - Preview
struct CoinImageView_Previews: PreviewProvider {
    static var previews: some View {
        CoinImageView(coinImageViewModel: CoinImageViewModel(coin: developer.coin))
            .previewLayout(.sizeThatFits)
            .padding()
            .preferredColorScheme(.dark)
    }
}
