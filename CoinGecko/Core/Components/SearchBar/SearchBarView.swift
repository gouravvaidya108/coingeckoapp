//
//  SearchBarView.swift
//  CoinGecko
//
//  Created by Gourav on 23.09.2023.
//

import SwiftUI

struct SearchBarView: View {
  // MARK: - Properties
  @Binding var searchText: String

  // MARK: - View
  var body: some View {
    HStack {
      Image(systemName: IconNaming.shared.magnifyingGlass)
        .foregroundColor(searchText.isEmpty ? Color.theme.secondaryText : Color.theme.accent)
      TextField(
        "searchText",
        text: $searchText
      )
      .autocorrectionDisabled(true)
      .foregroundColor(Color.theme.accent)
      .overlay(
        Image(systemName: IconNaming.shared.xMark)
          .foregroundColor(Color.theme.accent)
          .opacity(searchText.isEmpty ? 0 : 1)
          .onTapGesture {
            UIApplication.shared.endEditing()
            searchText = .empty
          },
        alignment: .trailing
      )
    }
    .font(.headline)
    .padding(10)
    .background(
      RoundedRectangle(cornerRadius: 8)
        .fill(Color.theme.background)
        .shadow(color: Color.theme.accent.opacity(0.3), radius: 1)
    )
    .padding()
  }
}

// MARK: - Preview
struct SearchBarView_Previews: PreviewProvider {
  static var previews: some View {
    SearchBarView(searchText: .constant(.empty))
      .previewLayout(.sizeThatFits)
  }
}
