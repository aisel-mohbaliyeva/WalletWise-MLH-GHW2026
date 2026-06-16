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
                    .transition(.opacity)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.8) {
                withAnimation(.easeOut(duration: 0.3)) {
                    showSplash = false
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
