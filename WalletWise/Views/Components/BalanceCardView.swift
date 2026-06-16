//
//  BalanceCardView.swift
//  WalletWise
//
//  Created by Aysel Mohbaliyeva on 16.06.26.
//

import SwiftUI

struct BalanceCardView: View {
    
    var balance: Double
    var income: Double
    var expense: Double
    var currencyCode: String
    
    @State private var animatedBalance: Double = 0
    @State private var hasAppeared = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text("MONTHLY BALANCE")
                .font(.caption)
                .fontWeight(.bold)
                .tracking(2)
                .foregroundStyle(AppColor.accent.opacity(0.7))
            
            Text(animatedBalance, format: .currency(code: currencyCode))
                .font(.system(size: 40, weight: .black, design: .rounded))
                .foregroundStyle(AppColor.accent)
                .contentTransition(.numericText(value: animatedBalance))
            
            HStack(spacing: 12) {
                statBox(title: "Income", amount: income, icon: "arrow.down", color: AppColor.accent)
                statBox(title: "Expense", amount: expense, icon: "arrow.up", color: .red)
            }
        }
        .padding(24)
        .frame(maxWidth: .infinity)
        .background(AppColor.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .accessibilityElement(children: .combine)
        .accessibilityLabel("Monthly balance \(balance, format: .currency(code: currencyCode)), income \(income, format: .currency(code: currencyCode)), expense \(expense, format: .currency(code: currencyCode))")
        .padding(.horizontal)
        .onAppear {
            guard !hasAppeared else { return }
            hasAppeared = true
            withAnimation(.easeOut(duration: 0.8)) {
                animatedBalance = balance
            }
        }
        .onChange(of: balance) { _, newValue in
            withAnimation(.easeOut(duration: 0.5)) {
                animatedBalance = newValue
            }
        }
    }
    
    private func statBox(title: String, amount: Double, icon: String, color: Color) -> some View {
        HStack(spacing: 8) {
            Image(systemName: icon)
                .font(.caption)
                .foregroundStyle(color)
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.caption2)
                    .foregroundStyle(AppColor.primaryText.opacity(0.5))
                Text(amount, format: .currency(code: currencyCode))
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundStyle(color)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(12)
        .background(AppColor.background)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    BalanceCardView(balance: 24850.42, income: 3000, expense: 1749.50, currencyCode: "USD")
        .padding()
        .background(AppColor.background)
}
