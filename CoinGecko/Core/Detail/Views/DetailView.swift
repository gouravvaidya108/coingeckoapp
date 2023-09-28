//
//  DetailView.swift
//  CoinGecko
//
//  Created by Gourav on 23.09.2023.
//

import SwiftUI

struct DetailLoadingView: View {
  // MARK: - Properties
  @Binding var coin: Coin?

  // MARK: - View
  var body: some View {
    ZStack {
      if let coin {
        DetailView(coin: coin)
      }
    }
  }
}

struct DetailView: View {
    let viewModel: CoinDetailsViewModel
    
    
    init(coin: Coin){
        self.viewModel = CoinDetailsViewModel(coin: coin)
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            // chart
            ChartView(viewModel: viewModel)
                .frame(height: 200)
                .padding(.vertical)
                .shadow(color: viewModel.chartLineColor, radius: 10)
                .shadow(color: viewModel.chartLineColor.opacity(0.5), radius: 10)

            HStack(alignment: .center) {
                CoinImageView(coinImageViewModel: CoinImageViewModel(coin: self.viewModel.coin))
                        .frame(width: 30, height: 30)
                        Text(viewModel.coinName)
                            .font(.appBody)
                            .foregroundColor(Color.theme.text)
                        Text(viewModel.coinSymbol.uppercased())
                            .font(.appCaption)
                            .bold()
                            .foregroundColor(Color.theme.secondaryText)
                    Spacer()
            }.padding(0)
            
            // overview
            CoinDetailSection(model: viewModel.overviewSectionModel)
                .padding(.vertical)
            
            // additonal details
            CoinDetailSection(model: viewModel.addtitionalDetailSectionModel)
                .padding(.vertical)
            
        }
        .padding()
        .navigationTitle("\(viewModel.coinName) (\(viewModel.coinSymbol))")
        
    }
}

// MARK: - Preview
struct DetailView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationStack {
      DetailView(coin: developer.coin)
    }
  }
}
