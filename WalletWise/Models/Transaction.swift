//
//  Transaction.swift
//  WalletWise
//
//  Created by Aysel Mohbaliyeva on 16.06.26.
//

import Foundation
import SwiftData

@Model
final class Transaction {
    var id: UUID
    var title: String
    var amount: Double
    var category: Category
    var isIncome: Bool
    var date: Date
    
    init(title: String, amount: Double, category: Category, isIncome: Bool, date: Date = Date()) {
        self.id = UUID()
        self.title = title
        self.amount = amount
        self.category = category
        self.isIncome = isIncome
        self.date = date
    }
}
