//
//  SplashScreenView.swift
//  WalletWise
//
//  Created by Aysel Mohbaliyeva on 16.06.26.
//

import SwiftUI

struct SplashScreenView: View {
    
    @State private var rotation: Double = 0
    @State private var logoScale: CGFloat = 1.0
    @State private var bgColor: Color = AppColor.accent
    
    var body: some View {
        ZStack {
            bgColor
                .ignoresSafeArea()
            
            Text("WW")
                .font(.system(size: 80, weight: .black, design: .rounded))
                .foregroundStyle(AppColor.background)
                .scaleEffect(logoScale)
                .rotation3DEffect(
                    .degrees(rotation),
                    axis: (x: 0, y: 1, z: 0),
                    perspective: 0.5
                )
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 0.6)) {
                rotation = 360
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                withAnimation(.easeIn(duration: 0.5)) {
                    logoScale = 50
                }
                withAnimation(.easeIn(duration: 0.5).delay(0.3)) {
                    bgColor = AppColor.background
                }
            }
        }
    }
}

#Preview {
    SplashScreenView()
}
