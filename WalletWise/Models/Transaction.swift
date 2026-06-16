//
//  Transaction.swift
//  WalletWise
//
//  Created by Aysel Mohbaliyeva on 16.06.26.
//

import Foundation

struct Transaction: Identifiable, Codable {
    var id = UUID()
    var title: String
    var amount: Double
    var category: Category
    var isIncome: Bool
    var date = Date()
}
