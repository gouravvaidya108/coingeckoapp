//
//  CoinGecko.swift
//  CoinGecko
//
//  Created by Gourav on 23.09.2023.
//

import SwiftUI

@main
struct CoinGecko: App {
  // MARK: - Properties
  @StateObject var homeViewModel = HomeViewModel()

  init() {
    UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color.theme.accent)]
    UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(Color.theme.accent)]
  }

  // MARK: - Scene
  var body: some Scene {
    WindowGroup {
    NavigationStack {
        HomeView()
          .navigationBarHidden(true)
      }
      .environmentObject(homeViewModel)
    }
  }
}
