//
//  HomeView.swift
//  WalletWise
//
//  Created by Aysel Mohbaliyeva on 16.06.26.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Bindable var viewModel: WalletViewModel
    @State private var showAddTransaction = false
    @State private var showCurrencyPicker = false
    @State private var showCalendar = false
    @State private var showBudgetEditor = false
    @State private var budgetInput = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                AppColor.background
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 20) {
                        BalanceCardView(
                            balance: viewModel.balance,
                            income: viewModel.totalIncome,
                            expense: viewModel.totalExpense,
                            currencyCode: viewModel.currencyCode
                        )
                        
                        ProgressRingView(
                            progress: viewModel.budgetProgress,
                            totalBudget: viewModel.monthlyBudget,
                            spent: viewModel.monthlyExpense,
                            currencyCode: viewModel.currencyCode
                        ) {
                            budgetInput = String(format: "%.0f", viewModel.monthlyBudget)
                            showBudgetEditor = true
                        }
                        
                        transactionSection
                    }
                    .padding(.vertical)
                }
            }
            .navigationTitle("WalletWise")
            .preferredColorScheme(.dark)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        showCurrencyPicker = true
                    } label: {
                        Text(viewModel.selectedCurrency.symbol)
                            .font(.headline)
                            .foregroundStyle(AppColor.accent)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 4)
                            .background(AppColor.cardBackground)
                            .clipShape(Capsule())
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showAddTransaction = true
                    } label: {
                        Image(systemName: "plus")
                            .font(.body)
                            .fontWeight(.bold)
                            .foregroundStyle(AppColor.darkText)
                            .frame(width: 32, height: 32)
                            .background(AppColor.accent)
                            .clipShape(Circle())
                    }
                }
            }
            .sheet(isPresented: $showAddTransaction) {
                AddTransactionView(viewModel: viewModel)
            }
            .sheet(isPresented: $showCurrencyPicker) {
                CurrencyPickerView(selectedCurrency: $viewModel.selectedCurrency)
                    .presentationDetents([.medium])
            }
            .alert("Monthly Budget", isPresented: $showBudgetEditor) {
                TextField("Amount", text: $budgetInput)
                    .keyboardType(.decimalPad)
                Button("Save") {
                    let sanitized = budgetInput.replacingOccurrences(of: ",", with: ".")
                    if let value = Double(sanitized), value > 0 {
                        viewModel.monthlyBudget = value
                    }
                }
                Button("Cancel", role: .cancel) {}
            } message: {
                Text("Enter your monthly budget limit")
            }
            .onAppear {
                viewModel.loadTransactions(context: modelContext)
            }
            .onChange(of: showAddTransaction) { _, isShowing in
                if !isShowing {
                    viewModel.loadTransactions(context: modelContext)
                }
            }
        }
    }
    
    private var transactionSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("RECENT TRANSACTIONS")
                .font(.caption)
                .fontWeight(.bold)
                .tracking(2)
                .foregroundStyle(AppColor.accent.opacity(0.7))
                .padding(.horizontal, 24)
            
            if viewModel.transactions.isEmpty {
                VStack(spacing: 10) {
                    Image(systemName: "tray")
                        .font(.title)
                        .foregroundStyle(AppColor.primaryText.opacity(0.2))
                    Text("Tap + to add your first transaction")
                        .font(.caption)
                        .foregroundStyle(AppColor.primaryText.opacity(0.3))
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 40)
            } else {
                VStack(spacing: 0) {
                    ForEach(Array(viewModel.transactions.enumerated()), id: \.element.id) { index, transaction in
                        SwipeableRow {
                            TransactionRowView(
                                transaction: transaction,
                                currencyCode: viewModel.currencyCode,
                                animationDelay: Double(index) * 0.05
                            )
                        } onDelete: {
                            viewModel.deleteTransaction(transaction, context: modelContext)
                            viewModel.loadTransactions(context: modelContext)
                        }
                        if index < viewModel.transactions.count - 1 {
                            Divider()
                                .overlay(AppColor.primaryText.opacity(0.06))
                                .padding(.leading, 74)
                        }
                    }
                }
                .padding(.vertical, 8)
                .background(AppColor.cardBackground)
                .clipShape(RoundedRectangle(cornerRadius: 24))
                .padding(.horizontal)
            }
        }
    }
}

#Preview {
    HomeView(viewModel: WalletViewModel())
        .modelContainer(for: Transaction.self, inMemory: true)
}
