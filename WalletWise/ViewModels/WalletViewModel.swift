//
//  WalletViewModel.swift
//  WalletWise
//
//  Created by Aysel Mohbaliyeva on 16.06.26.
//

import SwiftUI

@Observable
class WalletViewModel {
    
    var transactions: [Transaction] = []
    var monthlyBudget: Double = 1000.0
    
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
    
    var expensesByCategory: [Category: Double] {
        var result: [Category: Double] = [:]
        for transaction in transactions where !transaction.isIncome {
            result[transaction.category, default: 0] += transaction.amount
        }
        return result
    }
    
    func addTransaction(_ transaction: Transaction) {
        transactions.append(transaction)
    }
    
    func deleteTransaction(at offsets: IndexSet) {
        transactions.remove(atOffsets: offsets)
    }
}
