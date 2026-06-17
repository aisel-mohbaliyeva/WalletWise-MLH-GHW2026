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
            do {
                let data = try JSONEncoder().encode(selectedCurrency)
                UserDefaults.standard.set(data, forKey: "selectedCurrency")
            } catch {
                print("Failed to encode currency: \(error.localizedDescription)")
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

    var monthlyIncome: Double {
        let calendar = Calendar.current
        let now = Date()
        return transactions
            .filter { $0.isIncome && calendar.isDate($0.date, equalTo: now, toGranularity: .month) }
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
        if UserDefaults.standard.object(forKey: "monthlyBudget") != nil {
            self.monthlyBudget = UserDefaults.standard.double(forKey: "monthlyBudget")
        } else {
            self.monthlyBudget = 1000.0
        }

        if let data = UserDefaults.standard.data(forKey: "selectedCurrency"),
           let decoded = try? JSONDecoder().decode(AppCurrency.self, from: data) {
            self.selectedCurrency = decoded
        } else {
            self.selectedCurrency = AppCurrency.defaultCurrency
        }
    }

    func addTransaction(_ transaction: Transaction, context: ModelContext) {
        context.insert(transaction)
        do {
            try context.save()
        } catch {
            print("Failed to save transaction: \(error.localizedDescription)")
        }
    }

    func deleteTransaction(_ transaction: Transaction, context: ModelContext) {
        context.delete(transaction)
        do {
            try context.save()
        } catch {
            print("Failed to delete transaction: \(error.localizedDescription)")
        }
    }

    func loadTransactions(context: ModelContext) {
        let descriptor = FetchDescriptor<Transaction>(sortBy: [SortDescriptor(\.date, order: .reverse)])
        do {
            transactions = try context.fetch(descriptor)
        } catch {
            transactions = []
            print("Failed to fetch transactions: \(error.localizedDescription)")
        }
    }
}
