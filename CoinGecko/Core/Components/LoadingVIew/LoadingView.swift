//
//  LoadingView.swift
//  CoinGecko
//
//  Created by Gourav on 27.09.2023.
//

import Foundation
import SwiftUI

struct LoadingView: View {
    var body: some View {
        ProgressView() 
            .scaleEffect(2, anchor: .center)
            .progressViewStyle(CircularProgressViewStyle(tint: .theme.accent))
            .foregroundColor(.theme.accent)
    }
}
