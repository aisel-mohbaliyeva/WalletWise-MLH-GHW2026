//
//  Category.swift
//  WalletWise
//
//  Created by Aysel Mohbaliyeva on 16.06.26.
//

import SwiftUI

enum Category: String, CaseIterable, Codable {
    case market = "Market"
    case restaurant = "Restaurant"
    case shopping = "Shopping"
    case education = "Education"
    case travel = "Travel"
    case bills = "Bills"
    case internet = "TV & Internet"
    case transport = "Transport"
    case pharmacy = "Pharmacy"
    case fuel = "Fuel"
    case sports = "Sports"
    case other = "Other"
    
    var icon: String {
        switch self {
        case .market: return "cart.fill"
        case .restaurant: return "fork.knife"
        case .shopping: return "bag.fill"
        case .education: return "graduationcap.fill"
        case .travel: return "airplane"
        case .bills: return "house.fill"
        case .internet: return "wifi"
        case .transport: return "bus.fill"
        case .pharmacy: return "pills.fill"
        case .fuel: return "fuelpump.fill"
        case .sports: return "figure.run"
        case .other: return "ellipsis.circle.fill"
        }
    }
    
    var color: Color {
        switch self {
        case .market: return .orange
        case .restaurant: return .red
        case .shopping: return .pink
        case .education: return .blue
        case .travel: return .cyan
        case .bills: return .yellow
        case .internet: return .teal
        case .transport: return .indigo
        case .pharmacy: return .green
        case .fuel: return .brown
        case .sports: return .mint
        case .other: return .gray
        }
    }
}
