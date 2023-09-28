//
//  HomeView.swift
//  CoinGecko
//
//  Created by Gourav on 23.09.2023.
//



import SwiftUI

struct HomeView: View {
    // MARK: - Properties
    @EnvironmentObject private var homeViewModel: HomeViewModel
    @State private var selectedCoin: Coin?
    @State private var showDetailView = false
    
    // MARK: - View
    var body: some View {
        NavigationStack {
            ZStack {
                Color.theme.background
                    .ignoresSafeArea()
                VStack {
                    homeHeader
                    SearchBarView(searchText: $homeViewModel.searchText)
                    CoinListView()
                    
                }
                if homeViewModel.isLoading {
                    LoadingView()
                }
            }
            .navigationDestination(isPresented: $showDetailView) {
                DetailLoadingView(coin: $selectedCoin)
            }
        }
        .onAppear {
            homeViewModel.updateList()
        }
        
    }
}

// MARK: - Private Helpers
private extension HomeView {
    // MARK: - Views
    var homeHeader: some View {
        VStack {
            Text("CoinGecko")
                .font(.appNavigationTitle)
                .foregroundColor(Color.theme.accent)
        }
        .padding(.top, 20)
        .padding(.bottom, 20)
        
    }
    
}

// MARK: - Preview
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView()
                .navigationBarHidden(true)
                .preferredColorScheme(.dark)
        }
        .environmentObject(HomeViewModel())
    }
}
