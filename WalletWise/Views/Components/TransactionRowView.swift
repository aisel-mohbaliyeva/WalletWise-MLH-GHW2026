//
//  TransactionRowView.swift
//  WalletWise
//
//  Created by Aysel Mohbaliyeva on 16.06.26.
//

import SwiftUI

struct TransactionRowView: View {
    
    var transaction: Transaction
    var currencyCode: String
    var animationDelay: Double = 0
    
    @State private var hasAppeared = false
    
    var body: some View {
        HStack(spacing: 14) {
            Image(systemName: transaction.category.icon)
                .font(.body)
                .foregroundStyle(transaction.category.color)
                .frame(width: 44, height: 44)
                .background(transaction.category.color.opacity(0.12))
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 3) {
                Text(transaction.title)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(AppColor.primaryText)
                    .lineLimit(1)
                HStack(spacing: 4) {
                    Text(transaction.category.rawValue)
                        .font(.caption2)
                        .foregroundStyle(AppColor.primaryText.opacity(0.4))
                    Text("\u{00B7}")
                        .font(.caption2)
                        .foregroundStyle(AppColor.primaryText.opacity(0.3))
                    Text(transaction.date, format: .dateTime.month(.abbreviated).day())
                        .font(.caption2)
                        .foregroundStyle(AppColor.primaryText.opacity(0.3))
                }
            }
            
            Spacer()
            
            Text("\(transaction.isIncome ? "+" : "-")\(transaction.amount, format: .currency(code: currencyCode))")
                .font(.subheadline)
                .fontWeight(.bold)
                .foregroundStyle(transaction.isIncome ? AppColor.accent : .red)
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 16)
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(transaction.title), \(transaction.category.rawValue), \(transaction.isIncome ? "income" : "expense") \(transaction.amount, format: .currency(code: currencyCode))")
        .opacity(hasAppeared ? 1 : 0)
        .offset(x: hasAppeared ? 0 : 20)
        .onAppear {
            withAnimation(.easeOut(duration: 0.3).delay(animationDelay)) {
                hasAppeared = true
            }
        }
    }
}

#Preview {
    TransactionRowView(
        transaction: Transaction(title: "Starbucks", amount: 12.50, category: .restaurant, isIncome: false),
        currencyCode: "AZN"
    )
    .background(AppColor.cardBackground)
}
