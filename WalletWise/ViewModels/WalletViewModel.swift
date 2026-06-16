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
        didSet {
            UserDefaults.standard.set(monthlyBudget, forKey: "monthlyBudget")
        }
    }

    var selectedCurrency: AppCurrency {
        didSet {
            if let data = try? JSONEncoder().encode(selectedCurrency) {
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

    var monthlyExpense: Double {
        let calendar = Calendar.current
        let now = Date()
        return transactions
            .filter { !$0.isIncome && calendar.isDate($0.date, equalTo: now, toGranularity: .month) }
            .reduce(0) { $0 + $1.amount }
    }

    var currentMonthTransactions: [Transaction] {
        let calendar = Calendar.current
        let now = Date()
        return transactions.filter {
            calendar.isDate($0.date, equalTo: now, toGranularity: .month)
        }
    }

    var balance: Double {
        totalIncome - totalExpense
    }

    var budgetProgress: Double {
        guard monthlyBudget > 0 else { return 0 }
        return min(monthlyExpense / monthlyBudget, 1.0)
    }

    var currencyCode: String {
        selectedCurrency.code
    }

    init() {
        let budget = UserDefaults.standard.double(forKey: "monthlyBudget")
        self.monthlyBudget = budget > 0 ? budget : 1000.0

        if let data = UserDefaults.standard.data(forKey: "selectedCurrency"),
           let decoded = try? JSONDecoder().decode(AppCurrency.self, from: data) {
            self.selectedCurrency = decoded
        } else {
            self.selectedCurrency = .defaultCurrency
        }
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
