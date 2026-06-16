//
//  ContentView.swift
//  WalletWise
//
//  Created by Aysel Mohbaliyeva on 16.06.26.
//

import SwiftUI

struct ContentView: View {
    
    @State private var viewModel = WalletViewModel()
    
    var body: some View {
        HomeView(viewModel: viewModel)
    }
}

#Preview {
    ContentView()
}
