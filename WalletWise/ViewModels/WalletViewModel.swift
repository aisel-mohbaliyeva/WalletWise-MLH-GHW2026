//
//  WalletViewModel.swift
//  WalletWise
//
//  Created by Aysel Mohbaliyeva on 16.06.26.
//

import SwiftUI
import SwiftData

@Observable
class WalletViewModel {
    
    var transactions: [Transaction] = []
    
    var monthlyBudget: Double {
        get { UserDefaults.standard.double(forKey: "monthlyBudget").nonZero ?? 1000.0 }
        set { UserDefaults.standard.set(newValue, forKey: "monthlyBudget") }
    }
    
    var selectedCurrency: AppCurrency {
        get {
            if let data = UserDefaults.standard.data(forKey: "selectedCurrency"),
               let decoded = try? JSONDecoder().decode(AppCurrency.self, from: data) {
                return decoded
            }
            return .defaultCurrency
        }
        set {
            if let data = try? JSONEncoder().encode(newValue) {
                UserDefaults.standard.set(data, forKey: "selectedCurrency")
            }
        }
    }
    
    var totalIncome: Double {
        transactions
            .filter { $0.isIncome }
            .reduce(0) { $0 + $1.amount }
    }
    
    var totalExpense: Double {
        transactions
            .filter { !$0.isIncome }
            .reduce(0) { $0 + $1.amount }
    }
    
    var balance: Double {
        totalIncome - totalExpense
    }
    
    var budgetProgress: Double {
        guard monthlyBudget > 0 else { return 0 }
        return min(totalExpense / monthlyBudget, 1.0)
    }
    
    var currencyCode: String {
        selectedCurrency.code
    }
    
    func addTransaction(_ transaction: Transaction, context: ModelContext) {
        context.insert(transaction)
        try? context.save()
    }
    
    func deleteTransaction(_ transaction: Transaction, context: ModelContext) {
        context.delete(transaction)
        try? context.save()
    }
    
    func loadTransactions(context: ModelContext) {
        let descriptor = FetchDescriptor<Transaction>(sortBy: [SortDescriptor(\.date, order: .reverse)])
        transactions = (try? context.fetch(descriptor)) ?? []
    }
}

private extension Double {
    var nonZero: Double? {
        self == 0 ? nil : self
    }
}
