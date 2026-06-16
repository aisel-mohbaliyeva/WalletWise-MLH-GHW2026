//
//  TransactionRowView.swift
//  WalletWise
//
//  Created by Aysel Mohbaliyeva on 16.06.26.
//

import SwiftUI

struct TransactionRowView: View {
    
    var transaction: Transaction
    var animationDelay: Double = 0
    
    @State private var hasAppeared = false
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: transaction.category.icon)
                .font(.title3)
                .foregroundStyle(transaction.category.color)
                .frame(width: 40, height: 40)
                .background(transaction.category.color.opacity(0.15))
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 4) {
                Text(transaction.title)
                    .font(.subheadline)
                    .fontWeight(.medium)
                Text(transaction.category.rawValue.capitalized)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 4) {
                Text("\(transaction.isIncome ? "+" : "-")\(transaction.amount, format: .currency(code: "USD"))")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(transaction.isIncome ? .green : .red)
                Text(transaction.date, format: .dateTime.month().day())
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(.vertical, 8)
        .opacity(hasAppeared ? 1 : 0)
        .offset(x: hasAppeared ? 0 : 30)
        .onAppear {
            withAnimation(.easeOut(duration: 0.4).delay(animationDelay)) {
                hasAppeared = true
            }
        }
    }
}

#Preview {
    TransactionRowView(
        transaction: Transaction(
            title: "Grocery Shopping",
            amount: 45.99,
            category: .food,
            isIncome: false
        )
    )
    .padding()
}
