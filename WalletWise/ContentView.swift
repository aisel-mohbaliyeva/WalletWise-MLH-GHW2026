//
//  ContentView.swift
//  WalletWise
//
//  Created by Aysel Mohbaliyeva on 16.06.26.
//

import SwiftUI

struct ContentView: View {
    
    @State private var viewModel = WalletViewModel()
    @State private var showSplash = true
    
    var body: some View {
        ZStack {
            HomeView(viewModel: viewModel)
            
            if showSplash {
                SplashScreenView()
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.6) {
                showSplash = false
            }
        }
    }
}

#Preview {
    ContentView()
}
