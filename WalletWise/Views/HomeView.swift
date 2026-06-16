//
//  HomeView.swift
//  WalletWise
//
//  Created by Aysel Mohbaliyeva on 16.06.26.
//

import SwiftUI

struct HomeView: View {
    
    @Bindable var viewModel: WalletViewModel
    @State private var showAddTransaction = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    BalanceCardView(
                        balance: viewModel.balance,
                        income: viewModel.totalIncome,
                        expense: viewModel.totalExpense
                    )
                    
                    ProgressRingView(
                        progress: viewModel.budgetProgress,
                        totalBudget: viewModel.monthlyBudget,
                        spent: viewModel.totalExpense
                    )
                    
                    transactionSection
                }
                .padding(.vertical)
            }
            .navigationTitle("WalletWise")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showAddTransaction = true
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.title3)
                    }
                }
            }
            .sheet(isPresented: $showAddTransaction) {
                AddTransactionView(viewModel: viewModel)
            }
        }
    }
    
    private var transactionSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Recent Transactions")
                .font(.headline)
                .padding(.horizontal)
            
            if viewModel.transactions.isEmpty {
                ContentUnavailableView(
                    "No Transactions",
                    systemImage: "tray",
                    description: Text("Tap + to add your first transaction")
                )
                .frame(height: 200)
            } else {
                LazyVStack(spacing: 0) {
                    ForEach(viewModel.transactions.sorted { $0.date > $1.date }) { transaction in
                        TransactionRowView(transaction: transaction)
                            .padding(.horizontal)
                        Divider()
                            .padding(.leading, 64)
                    }
                }
            }
        }
    }
}

#Preview {
    HomeView(viewModel: WalletViewModel())
}
