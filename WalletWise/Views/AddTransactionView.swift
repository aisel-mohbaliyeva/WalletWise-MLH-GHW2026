//
//  AddTransactionView.swift
//  WalletWise
//
//  Created by Aysel Mohbaliyeva on 16.06.26.
//

import SwiftUI

struct AddTransactionView: View {
    
    @Environment(\.dismiss) private var dismiss
    var viewModel: WalletViewModel
    
    @State private var title = ""
    @State private var amount = ""
    @State private var category: Category = .food
    @State private var isIncome = false
    
    private var isFormValid: Bool {
        !title.isEmpty && Double(amount) != nil && Double(amount)! > 0
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Details") {
                    TextField("Title", text: $title)
                    TextField("Amount", text: $amount)
                        .keyboardType(.decimalPad)
                }
                
                Section("Type") {
                    Picker("Transaction Type", selection: $isIncome) {
                        Text("Expense").tag(false)
                        Text("Income").tag(true)
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Category") {
                    Picker("Category", selection: $category) {
                        ForEach(Category.allCases, id: \.self) { cat in
                            Label(cat.rawValue.capitalized, systemImage: cat.icon)
                                .tag(cat)
                        }
                    }
                }
            }
            .navigationTitle("Add Transaction")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        saveTransaction()
                    }
                    .disabled(!isFormValid)
                }
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
        
        viewModel.addTransaction(transaction)
        dismiss()
    }
}

#Preview {
    AddTransactionView(viewModel: WalletViewModel())
}
