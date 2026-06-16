//
//  Category.swift
//  WalletWise
//
//  Created by Aysel Mohbaliyeva on 16.06.26.
//

import SwiftUI

enum Category: String, CaseIterable, Codable {
    case food
    case transport
    case entertainment
    case shopping
    case bills
    case salary
    case freelance
    case other
    
    var icon: String {
        switch self {
        case .food: return "fork.knife"
        case .transport: return "car.fill"
        case .entertainment: return "gamecontroller.fill"
        case .shopping: return "bag.fill"
        case .bills: return "doc.text.fill"
        case .salary: return "banknote.fill"
        case .freelance: return "laptopcomputer"
        case .other: return "ellipsis.circle.fill"
        }
    }
    
    var color: Color {
        switch self {
        case .food: return .orange
        case .transport: return .blue
        case .entertainment: return .purple
        case .shopping: return .pink
        case .bills: return .red
        case .salary: return .green
        case .freelance: return .cyan
        case .other: return .gray
        }
    }
}
