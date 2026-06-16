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
    
    @State private var animatedBalance: Double = 0
    @State private var animatedIncome: Double = 0
    @State private var animatedExpense: Double = 0
    @State private var hasAppeared = false
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Current Balance")
                .font(.subheadline)
                .foregroundStyle(.secondary)
            
            Text(animatedBalance, format: .currency(code: "USD"))
                .font(.system(size: 40, weight: .bold, design: .rounded))
                .foregroundStyle(balance >= 0 ? .green : .red)
                .contentTransition(.numericText(value: animatedBalance))
            
            HStack(spacing: 32) {
                labeledAmount(title: "Income", amount: animatedIncome, color: .green, icon: "arrow.down.circle.fill")
                labeledAmount(title: "Expense", amount: animatedExpense, color: .red, icon: "arrow.up.circle.fill")
            }
        }
        .padding(24)
        .frame(maxWidth: .infinity)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .padding(.horizontal)
        .onAppear {
            guard !hasAppeared else { return }
            hasAppeared = true
            withAnimation(.easeOut(duration: 0.8)) {
                animatedBalance = balance
                animatedIncome = income
                animatedExpense = expense
            }
        }
        .onChange(of: balance) { _, newValue in
            withAnimation(.easeOut(duration: 0.5)) {
                animatedBalance = newValue
            }
        }
        .onChange(of: income) { _, newValue in
            withAnimation(.easeOut(duration: 0.5)) {
                animatedIncome = newValue
            }
        }
        .onChange(of: expense) { _, newValue in
            withAnimation(.easeOut(duration: 0.5)) {
                animatedExpense = newValue
            }
        }
    }
    
    private func labeledAmount(title: String, amount: Double, color: Color, icon: String) -> some View {
        HStack(spacing: 8) {
            Image(systemName: icon)
                .foregroundStyle(color)
                .font(.title3)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Text(amount, format: .currency(code: "USD"))
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .contentTransition(.numericText(value: amount))
            }
        }
    }
}

#Preview {
    BalanceCardView(balance: 1250.50, income: 3000, expense: 1749.50)
        .padding()
        .background(Color.black)
}
