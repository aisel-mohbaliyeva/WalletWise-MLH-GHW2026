//
//  AddTransactionView.swift
//  WalletWise
//
//  Created by Aysel Mohbaliyeva on 16.06.26.
//

import SwiftUI
import SwiftData

struct AddTransactionView: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    var viewModel: WalletViewModel
    
    @State private var title = ""
    @State private var amount = ""
    @State private var category: Category = .market
    @State private var isIncome = false
    
    private var isFormValid: Bool {
        !title.isEmpty && Double(amount) != nil && Double(amount)! > 0
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                AppColor.background
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 20) {
                        
                        // Amount
                        VStack(spacing: 10) {
                            Text("ENTER AMOUNT")
                                .font(.caption2)
                                .fontWeight(.bold)
                                .tracking(2)
                                .foregroundStyle(AppColor.accent.opacity(0.6))
                            
                            ZStack(alignment: .trailing) {
                                TextField("0.00", text: $amount)
                                    .keyboardType(.decimalPad)
                                    .font(.system(size: 48, weight: .black, design: .rounded))
                                    .foregroundStyle(AppColor.accent)
                                    .multilineTextAlignment(.center)

                                if !amount.isEmpty {
                                    Button {
                                        amount = ""
                                    } label: {
                                        Image(systemName: "xmark.circle.fill")
                                            .foregroundStyle(AppColor.primaryText.opacity(0.3))
                                    }
                                }
                            }
                        }
                        .padding(28)
                        .frame(maxWidth: .infinity)
                        .background(
                            LinearGradient(
                                colors: [AppColor.cardBackground, AppColor.cardBackground.opacity(0.6)],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 28)
                                .stroke(AppColor.accent.opacity(0.15), lineWidth: 1)
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 28))
                        .padding(.horizontal)
                        
                        // Details
                        VStack(alignment: .leading, spacing: 16) {
                            ZStack(alignment: .trailing) {
                                TextField("Merchant / Description", text: $title)
                                    .padding(16)
                                    .padding(.trailing, 32)
                                    .background(AppColor.background)
                                    .foregroundStyle(AppColor.primaryText)
                                    .clipShape(RoundedRectangle(cornerRadius: 14))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 14)
                                            .stroke(AppColor.primaryText.opacity(0.08), lineWidth: 1)
                                    )

                                if !title.isEmpty {
                                    Button {
                                        title = ""
                                    } label: {
                                        Image(systemName: "xmark.circle.fill")
                                            .foregroundStyle(AppColor.primaryText.opacity(0.3))
                                    }
                                    .padding(.trailing, 14)
                                }
                            }
                            
                            HStack(spacing: 10) {
                                typeButton(label: "Expense", isSelected: !isIncome) {
                                    isIncome = false
                                }
                                typeButton(label: "Income", isSelected: isIncome) {
                                    isIncome = true
                                }
                            }
                        }
                        .padding(20)
                        .background(AppColor.cardBackground)
                        .overlay(
                            RoundedRectangle(cornerRadius: 24)
                                .stroke(AppColor.primaryText.opacity(0.06), lineWidth: 1)
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 24))
                        .padding(.horizontal)
                        
                        // Category
                        VStack(alignment: .leading, spacing: 16) {
                            Text("SELECT CATEGORY")
                                .font(.caption2)
                                .fontWeight(.bold)
                                .tracking(2)
                                .foregroundStyle(AppColor.accent.opacity(0.6))
                            
                            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4), spacing: 16) {
                                ForEach(Category.allCases, id: \.self) { cat in
                                    categoryItem(cat)
                                }
                            }
                        }
                        .padding(20)
                        .background(AppColor.cardBackground)
                        .overlay(
                            RoundedRectangle(cornerRadius: 24)
                                .stroke(AppColor.primaryText.opacity(0.06), lineWidth: 1)
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 24))
                        .padding(.horizontal)
                        
                        // Save
                        Button {
                            saveTransaction()
                        } label: {
                            HStack(spacing: 8) {
                                Image(systemName: "checkmark.circle.fill")
                                Text("Save Transaction")
                                    .fontWeight(.bold)
                            }
                            .font(.body)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 18)
                            .background(isFormValid ? AppColor.accent : AppColor.cardBackground)
                            .foregroundStyle(isFormValid ? AppColor.darkText : AppColor.primaryText.opacity(0.2))
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .shadow(color: isFormValid ? AppColor.accent.opacity(0.3) : .clear, radius: 12, y: 4)
                        }
                        .disabled(!isFormValid)
                        .padding(.horizontal)
                        .padding(.top, 4)
                    }
                    .padding(.vertical)
                }
            }
            .navigationTitle("Add Transaction")
            .navigationBarTitleDisplayMode(.inline)
            .preferredColorScheme(.dark)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                        .foregroundStyle(AppColor.primaryText.opacity(0.6))
                }
            }
        }
    }
    
    private func typeButton(label: String, isSelected: Bool, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text(label)
                .font(.subheadline)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
                .background(isSelected ? AppColor.accent : AppColor.background)
                .foregroundStyle(isSelected ? AppColor.darkText : AppColor.primaryText.opacity(0.5))
                .clipShape(RoundedRectangle(cornerRadius: 14))
        }
    }
    
    private func categoryItem(_ cat: Category) -> some View {
        Button {
            category = cat
        } label: {
            VStack(spacing: 6) {
                Image(systemName: cat.icon)
                    .font(.title3)
                    .frame(width: 46, height: 46)
                    .background(category == cat ? cat.color : cat.color.opacity(0.15))
                    .foregroundStyle(category == cat ? .white : cat.color)
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(category == cat ? cat.color : .clear, lineWidth: 2)
                            .padding(-3)
                    )
                
                Text(cat.rawValue)
                    .font(.caption2)
                    .fontWeight(category == cat ? .bold : .regular)
                    .foregroundStyle(category == cat ? cat.color : AppColor.primaryText.opacity(0.5))
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)
            }
        }
    }
    
    private func saveTransaction() {
        guard let parsedAmount = Double(amount) else { return }
        let transaction = Transaction(
            title: title,
            amount: parsedAmount,
            category: category,
            isIncome: isIncome
        )
        viewModel.addTransaction(transaction, context: modelContext)
        dismiss()
    }
}

#Preview {
    AddTransactionView(viewModel: WalletViewModel())
        .modelContainer(for: Transaction.self, inMemory: true)
}
