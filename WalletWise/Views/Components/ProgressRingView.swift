//
//  ProgressRingView.swift
//  WalletWise
//
//  Created by Aysel Mohbaliyeva on 16.06.26.
//

import SwiftUI

struct ProgressRingView: View {
    
    var progress: Double
    var totalBudget: Double
    var spent: Double
    var currencyCode: String
    
    @State private var animatedProgress: Double = 0
    
    private var remaining: Double {
        max(totalBudget - spent, 0)
    }
    
    private var barColor: Color {
        if progress < 0.5 { return AppColor.accent }
        else if progress < 0.8 { return .orange }
        else { return .red }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack {
                Text("MONTHLY BUDGET")
                    .font(.caption)
                    .fontWeight(.bold)
                    .tracking(2)
                    .foregroundStyle(AppColor.accent.opacity(0.7))
                Spacer()
                Text("of \(totalBudget, format: .currency(code: currencyCode))")
                    .font(.caption2)
                    .foregroundStyle(AppColor.primaryText.opacity(0.4))
            }
            
            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 5)
                        .fill(AppColor.background)
                    RoundedRectangle(cornerRadius: 5)
                        .fill(barColor)
                        .frame(width: geo.size.width * animatedProgress)
                }
            }
            .frame(height: 8)
            
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text("Spent")
                        .font(.caption2)
                        .foregroundStyle(AppColor.primaryText.opacity(0.4))
                    Text(spent, format: .currency(code: currencyCode))
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .foregroundStyle(barColor)
                }
                Spacer()
                VStack(alignment: .trailing, spacing: 2) {
                    Text("Remaining")
                        .font(.caption2)
                        .foregroundStyle(AppColor.primaryText.opacity(0.4))
                    Text(remaining, format: .currency(code: currencyCode))
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .foregroundStyle(AppColor.accent)
                }
            }
        }
        .padding(24)
        .background(AppColor.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .padding(.horizontal)
        .onAppear {
            withAnimation(.easeOut(duration: 1.0)) {
                animatedProgress = progress
            }
        }
        .onChange(of: progress) { _, newValue in
            withAnimation(.easeOut(duration: 0.5)) {
                animatedProgress = newValue
            }
        }
    }
}

#Preview {
    ProgressRingView(progress: 0.72, totalBudget: 4500, spent: 3240, currencyCode: "AZN")
        .padding()
        .background(AppColor.background)
}
